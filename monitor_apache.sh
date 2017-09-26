#!/bin/bash
####################################################
# Revisa la cantidad de procesos apache
# Umbrales:
# < 200 --> OK
# >= 200 && <= 229 --> Warning
# >= 230 --> Critical
####################################################

warn=200
crit=230
estado_http=`/etc/init.d/httpd status |grep -o running`
cuenta_http=`ps -fea |grep http |grep -v grep |wc -l`

