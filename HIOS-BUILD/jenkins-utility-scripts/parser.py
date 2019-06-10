#!/usr/bin/python
from bs4 import BeautifulSoup
from sys import argv
import re
import os
import urllib
import sys

module = sys.argv[1]
#os.system('wget https://calt.cms.gov/svn/repos/svnhios/%s/branches -O /opt/jenkins/indexes/%s.html --quiet'% (module, module))
url1="https://calt.cms.gov/svn/repos/svnhios/" + module + "/branches/"
os.system('curl -i -H \'Accept:application/text\' -H \'Authorization:Basic QTA1NjQyNTpSYWpASElPU0AyMDE3MDQ=\' %s -o /opt/jenkins/indexes/%s.html'%(url1, module))
#NOTE: base64 hash above needs to be updated when changing SVN credentials on server

txt = open("/opt/jenkins/indexes/%s.html" %module)

html = txt.read()

#html = the HTML code you've written above
soup = BeautifulSoup(html)
#print soup
liTag = soup.findAll('li')
#liTag.findAll('a')['href'].strip("/")
branches = list()
for line in liTag:  
    branches.append(line.find('a')['href'].strip("/"))
f = open('/opt/jenkins/branches//%s-branches.txt' % module, 'w+')
for branch in branches:
    if (re.match('DCMMC_4_0_BRANCH',branch) or re.match('DEV',branch)):
        f.write(branch + "\n")
f.close()
