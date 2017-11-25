#!/bin/bash

echo -e "Ingrese el número de bloques por memoria: \c"
read membloc
echo

clear
contador=1
memdisp=0
memused=0
memdesp=0
proc_enc=0
while [ $contador -le $membloc ]; do
	echo -e "Ingrese el tamaño del bloque de memoria $contador: \c"
	read f$contador
	memoria=$(eval "echo \$f$contador")
	memdisp=$(expr $memoria + $memdisp)
	echo "Bloque de memoria $contador es: $memoria Kb"
	if [ $proc_enc -gt 0 -a $proc_enc -le $memoria ]; then
			echo "Se ejecuta proceso encolado de tamaño: $proceso Kb"
				resta=$(expr $memoria - $proceso)
	                	memdesp=$(expr $resta + $memdesp)
	                	memused=$(expr $proceso + $memused)
			echo "Memoria desperdiciada del bloque de memoria $contador: $resta Kb"
			echo
			echo
			proceso=0
			let contador++
		
	else
		echo
		echo -e "Ingrese el tamaño del trabajo $contador: \c"
		read g$contador
		proceso=$(eval "echo \$g$contador")
		echo "Trabajo $contador: $proceso Kb"
		if [ $proceso -le $memoria ]; then
			resta=$(expr $memoria - $proceso)
			#memdisp=$(expr $memoria + $memdisp)
			memdesp=$(expr $resta + $memdesp)
			memused=$(expr $proceso + $memused)
			echo "Memoria desperdiciada del bloque de memoria $contador: $resta Kb"
			proceso=0
			let contador++
		else
			echo "Proceso es mayor que el bloque de memoria asignado"
			echo "Esperando..." 
			proc_enc=$(echo $proceso)
			#memdesp=$(expr $(eval "echo \$f$contador") + $memdesp)
			let contador++
		fi
		echo
		echo
	fi	
done
echo
echo
echo "Total memoria disponible: $memdisp"
echo "Total memoria usada: $memused"
echo "Total memoria desperdiciada (Fragmentación Interna): $memdesp"
