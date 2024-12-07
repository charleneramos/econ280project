# -*- coding: utf-8 -*-
"""
@created: 11/10/15
@modified: 11/13/15
@author: michaelwebb
@desc: Generate CSV of publication counts for a given search query using PubMed.
Mesh terms to query: https://www.nlm.nih.gov/mesh/2015/mesh_browser/MeSHtree.C.html#link_id
Example command: python pubmedscraper.py "Neoplasms" --start 1961 --end 2015 --title allcancerstrials --trialsonly
@changes: removed progress bar
"""
#%%

import requests
import csv
import argparse

#%%

parser = argparse.ArgumentParser(description='Generate CSV of publication counts for a given search query using PubMed.')
parser.add_argument('query',
                   help='Query for PubMed')
parser.add_argument('--trialsonly',
                    dest='trialsonly',
                   action='store_true',
                   help='Only count clinical trials')             
parser.add_argument('--start',
                    type=int,
                   default=1960,
                   help='Start year')
parser.add_argument('--end',
                    type=int,
                   default=1965,
                   help='End year')
parser.add_argument('--title',
                   default='pubsbyyear',
                   help='Name for CVS file')                   
                   
args = parser.parse_args()
query = '"' + args.query + '"[Mesh]'
trials = args.trialsonly
startyear = args.start
endyear = args.end
filetitle = args.title

#%%
# Example query: "Neoplasms"[Mesh] AND (Clinical Trial[ptyp]) AND ("2010/01/01"[PDat] : "2010/12/31"[PDat])

if trials == 1:
    fullquery = query + ' AND (Clinical Trial[ptyp])'
    print 'Query being sent to PubMed: ' + fullquery
else:
    fullquery = query
    print 'Query being sent to PubMed: ' + fullquery

start = "http://webtools.mf.uni-lj.si/public/summarisenumbers.php?query="
search = "(" + fullquery + ")%20"
n = endyear-startyear+1

data = [['Year','Publications']]

for year in range(startyear,endyear+1):
    date = '("' + str(year) + '/01/01"[PDat] : "' + str(year) + '/12/31"[PDat])'
    pubs = requests.get(start+search+date).content
    data.append([year, pubs])

#%%

filename = filetitle + '.csv'
b = open(filename, 'w')
a = csv.writer(b)
a.writerows(data)
b.close()