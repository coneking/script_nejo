#Variables para colores
rojo="\e[1;31m"
verde="\e[1;32m"
fin="\e[0m"

echo "############################"
echo "### Descarga de Archivos ###"
echo "############################"
echo

#Función para disponibilizar los archivos al servidor web
#Esta función es invocada más abajo
transfiere(){
curl -s -T "@option.Directorio@/$archivo" http://172.18.171.43/seir/ |grep Created > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            echo -e "Archivo "$archivo" disponible en: ${verde}http://172.18.171.43/seir/$archivo"
            echo "---"
            echo
        else
            echo "No se puede subir archivo $archivo o ya se encuentra disponible."
            echo -e "Favor revisar: ${verde}http://172.18.171.43/seir/"
            echo "---"
            echo
        fi
}


transfiere_comp(){
curl -s -T "/SEIR/$archivo".gz"" http://172.18.171.43/seir/ |grep Created > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            echo -e "Archivo "$archivo" disponible en: ${verde}http://172.18.171.43/seir/$archivo"
            echo "---"
            echo
        else
            echo "No se puede subir archivo $archivo o ya se encuentra disponible."
            echo -e "Favor revisar: ${verde}http://172.18.171.43/seir/"
            echo "---"
            echo
        fi
}


#Función comprueba que el directorio ingresado inicie en /SEIR
verifica(){
echo @option.Directorio@ |grep -q "^/SEIR$*"
if [ $? -ne 0 ]; then
    echo -e "Error... Directorio debe comenzar con $rojo/SEIR/"
    exit
fi
}

verifica

#Comprueba si el directorio existe
if [ -d @option.Directorio@ ]; then
    #Recorre los archivos y comprueba si existen
    for archivo in @option.Archivo@; do
    [ -e @option.Directorio@/$archivo ] && {
        #Si el tamaño del archivo es =>200M lo informa
        peso=$(du -sm @option.Directorio@/$archivo |awk '{print $1}')
        if [ $peso -gt "200" ]; then
            echo -e "El archivo solicitado ${verde}$archivo${fin} tiene un peso de: ${rojo}$peso MB"
            echo "Favor esperar mientras se sube el archivo..."
            echo $peso |egrep -q "\.gz$|\.zip$|\.bz2$|\.tar$"
            if [ $? -eq 0 ]; then
                transfiere
            else
                echo "(Se respalda y comprime el archivo $archivo antes de subirlo)"
                sudo cp -p @option.Directorio@/$archivo /SEIR
                sudo gzip /SEIR/$archivo
                transfiere_comp
                sudo rm -f /SEIR/$archivo".gz"
            fi
        else
            echo -e "Favor esperar mientras se sube el archivo ${verde}$archivo"
            transfiere
        fi
    } || {
        echo -e "El archivo ${rojo}$archivo${fin} no existe."
        echo "---"
        echo
    }
    done
else
        echo -e "Directorio ${rojo}@option.Directorio@${fin} No existe."
        echo
fi
