####################################################
# Revisa la cantidad de procesos apache
# Umbrales:
# < 200 --> OK
# >= 200 && <= 229 --> Warning
# >= 230 --> Critical
####################################################

import os
import os.path

warn = 4
crit = 6
file1 = "RUTA_DEL_LOG"
cuenta_http = os.popen('pgrep -fl http |grep -v grep|wc -l')
proceso = int(cuenta_http.read())
estado_http = os.popen('/etc/init.d/httpd status |grep -o running')
# Variable quita el salto de línea que entrega popen
apache = estado_http.read()[:-1]
param = "0"

# Función para escribir sobre el archivo log
def escribir(num):
    with open(file1, "w") as f:
        f.write(num)
        f.close()

# Función para leer sobr el archivo log
def leer(num):
    with open(file1, "r") as f:
        f.read()
        f.close()

# Comparaciones para umbrales
if apache == "running" and proceso < warn:
    print("0 Procesos_http Valor="+str(proceso)+";"+str(warn)+";"+str(crit)+";0 Procesos_http OK",proceso)
elif apache == "running" and proceso >= warn and proceso < crit:
    print("0 Procesos_http Valor="+str(proceso)+";"+str(warn)+";"+str(crit)+";1 Procesos_http Warning",proceso)
elif apache == "running" and proceso >= critic:
    print("0 Procesos_http Valor="+str(proceso)+";"+str(warn)+";"+str(crit)+";2 Procesos_http Critical",proceso)

