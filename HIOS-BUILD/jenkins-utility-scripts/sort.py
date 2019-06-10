#!/usr/bin/python

class Module(object):
  def __init__(mod, name, value):
	mod.name = name
	mod.value = value
  def __repr__(mod):
	return "<module: %s, value: %s>" % (mod.name, mod.value)

def byValue_key(module):
  return module.value

mod1 = Module('data-core', 1)
mod2 = Module('hios-1', 4)
mod3 = Module('hios2', 9)

modules = [mod1, mod2, mod3]

#print sorted(modules, key = byValue_key)


txt = open("/opt/jenkins/scripts/modules.txt")

#for line in txt:
#  print line

def f(x):
    return {
        'DATA-CORE': 0,
        'FFM-AVC': 0,
	'HIOS-API': 0, 
	'HIOS-API-DATA': 0,
	'HIOS-ASSISTER-DATA': 0,
	'HIOS-ASSISTER-UI': 0,
	'HIOS-Archieve': 0,
	'HIOS-CCS-DATA': 0,
	'HIOS-CCS-UI': 0,
	'HIOS-COMMON': 0,
	'HIOS-COMMON-UI': 0,
	'HIOS-DB-SCRIPTS': 0,
	'HIOS-DCM-FF-DATA': 0,
	'HIOS-DCM-FF-UI': 0,
	'HIOS-DCMFFM-DATA': 0,
	'HIOS-DCMFFM-UI': 0,
	'HIOS-DCMMC-DATA': 0,
	'HIOS-DCMMC-UI': 0,
	'HIOS-DOC-MGMT': 0,
	'HIOS-ERE-DATA': 0,
	'HIOS-ERE-UI': 0,
	'HIOS-ESB-BGM': 0,
	'HIOS-FFE-MAIN-UI': 0,
	'HIOS-GLOBAL-DATA': 0,
	'HIOS-IMPORT-EXPORT': 0,
	'HIOS-INTERNAL-WS': 0,
	'HIOS-INTERNAL-WS-DATA': 0,
	'HIOS-JBOSS-INSTANCE': 0,
	'HIOS-MAIN-DATA': 0,
	'HIOS-MAIN-UI': 0,
	'HIOS-MEC-DATA': 0,
	'HIOS-MEC-UI': 0,
	'HIOS-MQM-DATA': 0,
	'HIOS-MQM-ESB-BGM': 0,
	'HIOS-MQM-UI': 0,
	'HIOS-Monitoring': 0,
	'HIOS-NONFED-DATA': 0,
	'HIOS-NONFED-UI': 0,
	'HIOS-PE-DATA-COMMON': 0,
	'HIOS-PLAN-FINDER-DATA': 0,
	'HIOS-PLAN-FINDER-UI': 0,
	'HIOS-RBIS-CONFIG': 0,
	'HIOS-RBIS-DATA': 0,
	'HIOS-RBIS-ESB-BGM': 0,
	'HIOS-RBIS-PE': 0,
	'HIOS-RBIS-PE-DATA': 0,
	'HIOS-RBIS-UI': 0,
	'HIOS-SCIS': 0,
	'HIOS-PORTAL-DATA': 0
	'HIOS-PORTAL': 0
    }[x]

