const crypto = require('crypto');

// In-memory token cache (persists across warm Vercel invocations)
let tokenCache = { token: null, expiresAt: 0 };

function base64url(buf) {
  return Buffer.from(buf).toString('base64')
    .replace(/\+/g, '-').replace(/\//g, '_').replace(/=+$/, '');
}

async function getAccessToken(clientEmail, privateKey) {
  const now = Math.floor(Date.now() / 1000);

  // Return cached token if still valid (50-min TTL, tokens last 60 min)
  if (tokenCache.token && tokenCache.expiresAt > now + 60) {
    return tokenCache.token;
  }

  // Build JWT
  const header = base64url(JSON.stringify({ alg: 'RS256', typ: 'JWT' }));
  const payload = base64url(JSON.stringify({
    iss: clientEmail,
    scope: 'https://www.googleapis.com/auth/analytics.readonly',
    aud: 'https://oauth2.googleapis.com/token',
    iat: now,
    exp: now + 3600
  }));

  const signInput = header + '.' + payload;
  const sign = crypto.createSign('RSA-SHA256');
  sign.update(signInput);
  const signature = base64url(sign.sign(privateKey));

  const jwt = signInput + '.' + signature;

  // Exchange JWT for access token
  const res = await fetch('https://oauth2.googleapis.com/token', {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: 'grant_type=urn%3Aietf%3Aparams%3Aoauth%3Agrant-type%3Ajwt-bearer&assertion=' + jwt
  });

  if (!res.ok) {
    const err = await res.text();
    throw new Error('Token exchange failed: ' + err);
  }

  const data = await res.json();
  tokenCache.token = data.access_token;
  tokenCache.expiresAt = now + 3000; // ~50 min
  return data.access_token;
}

function buildReportRequest(propertyId) {
  const today = new Date();
  const endDate = today.toISOString().split('T')[0];

  const start28 = new Date(today);
  start28.setDate(start28.getDate() - 27);
  const startDate = start28.toISOString().split('T')[0];

  const prev28End = new Date(start28);
  prev28End.setDate(prev28End.getDate() - 1);
  const prevEnd = prev28End.toISOString().split('T')[0];

  const prev28Start = new Date(prev28End);
  prev28Start.setDate(prev28Start.getDate() - 27);
  const prevStart = prev28Start.toISOString().split('T')[0];

  return {
    requests: [
      // Report 0: Overview metrics with comparison
      {
        dateRanges: [
          { startDate, endDate },
          { startDate: prevStart, endDate: prevEnd }
        ],
        metrics: [
          { name: 'totalUsers' },
          { name: 'screenPageViews' },
          { name: 'sessions' },
          { name: 'averageSessionDuration' },
          { name: 'bounceRate' }
        ]
      },
      // Report 1: Daily visitors (28 days)
      {
        dateRanges: [{ startDate, endDate }],
        dimensions: [{ name: 'date' }],
        metrics: [{ name: 'totalUsers' }],
        orderBys: [{ dimension: { dimensionName: 'date' } }]
      },
      // Report 2: Top 10 pages
      {
        dateRanges: [{ startDate, endDate }],
        dimensions: [{ name: 'pagePath' }],
        metrics: [{ name: 'screenPageViews' }],
        orderBys: [{ metric: { metricName: 'screenPageViews' }, desc: true }],
        limit: '10'
      },
      // Report 3: Top 8 traffic sources
      {
        dateRanges: [{ startDate, endDate }],
        dimensions: [{ name: 'sessionSource' }],
        metrics: [{ name: 'sessions' }],
        orderBys: [{ metric: { metricName: 'sessions' }, desc: true }],
        limit: '8'
      },
      // Report 4: Top 8 countries
      {
        dateRanges: [{ startDate, endDate }],
        dimensions: [{ name: 'country' }],
        metrics: [{ name: 'totalUsers' }],
        orderBys: [{ metric: { metricName: 'totalUsers' }, desc: true }],
        limit: '8'
      }
    ]
  };
}

function transformResponse(batchResponse) {
  const reports = batchResponse.reports || [];

  // Report 0: Overview
  const overviewReport = reports[0];
  const currentRow = overviewReport?.rows?.[0];
  const prevRow = overviewReport?.rows?.[1];

  function metricVal(row, idx) {
    return parseFloat(row?.metricValues?.[idx]?.value || '0');
  }

  function pctChange(current, previous) {
    if (previous === 0) return current > 0 ? 100 : 0;
    return Math.round(((current - previous) / previous) * 100);
  }

  const overview = {
    visitors: metricVal(currentRow, 0),
    visitorsChange: pctChange(metricVal(currentRow, 0), metricVal(prevRow, 0)),
    pageViews: metricVal(currentRow, 1),
    pageViewsChange: pctChange(metricVal(currentRow, 1), metricVal(prevRow, 1)),
    sessions: metricVal(currentRow, 2),
    sessionsChange: pctChange(metricVal(currentRow, 2), metricVal(prevRow, 2)),
    avgDuration: metricVal(currentRow, 3),
    avgDurationChange: pctChange(metricVal(currentRow, 3), metricVal(prevRow, 3)),
    bounceRate: metricVal(currentRow, 4),
    bounceRateChange: pctChange(metricVal(currentRow, 4), metricVal(prevRow, 4))
  };

  // Report 1: Daily visitors
  const dailyReport = reports[1];
  const daily = (dailyReport?.rows || []).map(function(row) {
    return {
      date: row.dimensionValues[0].value,
      visitors: parseInt(row.metricValues[0].value, 10)
    };
  });

  // Report 2: Top pages
  const pagesReport = reports[2];
  const pages = (pagesReport?.rows || []).map(function(row) {
    return {
      path: row.dimensionValues[0].value,
      views: parseInt(row.metricValues[0].value, 10)
    };
  });

  // Report 3: Traffic sources
  const sourcesReport = reports[3];
  const sources = (sourcesReport?.rows || []).map(function(row) {
    return {
      source: row.dimensionValues[0].value,
      sessions: parseInt(row.metricValues[0].value, 10)
    };
  });

  // Report 4: Countries
  const countriesReport = reports[4];
  const countries = (countriesReport?.rows || []).map(function(row) {
    return {
      country: row.dimensionValues[0].value,
      visitors: parseInt(row.metricValues[0].value, 10)
    };
  });

  return { overview, daily, pages, sources, countries };
}

module.exports = async function handler(req, res) {
  // CORS
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  if (req.method === 'OPTIONS') {
    return res.status(204).end();
  }

  if (req.method !== 'GET') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  const propertyId = process.env.GA_PROPERTY_ID;
  const clientEmail = process.env.GOOGLE_CLIENT_EMAIL;
  const privateKey = (process.env.GOOGLE_PRIVATE_KEY || '').replace(/\\n/g, '\n');

  if (!propertyId || !clientEmail || !privateKey) {
    return res.status(500).json({
      error: 'Missing environment variables. Set GA_PROPERTY_ID, GOOGLE_CLIENT_EMAIL, and GOOGLE_PRIVATE_KEY.'
    });
  }

  try {
    const accessToken = await getAccessToken(clientEmail, privateKey);

    const reportBody = buildReportRequest(propertyId);

    const gaRes = await fetch(
      'https://analyticsdata.googleapis.com/v1beta/properties/' + propertyId + ':batchRunReports',
      {
        method: 'POST',
        headers: {
          'Authorization': 'Bearer ' + accessToken,
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(reportBody)
      }
    );

    if (!gaRes.ok) {
      const errText = await gaRes.text();
      console.error('GA API error:', errText);
      return res.status(502).json({ error: 'Google Analytics API error', details: errText });
    }

    const batchData = await gaRes.json();
    const result = transformResponse(batchData);

    // CDN caching: 5 min fresh, 10 min stale-while-revalidate
    res.setHeader('Cache-Control', 's-maxage=300, stale-while-revalidate=600');
    return res.status(200).json(result);
  } catch (err) {
    console.error('Analytics API error:', err);
    return res.status(500).json({ error: err.message });
  }
};
