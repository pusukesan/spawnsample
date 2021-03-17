# -*- coding: utf-8 -*-

import sys
import textfsm
import csv
import ipaddress
import os

#chdir to working directory
os.chdir('/users/tk/Desktop/textfsm')

#import log file
with open('teraterm.log') as forg:
    forg_read = forg.read()

#import templates
with open('ntc-templates-master/ntc_templates/templates/cisco_ios_show_ip_route.textfsm') as ftemplate:
    fsm = textfsm.TextFSM(ftemplate)
    routes = fsm.ParseText(forg_read)
    
#sort by network,mask
routes.sort(key=lambda r: (ipaddress.ip_address(r[2]),r[3]))

#output to stdout
std_w = csv.writer(sys.stdout)
std_w.writerow(fsm.header)
std_w.writerows(routes)

#output to csv
with open('output_route.csv', 'w', newline='') as fout:
    csv_w = csv.writer(fout)
    csv_w.writerow(fsm.header)
    csv_w.writerows(routes)
