#!/bin/bash

#Colores
#verde(){
#echo -e '\e[1;32m'"$*";}
#verde "Usuario spazio con permisos de escritura y lectura sobre"
rojo="\e[1;31m"
verde="\e[1;32m"

pre=$(python /opt/spazio/scripts/sp_prepro.py -h 2> /dev/null |awk 'NR==3 {print "Pre: "$3}')
post=$(grep ^arch_version /opt/spazio/scripts/primeur/main/receive.py |awk '{print "Post: "$3}')
colas=$(grep ^QmName $SPAZIO/cfg/spqm.ini |awk '{print "qlist "$3}' |sh 2> /dev/null |egrep -c "FROM.SERVER|SP.OS.INPUT|SYDEADLT|successfully")
ver=$((python -V) 2>&1)


# Encabezado
        echo "#############################################################"
        echo "###                   Precheck MFT Linux                  ###"
        echo "#############################################################"

# Se comprueba que el usuario 'spazio' tenga permisos sobre el directorio ingresado
        #echo
        #echo "Revision de permisos por directorio"
        #echo "==================================="
        dire=$1
        echo
        if [ -z "$dire" ];then
                echo "No se ingresaron datos"
        else
                echo "Informacion de Directorio(s): "
                for i in $dire;do
                    touch $i/test_precheck >/dev/null 2>&1
                        if [ $? = 0 ];then
                                echo -e $verde"Usuario spazio con permisos de escritura y lectura sobre '$i'"
                                rm $i/test_precheck >/dev/null 2>&1
                                echo
                        else
                                echo -e $rojo"Usuario spazio sin permisos sobre '$i'"
                                ls -ld $i >/dev/null 2>&1
                                echo
                        fi
                done
        fi

# Validación de versión de python
        echo
        echo
        echo -e "Version Python: $verde$ver"
        
        
# Revisión de colas por defecto
        echo
        echo -n "Default Queue: "
        grep ^QmName $SPAZIO/cfg/spqm.ini |awk '{print "qlist "$3}' |sh >/dev/null 2>&1
        if [ $? -eq "0" ];then
                if [ $colas -ge "4" ];then
                        echo -e $verde"\tCola Listada OK"
                else
                        echo -e $rojo"\tFaltan colas por listar"
                fi
        else
                echo "Cola No Listada"
        fi


# Revisión de conexión
        echo
        echo -n "Conexion: "
        grep QmName_1 $SPAZIO/cfg/sprnode.ini |awk '{print "qlist "$3}' |sh >/dev/null 2>&1
        if [ $? -eq "0" ];then
                echo -e $verde"\tConexion OK"
        else
                echo -e $rojo"\tError de Conexion"
        fi


# Se valida la existencia de licencia y si pertenece a alguna interfaz de red
        echo
        echo -n "Licencia: "

        ls $SPAZIO/spazio.lic >/dev/null 2>&1
        if [ $? -ne "0" ]; then
                echo -e $rojo"\tNo existe licencia"
        else
mac=`tr -d '\r' < $SPAZIO/spazio.lic >/tmp/lic.tmp; grep Mac /tmp/lic.tmp |tr '-' ':' |awk '{print "/sbin/ifconfig |grep "$3}' |sh |awk '{print $1}' ORS=" "`
lic=`grep Customer /tmp/lic.tmp |awk '{print $3}'`
                echo $mac |grep "eth" >/dev/null
                        if [ $? -eq "0" ]; then
                                echo -e $verde"\tActiva ($lic)"
                                echo -e "Interfaz: \t${verde}$mac"
                                rm /tmp/lic.tmp >/dev/null 2>&1  
                        else
                                echo -e $rojo"\tNo concuerda con interfaces de red"
                        fi
        fi


# Revisión de status MFT (no se reinicia)
        echo
        echo -n "START & STOP: "
        if ( sp_service status >/dev/null 2>&1 = "0" ); then
                echo -e $verde"\tServicio MFT Iniciado"
        else
                echo -e $rojo"\tServicio MFT Detenido"
        fi



# Validación de Pre y Post Proces
        echo
        echo -n "PRE POST PROCESO: "
        echo -e $verde"\t"$pre - $post



# Ruta de instaclación MFT
echo
echo -n "Ruta de Instalacion MFT: ";echo -e $verde"\t"$SPAZIO


# Ruta de instalación python
python=`which python`
echo
echo -n "Ruta de Instalacion PYTHON: ";echo -e $verde"\t"$python
echo
