## Variables para colores
rojo="\e[1;31m"
verde="\e[1;32m"
normal="\e[0m"
ROJO="\033[1;31m"
NORM="\033[0m"
VERDE="\033[1;32m"

## Función para revisar memoria, cpu y storage
info_critical(){
for i in @option.Servidor@; do
    echo "###################################"
    #echo "# Servidor: @option.Servidor@"
    echo "# Servidor: $i"
    echo "###################################"
    echo
		## Informa cuando la memoria está al 90% de uso (crítico)
    mem_esx="/opt/rundeck/check_vmware_api.pl -H $i -u _apm_esx@cencosud.corp -p IoYdIaSHDKLJHWED -l mem -s usage -c 90"
		## Informa cuando la CPU está al 70% de uso (crítico)
    cpu_esx="/opt/rundeck/check_vmware_api.pl -H $i -u _apm_esx@cencosud.corp -p IoYdIaSHDKLJHWED -l cpu -s usage -c 70"
		## Informa cuando un storage está al 85% de uso o 15% de disponibilidad (crítico)
    storage_esx="/opt/rundeck/check_vmware_api.pl -H $i -u _apm_esx@cencosud.corp -p IoYdIaSHDKLJHWED -l vmfs -c 15%:"
    
    eval $mem_esx |grep -q OK
    if [ $? -eq 0 ]; then
        echo -e "Memoria del Servidor: ${verde}OK${normal}"
        eval $mem_esx
        echo
    else
        echo -e "Memoria del Servidor: ${rojo}Error${normal}"
        eval $mem_esx
        echo
    fi
    eval $cpu_esx |grep -q OK
    if [ $? -eq 0 ]; then
        echo -e "CPU del Servidor: ${verde}OK${normal}"
        eval $cpu_esx
        echo
    else
        echo -e "CPU del servidor: ${rojo}Error${normal}"
        eval $cpu_esx
        echo
    fi
    eval $storage_esx |grep -q OK
    if [ $? -eq 0 ]; then
        echo -e "Storage del Servidor: ${verde}OK${normal}"
        eval $storage_esx |cut -d"|" -f1 |tr ",:" "\n" |grep CHECK
        echo
    else
        echo -e "Storage del servidor: ${rojo}Error${normal}"
        eval $storage_esx |cut -d"|" -f1 |tr ",:" "\n" |grep -v CHECK |egrep "\([1-9].[0-9][0-9]%\)|\(1[1-5].[0-9][0-9]%\)"
        #eval $storage_esx |cut -d"|" -f1 |tr ",:" "\n" 
        echo
    fi
done
}

## Función para revisar total de paths
info_path(){
for i in @option.Servidor@; do
    echo "###################################"
    #echo "# Servidor: @option.Servidor@"
    echo "# Servidor: $i"
    echo "###################################"
    echo
		
		## Revisa la cantidad de paths y si alguno falla
    path_esx="/opt/rundeck/check_vmware_api.pl -H $i -u _apm_esx@cencosud.corp -p IoYdIaSHDKLJHWED -l storage -s path"
    eval $path_esx |grep -q OK
    if [ $? -eq 0 ]; then
        echo -e "PATH del Servidor: ${verde}OK${normal}"
        eval $path_esx |tr ";" "\n"  |grep CHECK |awk '{print $1,$2}'
        echo
    else
        echo -e "PATH del servidor: ${rojo}Error${normal}"
        eval $path_esx |tr ";" "\n" |egrep -v "CHECK|<active>" 
        echo
    fi
done
}

## Función para revisar uptime y estado de tarjetas de red
info_down(){
for i in @option.Servidor@; do
    echo "###################################"
    #echo "# Servidor: @option.Servidor@"
    echo "# Servidor: $i"
    echo "###################################"
    echo
		## Informa el uptime del servidor
    uptime_esx="/opt/rundeck/check_vmware_api.pl -H @option.Servidor@ -u _apm_esx@cencosud.corp -p IoYdIaSHDKLJHWED -l uptime"
    ## Verifica la cantidad de nic y su estado
		nic_esx="/opt/rundeck/check_vmware_api.pl -H $i -u _apm_esx@cencosud.corp -p IoYdIaSHDKLJHWED -l net -s nic -w 1 -c 2"
    
    eval $uptime_esx |awk '{print $4,$5}' |tr "=|," " " |awk '{print "Uptime del Servidor: \033[1;32m"$2,$3"\033[0m"}'
    echo
    eval $nic_esx |grep -q OK
    if [ $? -eq 0 ]; then
        echo -e "NIC del Servidor: ${verde}OK${normal}"
        eval $nic_esx
        echo
    else
        echo -e "NIC del servidor: ${rojo}Error${normal}"
        eval $nic_esx
        echo
    fi
done
}


case @option.Opciones@ in
    Resource_Critical)
        info_critical
        ;;
    Resource_is_down)
        info_down
        ;;
    Paths)
        info_path
        ;;
esac
