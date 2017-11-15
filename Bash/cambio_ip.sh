# Script que permite cambiar direcciones IP en Linux
# Autor: Coneking
# Fecha: 23-10-2017



# Creación de arreglos en base a las IPs
listado=('INGRES_IP_ACTUAL')
listado2=('INGRESE_IP_NUEVA')

# Se busca el gateway actual para modificarlo por el nuevo
gateway1=`route -n |awk '{print $2}' |grep -v "0.0.0.0" |tail -1`
gateway2="INGRESE_IP_GATEWAY"

ruta="/etc/sysconfig/network-scripts"
ruta2="/etc/sysconfig/network"

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
                cp -p $ruta/ifcfg-$tarjeta $ruta/ifcfg-$tarjeta$(date +%F) ; gzip $ruta/ifcfg-$tarjeta$(date +%F)
                cp -p $ruta2 $ruta2$(date +%F) ; gzip $ruta2$(date +%F)
                echo
                echo "Información de tarjeta $tarjeta actual:"
                echo "=================================="
                echo
                ifconfig $tarjeta
                echo
                cat $ruta/ifcfg-$tarjeta
                echo
                echo "Información de rutas:"
                echo "====================="
                echo
                route -n
                echo
                echo "Información de archivo network:"
                echo "==============================="
                echo
                cat $ruta2
                echo
                # Busca la actual dirección IP y GATEWAY en el archivo de interfaces y los modifica por los nuevos datos
                sed -i '/'"$i"'/ s//'"${listado2[$contador]}"'/' $ruta/ifcfg-$tarjeta
                sed -i '/'"$gateway1"'/ s//'"$gateway2"'/' $ruta/ifcfg-$tarjeta
                sed -i '/'"$gateway1"'/ s//'"$gateway2"'/' /etc/sysconfig/network
                ifdown $tarjeta; ifup $tarjeta
                echo "Información actualizada de tarjeta $tarjeta:"
                echo "======================================="
                echo
                cat $ruta/ifcfg-$tarjeta
                echo
		echo "ifdown eth0; ifup eth0" > /tmp/at-eth.txt
		at -f /tmp/at-eth.txt now + 1 min
        fi
        # Aumenta el contador para la siguiente búsqueda
        let contador=contador+1
done
echo
