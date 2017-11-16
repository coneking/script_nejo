#!/bin/bash

# Listado con preguntas
listado=(cnt
loc
pcat
nr
resumen
comentario
)

# Contador por pregunta
contador=0; 
while [ $contador -le 5 ]; do
	# Se recorre las preguntas
	for i in ${listado[@]}; do
		# Declara cada pregunta como variable
		declare "$i="""; 
		# Itera en las variables vacías
		while [ -z ${!i} ]; do 
			echo -e "Ingrese $i: \c"; 
			read $i; 
		done;
	# Aumenta el contador en 1
	let contador++; 
	done; 
done; 

coment2=$(echo $comentario |sed 's/ /%20/g')

echo "curl -X POST "¡¡¡INGRESAR URL!!!" -H 'cache-control: no-cache' -H 'content-type: application/x-www-form-urlencoded' -d 'attrs=status%3Bcrs%3A5200%3Bcustomer%3Bcnt%3A$cnt%3Bassignee%3Bcnt%3ABE1C93DC22D14B4680C305256AD9840F%3Bpriority%3Bpri%3A505%3Btype%3Bcrt%3A180%3Bdescription%3B$coment2%3Bsummary%3B$resumen%3BzLocation%3Bloc%3A$loc%3Baffected_resource%3Bnr%3A$nr%3Bcategory%3Bpcat%3A$pcat%3Bzreporting_met%3Brptmeth%3A7305%3Bgroup%3Bcnt%3A09D8517028B2434C8870CE33833D56F2&attrsRet=ref_num&creador=cnt%3ABE1C93DC22D14B4680C305256AD9840F'"
