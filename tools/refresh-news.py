#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Re-verify the footer news list against the publishers.

    python3 tools/refresh-news.py            # check the current list is still live
    python3 tools/refresh-news.py --rebuild  # re-read every headline and date

The list in index.html is a verified snapshot, not a live feed. That is a
deliberate choice: both papers publish general-news RSS, and when this was
built only 4 of 167 items across every available feed were about gender
violence. A live feed would have left the section empty most days.

So the list is curated and checked. What this script guarantees is that every
URL still resolves and that the headline and date shown on daag-bd.com are the
ones the publisher actually printed -- never a search snippet, never a
paraphrase, never anything written here.

Daily Star keeps the article date in a "Published :" label; the <time> tags on
those pages belong to the sidebar, so reading them would stamp every story with
today's date. Prothom Alo uses article:published_time.
"""
import json, re, html, io, os, subprocess, sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
STORE = os.path.join(ROOT, 'tools', 'news-sources.json')
UA = ('Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 '
      '(KHTML, like Gecko) Chrome/120 Safari/537.36')
MONTHS = {m: i + 1 for i, m in enumerate(
    ['January','February','March','April','May','June','July',
     'August','September','October','November','December'])}


def fetch(url):
    r = subprocess.run(['curl', '-sL', '--max-time', '40', '-A', UA,
                        '-w', '\n@@%{http_code}@@%{url_effective}@@', url],
                       capture_output=True, text=True)
    m = re.search(r'@@(\d+)@@(.*?)@@\s*$', r.stdout)
    if not m:
        return 0, url, ''
    return int(m.group(1)), m.group(2), r.stdout[:m.start()]


def head(b):
    i = b.lower().find('</head>')
    return b[:i + 7] if i > 0 else b[:300000]


def meta(h, *names):
    for n in names:
        for tag in re.findall(r'<meta\b[^>]*>', h, re.I):
            if re.search(r'(?:property|name)\s*=\s*["\']%s["\']' % re.escape(n), tag, re.I):
                c = re.search(r'content\s*=\s*["\'](.*?)["\']', tag, re.S | re.I)
                if c and c.group(1).strip():
                    return html.unescape(c.group(1)).strip()
    return ''


def read(url):
    code, final, body = fetch(url)
    if code != 200 or not body:
        return None, 'http %s' % code
    h = head(body)
    title = meta(h, 'og:title', 'twitter:title')
    if not title:
        m = re.search(r'<title[^>]*>(.*?)</title>', h, re.S | re.I)
        title = html.unescape(re.sub(r'<[^>]+>', '', m.group(1))).strip() if m else ''
    title = re.sub(r'\s+', ' ', title)
    title = re.sub(r'\s*[|–-]\s*(The Daily Star|Prothom Alo|প্রথম আলো)\s*$', '', title).strip()
    date = meta(h, 'article:published_time', 'publish-date')
    if not date:
        m = re.search(r'Published\s*:\s*(?:<[^>]+>\s*)*(\d{1,2})\s+([A-Z][a-z]+),?\s+(\d{4})', body)
        if m and m.group(2) in MONTHS:
            date = '%s-%02d-%02d' % (m.group(3), MONTHS[m.group(2)], int(m.group(1)))
    if not title:
        return None, 'no headline'
    return {'url': final or url, 'title': title, 'date': (date or '')[:10],
            'src': 'The Daily Star' if 'thedailystar' in (final or url) else 'Prothom Alo',
            'lang': 'bn' if re.match(r'https://www\.prothomalo\.com', final or url) else 'en'}, None


def main():
    rebuild = '--rebuild' in sys.argv
    rows = json.load(io.open(STORE, encoding='utf-8'))
    out, dead, changed = [], [], []
    for i, r in enumerate(rows, 1):
        fresh, err = read(r['url'])
        if err:
            dead.append((r['url'], err))
            print('%3d  DEAD  %-12s %s' % (i, err, r['url'][:76]))
            continue
        if fresh['title'] != r['title'] or fresh['date'] != (r.get('date') or '')[:10]:
            changed.append((r['title'], fresh['title']))
        out.append(fresh if rebuild else dict(r, title=fresh['title'], date=fresh['date']))
        print('%3d  ok    %-14s %s  %s' % (i, fresh['src'][:14], fresh['date'] or '----------',
                                           fresh['title'][:54]))
    print('\nlive %d, dead %d, changed %d' % (len(out), len(dead), len(changed)))
    for a, b in changed:
        print('  was: %s\n  now: %s' % (a[:88], b[:88]))
    if rebuild:
        json.dump(out, io.open(STORE, 'w', encoding='utf-8'), ensure_ascii=False, indent=1)
        print('\nwrote %s -- now paste the 50 newest into NEWS[] in index.html' % STORE)
    return 1 if dead else 0


if __name__ == '__main__':
    sys.exit(main())
