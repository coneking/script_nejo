info_aix(){

runas(){
usuario=$1
CMD=$2
sudo su - $usuario -c "$CMD 2>&1" 2>/dev/null
}

runas_2(){
usuario=$1
CMD=$2
/usr/local/bin/sudo su - $usuario -c "$CMD 2>&1" 2>/dev/null
}

echo "##################################"
echo "## IFO SERVER: `hostname -s`"
echo "## Fecha: `date +%F`"
echo "## Versión: `oslevel` (`oslevel -s`)"
echo "##################################"
echo
echo "###############"
echo "##  PRTCONF  ##"
echo "###############"
echo
prtconf
echo
echo
echo "##################"
echo "## FILESYSTEMS  ##"
echo "##################"
echo
df -g
echo
echo
echo "#########################"
echo "##  PUNTOS DE MONTAJE  ##"
echo "#########################"
echo
mount
echo
echo
echo "###############"
echo "##  BOOTLIST ##"
echo "###############"
echo
which sudo >/dev/null 2>&1
if [ $? -eq 0 ]; then
    echo \\n | runas root "bootlist -m normal -o"
else
    echo \\n | runas_2 root "bootlist -m normal -o"
fi
echo
echo
echo "###################"
echo "##  INFO DISCOS  ##"
echo "###################"
echo
which sudo >/dev/null 2>&1
if [ $? -eq 0 ]; then
    lspv |awk '{print "echo "$0"; echo  \"Tamaño: \\c\"; sudo bootinfo -s "$1"; echo"}' |sh
else
    lspv |awk '{print "echo "$0"; echo  \"Tamaño: \\c\"; /usr/local/bin/sudo bootinfo -s "$1"; echo"}' |sh
fi
echo
echo
echo "#######################"
echo "##  PATH POR DISCOS  ##"
echo "#######################"
echo
lspath |awk '{print $2}' |sort -n |uniq |awk '{print "lspath -l "$1"; echo"}' |sh 
echo
echo
echo "####################"
echo "##  VOLUME GROUP  ##"
echo "####################"
echo
lsvg
echo
echo
lsvg |awk '{print "lsvg "$1 "; echo"}' |sh 2>/dev/null
echo
echo
echo "###########################"
echo "##  FS POR VOLUME GROUP  ##"
echo "###########################"
echo
lsvg |awk '{print "lsvg -l "$1 "; echo"}' |sh 2>/dev/null
echo
echo
echo "################"
echo "##  IFCONFIG  ##"
echo "################"
echo
ifconfig -a
echo
echo
echo "####################"
echo "##  RUTAS DE RED  ##"
echo "####################"
echo
netstat -rn
echo
echo
echo "#####################"
echo "##  CONTROLADORAS  ##"
echo "#####################"
echo
lsdev -Cc adapter |grep fcs |awk '{print "lscfg -vl "$1}' |sh 2>/dev/null
echo
echo
}

ping -c1 -w1 172.18.171.43 >/dev/null 2>&1
if [ $? -ne 0 ]; then
    netstat -rn |grep -q "10.91.180"
    if [ $? -eq 0 ]; then
        sudo route add -host 172.18.171.43 172.20.117.249 >/dev/null 2>&1
    fi
fi
ping -c1 -w1 172.18.171.43 >/dev/null 2>&1
if [ $? -eq 0 ]; then
    which sudo >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        tmp_dir=$(date +%s)
        mkdir /tmp/$tmp_dir
        sudo nfso -o nfs_use_reserved_ports=1 >/dev/null 2>&1
        sudo mount 172.18.171.43:/mft_logs/aix/ /tmp/$tmp_dir
        sudo chown rundeck /tmp/$tmp_dir
        info_aix > /tmp/$tmp_dir/$(hostname -s).txt
        echo "Archivo con información!!!"
        ls -l /tmp/$tmp_dir/$(hostname -s).txt
        sudo umount /tmp/$tmp_dir && rm -r /tmp/$tmp_dir
    else
        tmp_dir=$(date +%s)
        mkdir /tmp/$tmp_dir
        /usr/local/bin/sudo nfso -o nfs_use_reserved_ports=1 >/dev/null 2>&1
        /usr/local/bin/sudo mount 172.18.171.43:/mft_logs/aix/ /tmp/$tmp_dir
        /usr/local/bin/sudo chown rundeck /tmp/$tmp_dir
        info_aix > /tmp/$tmp_dir/$(hostname -s).txt
        echo "Archivo con información!!!"
        ls -l /tmp/$tmp_dir/$(hostname -s).txt
        /usr/local/bin/sudo umount /tmp/$tmp_dir && rm -r /tmp/$tmp_dir
    fi
else
    echo "No se puede montar NFS"
fi
