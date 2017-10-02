####################################################
# Revisa la cantidad de procesos apache
# Umbrales:
# < 200 --> OK
# >= 200 && <= 229 --> Warning
# >= 230 --> Critical
####################################################

import os
import os.path

warn = 200
crit = 230
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

# Comparaciones para umbrales mientras el servicio apache esté activo
if apache == "running" and proceso < warn:
    print("0 Procesos_http Valor="+str(proceso)+";"+str(warn)+";"+str(crit)+";0 Procesos_http OK",proceso)
elif apache == "running" and proceso >= warn and proceso < crit:
    print("1 Procesos_http Valor="+str(proceso)+";"+str(warn)+";"+str(crit)+";1 Procesos_http Warning",proceso)
elif apache == "running" and proceso >= critic:
    print("2 Procesos_http Valor="+str(proceso)+";"+str(warn)+";"+str(crit)+";2 Procesos_http Critical",proceso)
    # Si el archivo existe revisa que número tiene y compara, si es igual a 2 recarga apache, sino le sumará uno
    if (os.path.isfile(file1)):
        file = open(file, "r").read()
        suma = int(file)
        if suma == 2:
            print("Me reinicio")
            os.popen('/etc/init.d/httpd reload')
            escribir(str(param))
        else:
            suma +=1
            escribir(str(suma))
    else:
        # Si el archivo no existe se crea con valor "0"
        escribir(str(param))
else:
    print("3 Procesos_http Valor="+str(proceso)+";"+str(warn)+";"+str(crit)+";3 Procesos_http Unknown",proceso)
