## La copia de los rpm se hace primero desde Rundeck

## Variables para colores
rojo="\e[1;31m"
verde="\e[1;32m"
normal="\e[0m"

## Verificando versión de centrify
ver_cen="adinfo -v |tr -d '()' |cut -d. -f2"

adinfo >/dev/null 2>&1
if [ $? -eq 0 ]; then
	if [ `eval $ver_cen` -eq 4 ]; then
		echo -e "Estado de Centrify: ${verde}Actualizado${normal}"
		echo
	else
		echo -e "Estado de Centrify: ${rojo}Desactualizado${normal}"
		echo "Aplicando actualización..."
		cd /tmp; tar -zxvf /tmp/centrifydc.tar.gz >/dev/null 2>&1
		cd /tmp/centrifydc; sudo yum localinstall -y CentrifyDC-5.4.0-rhel4.x86_64.rpm CentrifyDC-openssl-5.4.0-rhel4.x86_64.rpm CentrifyDC-openldap-5.4.0-rhel4.x86_64.rpm CentrifyDC-curl-5.4.0-rhel4.x86_64.rpm --nogpgcheck >/dev/null 2>&1
		if [ `eval $ver_cen` -eq 4 ]; then
			echo -e "Nuevo estado de Centrify: ${verde}Actualizado${normal}"
			echo
		else
			echo -e "Nuevo estado de Centrify: ${rojo}Error en la actualización${normal}"
			echo
		fi
	fi
else
	echo "Servidor sin centrify"
	echo
fi
rm -rf /tmp/centrifydc*
