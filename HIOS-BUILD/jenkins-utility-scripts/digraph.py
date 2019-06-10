#!/usr/local/bin/python2.7
import networkx as nx
import sys
#import sqlite3 as lite
import subprocess
import matplotlib.pyplot as plt

G=nx.DiGraph()
G.add_node('DATA-CORE')

G.add_node('HIOS-API')
G.add_edge('HIOS-API','DATA-CORE')
G.add_edge('HIOS-API','HIOS-PE-DATA-COMMON')

G.add_node('HIOS-API-DATA')
G.add_edge('HIOS-API-DATA','HIOS-PE-DATA-COMMON')

G.add_node('HIOS-ASSISTER-DATA')
G.add_edge('HIOS-ASSISTER-DATA','DATA-CORE')
G.add_edge('HIOS-ASSISTER-DATA','HIOS-COMMON')

G.add_node('HIOS-ASSISTER-UI')
G.add_edge('HIOS-COMMON-UI','DATA-CORE')
G.add_edge('HIOS-COMMON-UI','HIOS-COMMON')
G.add_edge('HIOS-COMMON-UI','HIOS-GLOBAL-DATA')
G.add_edge('HIOS-COMMON-UI','HIOS-ASSISTER-DATA')

G.add_node('HIOS-CCS-DATA')
G.add_edge('HIOS-CCS-DATA','DATA-CORE')
G.add_edge('HIOS-CCS-DATA','HIOS-COMMON')
G.add_edge('HIOS-CCS-DATA','HIOS-GLOBAL-DATA-CLIENT')
  
G.add_node('HIOS-CCS-UI')
G.add_edge('HIOS-CCS-UI','DATA-CORE')
G.add_edge('HIOS-CCS-UI','HIOS-COMMON')
G.add_edge('HIOS-CCS-UI','HIOS-COMMON-UI')
G.add_edge('HIOS-CCS-UI','HIOS-GLOBAL-DATA')

G.add_node('HIOS-COMMON')

G.add_node('HIOS-COMMON-UI')
G.add_edge('HIOS-COMMON-UI','HIOS-MAIN-DATA')
G.add_edge('HIOS-COMMON-UI','DATA-CORE')
G.add_edge('HIOS-COMMON-UI','HIOS-GLOBAL-DATA')
G.add_edge('HIOS-COMMON-UI','HIOS-COMMON')

G.add_node('HIOS-DCM-FF-DATA')
G.add_edge('HIOS-DCM-FF-DATA','DATA-CORE')
G.add_edge('HIOS-DCM-FF-DATA','HIOS-COMMON')

G.add_node('HIOS-DCM-FF-UI')
G.add_edge('HIOS-DCM-FF-UI','HIOS-COMMON-UI')
G.add_edge('HIOS-DCM-FF-UI','HIOS-DCM-FF-DATA')
G.add_edge('HIOS-DCM-FF-UI','DATA-CORE')
G.add_edge('HIOS-DCM-FF-UI','HIOS-COMMON')
G.add_edge('HIOS-DCM-FF-UI','HIOS-DOC-MGMT')

G.add_node('HIOS-DCMFFM-DATA')
G.add_edge('HIOS-DCMFFM-DATA','DATA-CORE')
G.add_edge('HIOS-DCMFFM-DATA','HIOS-COMMON')

G.add_node('HIOS-DCMFFM-UI')
G.add_edge('HIOS-DCMFFM-UI','HIOS-COMMON-UI')
G.add_edge('HIOS-DCMFFM-UI','HIOS-MAIN-DATA')
G.add_edge('HIOS-DCMFFM-UI','DATA-CORE')
G.add_edge('HIOS-DCMFFM-UI','HIOS-COMMON')
G.add_edge('HIOS-DCMFFM-UI','HIOS-GLOBAL-DATA')
G.add_edge('HIOS-DCMFFM-UI','HIOS-DCMFFM-DATA')

G.add_node('HIOS-DCM-MC-DATA')
G.add_edge('HIOS-DCM-MC-DATA','DATA-CORE')
G.add_edge('HIOS-DCM-MC-DATA','HIOS-COMMON')
G.add_edge('HIOS-DCM-MC-DATA','HIOS-COMMON-UI')

G.add_node('HIOS-DCM-MC-UI')
G.add_edge('HIOS-DCM-MC-UI','HIOS-COMMON-UI')
G.add_edge('HIOS-DCM-MC-UI','DATA-CORE')
G.add_edge('HIOS-DCM-MC-UI','HIOS-GLOBAL-DATA')
G.add_edge('HIOS-DCM-MC-UI','HIOS-DCM-MC-DATA')

G.add_node('HIOS-DOC-MGMT')
G.add_edge('HIOS-DOC-MGMT','DATA-CORE')
G.add_edge('HIOS-DOC-MGMT','HIOS-COMMON')

G.add_node('HIOS-ERE-DATA')
G.add_edge('HIOS-ERE-DATA','DATA-CORE')
G.add_edge('HIOS-ERE-DATA','HIOS-COMMON')

G.add_node('HIOS-ERE-UI')
G.add_edge('HIOS-ERE-UI','HIOS-COMMON-UI')
G.add_edge('HIOS-ERE-UI','DATA-CORE')
G.add_edge('HIOS-ERE-UI','HIOS-COMMON')
G.add_edge('HIOS-ERE-UI','HIOS-GLOBAL-DATA')
G.add_edge('HIOS-ERE-UI','HIOS-ERE-DATA')

G.add_node('HIOS-ESB-BGM')
G.add_edge('HIOS-ESB-BGM','HIOS-COMMON')
G.add_edge('HIOS-ESB-BGM','DATA-CORE')

G.add_node('HIOS-FFE-MAIN-UI')
G.add_edge('HIOS-FFE-MAIN-UI','HIOS-COMMON-UI')
G.add_edge('HIOS-FFE-MAIN-UI','HIOS-MAIN-DATA')
G.add_edge('HIOS-FFE-MAIN-UI','DATA-CORE')
G.add_edge('HIOS-FFE-MAIN-UI','HIOS-COMMON')
G.add_edge('HIOS-FFE-MAIN-UI','HIOS-GLOBAL-DATA')

G.add_node('HIOS-GLOBAL-DATA')
G.add_edge('HIOS-GLOBAL-DATA','DATA-CORE')
G.add_edge('HIOS-GLOBAL-DATA','HIOS-COMMON')

G.add_node('HIOS-INTERNAL-WS')
G.add_edge('HIOS-INTERNAL-WS','HIOS-INTERNAL-WS-DATA')
G.add_edge('HIOS-INTERNAL-WS','DATA-CORE')
G.add_edge('HIOS-INTERNAL-WS','HIOS-COMMON')

G.add_node('HIOS-INTERNAL-WS-DATA')
G.add_edge('HIOS-INTERNAL-WS-DATA','DATA-CORE')
G.add_edge('HIOS-INTERNAL-WS-DATA','HIOS-COMMON')

G.add_node('HIOS-MAIN-DATA')
G.add_edge('HIOS-MAIN-DATA','DATA-CORE')
G.add_edge('HIOS-MAIN-DATA','HIOS-COMMON')

G.add_node('HIOS-MAIN-UI')
G.add_edge('HIOS-MAIN-UI','HIOS-COMMON-UI')
G.add_edge('HIOS-MAIN-UI','HIOS-MAIN-DATA')
G.add_edge('HIOS-MAIN-UI','DATA-CORE')
G.add_edge('HIOS-MAIN-UI','HIOS-COMMON')
G.add_edge('HIOS-MAIN-UI','HIOS-GLOBAL-DATA')

G.add_node('HIOS-MEC-DATA')
G.add_edge('HIOS-MEC-DATA','DATA-CORE')
G.add_edge('HIOS-MEC-DATA','HIOS-COMMON')

G.add_node('HIOS-MEC-UI')
G.add_edge('HIOS-MEC-UI','HIOS-COMMON-UI')
G.add_edge('HIOS-MEC-UI','DATA-CORE')
G.add_edge('HIOS-MEC-UI','HIOS-COMMON')
G.add_edge('HIOS-MEC-UI','HIOS-GLOBAL-DATA')
G.add_edge('HIOS-MEC-UI','HIOS-MEC-DATA')

G.add_node('HIOS-MQM-DATA')
G.add_edge('HIOS-MQM-DATA','DATA-CORE')
G.add_edge('HIOS-MQM-DATA','HIOS-COMMON')

G.add_node('HIOS-MQM-ESB-BGM')
G.add_edge('HIOS-MQM-ESB-BGM','HIOS-COMMON')

G.add_node('HIOS-MQM-UI')
G.add_edge('HIOS-MQM-UI','HIOS-COMMON-UI')
G.add_edge('HIOS-MQM-UI','DATA-CORE')
G.add_edge('HIOS-MQM-UI','HIOS-COMMON')
G.add_edge('HIOS-MQM-UI','HIOS-GLOBAL-DATA')
G.add_edge('HIOS-MQM-UI','HIOS-MQM-DATA')
G.add_edge('HIOS-MQM-UI','HIOS-DOC-MGMT')

G.add_node('HIOS-NONFED-DATA')
G.add_edge('HIOS-NONFED-DATA','DATA-CORE')
G.add_edge('HIOS-NONFED-DATA','HIOS-COMMON')

G.add_node('HIOS-NONFED-UI')
G.add_edge('HIOS-NONFED-UI','HIOS-COMMON-UI')
G.add_edge('HIOS-NONFED-UI','DATA-CORE')
G.add_edge('HIOS-NONFED-UI','HIOS-COMMON')
G.add_edge('HIOS-NONFED-UI','HIOS-GLOBAL-DATA')
G.add_edge('HIOS-NONFED-UI','HIOS-NONFED-DATA')

G.add_node('HIOS-PLAN-FINDER-DATA')
G.add_edge('HIOS-PLAN-FINDER-DATA','DATA-CORE')
G.add_edge('HIOS-PLAN-FINDER-DATA','HIOS-COMMON')

G.add_node('HIOS-PLAN-FINDER-UI')
G.add_edge('HIOS-PLAN-FINDER-UI','HIOS-PLAN-FINDER-DATA')
G.add_edge('HIOS-PLAN-FINDER-UI','DATA-CORE')
G.add_edge('HIOS-PLAN-FINDER-UI','HIOS-COMMON')
G.add_edge('HIOS-PLAN-FINDER-UI','HIOS-GLOBAL-DATA')

G.add_node('HIOS-RBIS-DATA')
G.add_edge('HIOS-RBIS-DATA','DATA-CORE')

G.add_node('HIOS-RBIS-ESB-BGM')
G.add_edge('HIOS-RBIS-ESB-BGM','HIOS-RBIS-DATA')
G.add_edge('HIOS-RBIS-ESB-BGM','HIOS-RBIS-PE-DATA')
G.add_edge('HIOS-RBIS-ESB-BGM','DATA-CORE')
G.add_edge('HIOS-RBIS-ESB-BGM','HIOS-PE-DATA-COMMON')

G.add_node('HIOS-RBIS-PE')
G.add_edge('HIOS-RBIS-PE','HIOS-PE-DATA-COMMON')
G.add_edge('HIOS-RBIS-PE','DATA-CORE')

G.add_node('HIOS-RBIS-PE-DATA')
G.add_edge('HIOS-RBIS-PE-DATA','HIOS-PE-DATA-COMMON')
G.add_edge('HIOS-RBIS-PE-DATA','DATA-CORE')

G.add_node('HIOS-RBIS-UI')
G.add_edge('HIOS-RBIS-UI','DATA-CORE')
G.add_edge('HIOS-RBIS-UI','HIOS-PE-DATA-COMMON')



G.add_node('HIOS-PORTAL-DATA')
G.add_edge('HIOS-PORTAL-DATA','HIOS-COMMON')
G.add_edge('HIOS-PORTAL-DATA','DATA-CORE')


G.add_node('HIOS-PORTAL')
G.add_edge('HIOS-PORTAL','HIOS-COMMON-UI')
G.add_edge('HIOS-PORTAL','HIOS-GLOBAL-DATA')
G.add_edge('HIOS-PORTAL','HIOS-PORTAL-DATA')
G.add_edge('HIOS-PORTAL','HIOS-MAIN-DATA')


print G.number_of_nodes()

#G.add_path(['DATA-CORE','HIOS-COMMON','HIOS-COMMON-UI'])

#upstream = G.successors('HIOS-API')
#print upstream

#print "**"

#downstream = G.predecessors('DATA-CORE')
#print downstream

order=set()
length = len(sys.argv)
i = 1
print G.degree(sys.argv[i])
print G.degree(sys.argv[2])
print nx.ancestors(G, sys.argv[i])
print nx.ancestors(G,sys.argv[2])
print len(nx.ancestors(G, sys.argv[i]))
print len(nx.ancestors(G,sys.argv[2]))
print "ancestors^^"

print "**"
print sys.argv[1]
print nx.topological_sort_recursive(G,nx.ancestors(G,sys.argv[i]))
print "&&&&&&&&&&&&&&&&&&&&&&&"
print sys.argv[2]
print nx.topological_sort_recursive(G,nx.ancestors(G,sys.argv[2]))
print len(nx.topological_sort(G,nx.ancestors(G,sys.argv[i])))
print "^^^^^^^^^^^^^^^^^^^^^^^^^^"
depends=[]
while(i < length):
  order = nx.topological_sort_recursive(G,nx.ancestors(G,sys.argv[i]))
  for o in order:
    depends.append(o)
  i = i + 1

print "**********************"
#print len(nx.topological_sort_recursive(G,nx.ancestors(G,sys.argv[i])))
print "**"
allDeps =[]

while(i < length):
  order.append(nx.topological_sort_recursive(G,nx.ancestors(G,sys.argv[i])))
  i = i + 1

while(i < length):
  allDeps.append(sys.argv[i])
  deps =  G.predecessors(sys.argv[i])
#  print len(deps)
#  print "^len of deps"
  deps2 = G.successors_iter(sys.argv[i])
  for k in deps:
    if k:
      allDeps.append(k)
    dep3 = G.predecessors_iter(k)
    for d in dep3:
      if G.predecessors(d):
        allDeps.append(G.predecessors(d))
#      print G.predecessors(d)
#      print d
    #print "preds of %s: %s" % (k, G.predecessors(k))
    #print ("DEGREE: %s" % G.degree(k))
  #for j in deps2:
    #print "successors of %s: %s" % (j, G.successors(j))
  i = i + 1
#  dep.strip('[]')

#dependencies = G.predecessors_iter('HIOS-COMMON-UI')
#dependencies2 = G.predecessors('HIOS-COMMON-UI')
#print dependencies2
#print "**"
#print allDeps
#print "**"
#for i in dependencies:
#  dependencies = G.predecessors(i)

#print dependencies

subprocess.call(['./db.sh', 'mer'])

print order

print "!@#$%R^"
print depends

print nx.has_path(G,'HIOS-MAIN-DATA','DATA-CORE')
print "**"
