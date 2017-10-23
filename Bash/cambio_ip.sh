# Script que permite cambiar direcciones IP en Linux
# Autor: Coneking
# Fecha: 23-10-2017



# Creación de arreglos en base a archivos con IP's
# Se pueden remplazar directamente en el script por las IPs
listado=(`for i in $(cat RUTA_CON_IPS_ORIGINALES.txt); do echo $i; done`)
listado2=(`for i in $(cat RUTA_CON_IPS_NUEVAS.txt); do echo $i; done`)
ruta="/etc/sysconfig/network-scripts"

# El script se ejecutará de acuerdo a la cantidad de direcciones IPs del listado de IPs originales.
# Recorre el primer arreglo "listado" para buscar si la dirección IP existe en el servidor

contador=0
for i in ${listado[@]}; do
        tarjeta=`ip add |grep $i |awk '{print$(NF-0)}'`
        if [ -z $tarjeta ]; then
		# Si no encuentra la dirección IP no realiza acciones
                echo "La dirección IP $i no existe en este servidor"
        else

                echo "La dirección IP $i corresponde a la tarjeta $tarjeta"
                # Con la ayuda del contador se mantiene el orden de las dos listas de IPs
		echo "Se modifica por la IP: ${listado2[$contador]}"
                # Respalda archivo de interfaces original
		cp -p $ruta/ifcfg-eth0 $ruta/ifcfg-eth0_$(date +%F) ; gzip $ruta/ifcfg-eth0_$(date +%F)
                echo
                echo "Información de tarjeta $tarjeta actual:"
                echo "=================================="
                echo
                ifconfig $tarjeta
                echo
		# Busca la actual dirección IP en el archivo de interfaces  y lo modifica por la nueva dirección
                sed -i '/^IPADDR='"$i"'/ s//IPADDR='"${listado2[$contador]}"'/' $ruta/ifcfg-eth0
                ifdown $tarjeta; ifup $tarjeta
                echo "Información actualizada de tarjeta $tarjeta:"
                echo "======================================="
                echo
                ifconfig $tarjeta
                echo
        fi
	# Aumenta el contador para la siguiente búsqueda
	let contador=contador+1
done
echo

