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

# Verifica que el servicio esté en ejecución, la cantidad de procesos y su umbral
# La salida es estándar para check_mk
# 0 = OK
# 1 = Warning
# 2 = Critical
# 3 = Unknown

if [ $estado_http == "running" -a $cuenta_http -lt $warn ] 2>/dev/null; then
        echo "0 Procesos_http Valor=$cuenta_http;$warn;$crit;0 Procesos_http OK $cuenta_http"
elif [ $estado_http == "running" -a $cuenta_http -ge $warn -a $cuenta_http -lt $crit ] 2>/dev/null; then
        echo "1 Procesos_http Valor=$cuenta_http;$warn;$crit;0 Procesos_http Warning $cuenta_http"
elif [ $estado_http == "running" -a $cuenta_http -ge $crit ] 2>/dev/null; then
        echo "2 Procesos_http Valor=$cuenta_http;$warn;$crit;0 Procesos_http Critical $cuenta_http"
fi
