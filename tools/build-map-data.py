# -*- coding: utf-8 -*-
"""Rebuild map-data.js: 64 district outlines as SVG paths.

Equirectangular projection with a cos(lat) correction so Bangladesh is not
stretched sideways, then Douglas-Peucker simplification so the file is a
reasonable size rather than five megabytes of coordinates.
"""
import json, math, io

VB_W, VB_H = 1000.0, 1180.0
TOL = 0.0032          # degrees; tuned for ~160KB output
MIN_RING_AREA = 1e-5  # drop slivers and tiny offshore islands

d = json.load(open('geo.json'))
feats = d['features']

lons=[]; lats=[]
for f in feats:
    for poly in f['geometry']['coordinates']:
        for ring in poly:
            for x,y in ring:
                lons.append(x); lats.append(y)
minx,maxx=min(lons),max(lons); miny,maxy=min(lats),max(lats)
midlat=(miny+maxy)/2
kx=math.cos(math.radians(midlat))          # shrink longitude at this latitude

w=(maxx-minx)*kx; h=(maxy-miny)
scale=min(VB_W/w, VB_H/h)*0.96
offx=(VB_W-w*scale)/2
offy=(VB_H-h*scale)/2

def project(x,y):
    px=(x-minx)*kx*scale+offx
    py=(maxy-y)*scale+offy                  # flip: SVG y grows downward
    return px,py

def perp(p,a,b):
    (x,y),(x1,y1),(x2,y2)=p,a,b
    dx,dy=x2-x1,y2-y1
    if dx==0 and dy==0: return math.hypot(x-x1,y-y1)
    t=((x-x1)*dx+(y-y1)*dy)/(dx*dx+dy*dy)
    t=max(0,min(1,t))
    return math.hypot(x-(x1+t*dx), y-(y1+t*dy))

def dp(pts,tol):
    if len(pts)<3: return pts
    dmax,idx=0,0
    for i in range(1,len(pts)-1):
        dist=perp(pts[i],pts[0],pts[-1])
        if dist>dmax: dmax,idx=dist,i
    if dmax>tol:
        return dp(pts[:idx+1],tol)[:-1]+dp(pts[idx:],tol)
    return [pts[0],pts[-1]]

def ring_area(ring):
    a=0
    for i in range(len(ring)-1):
        a+=ring[i][0]*ring[i+1][1]-ring[i+1][0]*ring[i][1]
    return abs(a)/2

BN={
 'Bagerhat':'বাগেরহাট','Bandarban':'বান্দরবান','Barguna':'বরগুনা','Barisal':'বরিশাল',
 'Bhola':'ভোলা','Bogra':'বগুড়া','Brahmanbaria':'ব্রাহ্মণবাড়িয়া','Chandpur':'চাঁদপুর',
 'Chapai Nawabganj':'চাঁপাইনবাবগঞ্জ','Chittagong':'চট্টগ্রাম','Chuadanga':'চুয়াডাঙ্গা',
 'Comilla':'কুমিল্লা','Cox\'s Bazar':'কক্সবাজার','Dhaka':'ঢাকা','Dinajpur':'দিনাজপুর',
 'Faridpur':'ফরিদপুর','Feni':'ফেনী','Gaibandha':'গাইবান্ধা','Gazipur':'গাজীপুর',
 'Gopalganj':'গোপালগঞ্জ','Habiganj':'হবিগঞ্জ','Jamalpur':'জামালপুর','Jessore':'যশোর',
 'Jhalokati':'ঝালকাঠি','Jhenaidah':'ঝিনাইদহ','Joypurhat':'জয়পুরহাট','Khagrachhari':'খাগড়াছড়ি',
 'Khulna':'খুলনা','Kishoreganj':'কিশোরগঞ্জ','Kurigram':'কুড়িগ্রাম','Kushtia':'কুষ্টিয়া',
 'Lakshmipur':'লক্ষ্মীপুর','Lalmonirhat':'লালমনিরহাট','Madaripur':'মাদারীপুর','Magura':'মাগুরা',
 'Manikganj':'মানিকগঞ্জ','Meherpur':'মেহেরপুর','Moulvibazar':'মৌলভীবাজার','Munshiganj':'মুন্সিগঞ্জ',
 'Mymensingh':'ময়মনসিংহ','Naogaon':'নওগাঁ','Narail':'নড়াইল','Narayanganj':'নারায়ণগঞ্জ',
 'Narsingdi':'নরসিংদী','Natore':'নাটোর','Netrakona':'নেত্রকোণা','Nilphamari':'নীলফামারী',
 'Noakhali':'নোয়াখালী','Pabna':'পাবনা','Panchagarh':'পঞ্চগড়','Patuakhali':'পটুয়াখালী',
 'Pirojpur':'পিরোজপুর','Rajbari':'রাজবাড়ী','Rajshahi':'রাজশাহী','Rangamati':'রাঙ্গামাটি',
 'Rangpur':'রংপুর','Satkhira':'সাতক্ষীরা','Shariatpur':'শরীয়তপুর','Sherpur':'শেরপুর',
 'Sirajganj':'সিরাজগঞ্জ','Sunamganj':'সুনামগঞ্জ','Sylhet':'সিলেট','Tangail':'টাঙ্গাইল',
 'Thakurgaon':'ঠাকুরগাঁও',
 # spelling variants used by this source
 'Brahamanbaria':'ব্রাহ্মণবাড়িয়া','Maulvibazar':'মৌলভীবাজার','Nawabganj':'চাঁপাইনবাবগঞ্জ',
}

out=[]; divisions=set()
for f in feats:
    name=f['properties']['ADM2_EN'].strip()
    div=f['properties']['ADM1_EN'].strip()
    divisions.add(div)
    parts=[]
    for poly in f['geometry']['coordinates']:
        for ring in poly:
            if ring_area(ring)<MIN_RING_AREA: continue
            simp=dp([tuple(c[:2]) for c in ring],TOL)
            if len(simp)<4: continue
            pts=[project(x,y) for x,y in simp]
            seg='M'+' L'.join('%.1f,%.1f'%p for p in pts)+'Z'
            parts.append(seg)
    if not parts: continue
    out.append({'n':name,'bn':BN.get(name,name),'dv':div,'d':''.join(parts)})

js=io.StringIO()
js.write('// Bangladesh district outlines, 64 features, ADM2.\n')
js.write('// Regenerated from nuhil/bangladesh-geocode districts.geojson.\n')
js.write('// Equirectangular with a cos(lat) correction so the country is not\n')
js.write('// stretched sideways, Douglas-Peucker simplified to keep the file small.\n')
js.write('window.DAAG_MAP_VIEWBOX="0 0 %d %d";\n'%(VB_W,VB_H))
js.write('window.DAAG_DIVISIONS=%s;\n'%json.dumps(sorted(divisions),ensure_ascii=False))
js.write('window.DAAG_DISTRICTS=[\n')
for i,r in enumerate(out):
    js.write(json.dumps(r,ensure_ascii=False,separators=(',',':')))
    js.write(',\n' if i<len(out)-1 else '\n')
js.write('];\n')
open('../../../../Projects/Daag_Bhaiya/map-data.js','w',encoding='utf-8').write(js.getvalue())
print('districts:',len(out))
print('missing bengali:',[r['n'] for r in out if r['bn']==r['n']])
print('divisions:',sorted(divisions))

# ---------------------------------------------------------------------------
# Usage
#   curl -sL -o geo.json \
#     https://raw.githubusercontent.com/nuhil/bangladesh-geocode/master/geojson/districts.geojson
#   python3 tools/build-map-data.py        # writes map-data.js
#
# Kept because map-data.js was deleted once and could not be recovered from git
# or from any deployment. Regenerating it took longer than it should have.
# ---------------------------------------------------------------------------
