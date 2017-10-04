####################################
# Script para relevamiento DB2 SOX #
#                                  #
####################################

usuario_db2=`ps -fea |grep -i db2sysc |grep -v grep |awk '{print $1}'`
instancia="|grep -p Indirect |grep \"Database name\" |awk '{print \"sh SOX_DB2.sh \"\$4}'"
instancia2="|grep -B5 Indirect |grep \"Database name\" |awk '{print \"sh SOX_DB2.sh \"\$4}'"
fecha=`date +%b" "%e`
ipnfs="Ingrese_su_ip"

mount_aix(){
	tmp_dir=$(date +%s)
        mkdir /tmp/$tmp_dir
        sudo mount $ipnfs:/mft_logs/aix/ /tmp/$tmp_dir
        sudo chown $usuario_db2 /tmp/$tmp_dir
        runas $usuario_db2 ls -l |grep "$fecha" |awk '{print "cp "$9" /tmp/$tmpdir"}'
        sudo umount /tmp/$tmp_dir && rm -r /tmp/$tmp_dir
}

mount_linux(){
echo
}

runas(){
usuario=$1
CMD=$2

sudo su - $usuario -c $CMD 2>/dev/null
}

case `uname` in
    Linux)
        sudo su - $usuario_db2 -c "cd SOX; db2 list db directory $instancia2 |sh"
        ;;
    AIX)
        runas $usuario_db2 "cd SOX; db2 list db directory $instancia |sh"
        mount_aix
	;;
esac

