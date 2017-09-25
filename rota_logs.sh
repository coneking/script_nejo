#!/bin/sh

##Definir la ruta del log
log_file="RUTA/DEL/LOG"
size_log=`du -sk $log_file |awk '{print $1}'`
how_many=`ls $log_file*.gz |wc -l`


# Consultamos cuantos archivos respaldados hay
# Si hay más de 5 archivos, se eliminará el último
echo "------"
date

if [ "$how_many" -ge "5" ]; then
	echo "Error - Actualmente hay $how_many archivos respaldados"
	echo "Se elimina el último respaldo"
	ls -lrt $log_file* |head -1 |awk '{print "rm -f " $9}' |sh
else
        echo "OK - Actualmente hay $how_many archivos respaldados"
fi

# Consultamos el tamaño del log
# Si pesa más de 100 MB el archivo se rotará
if [ "$size_log" -ge "100000" ]; then
	echo "Error - Archivo $log_file pesa $size_log Kb"
	echo "Se comprime archivo y se limpia"
	gzip -9 -c $log_file > $log_file".`date +"%d-%m-%Y_%H-%M"`.gz"
	if [ $? -eq "0" ]; then
		>$log_file
else
	echo "No se vacía archivo $log_file"
	fi
else
	echo "OK - Archivo $log_file pesa menos de 100 MB"
fi
echo "------"
