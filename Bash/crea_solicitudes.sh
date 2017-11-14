#!/bin/bash

# Crea solicitudes o incidentes automáticamente
cnt1=""
loc1=""
pcat1=""
nr1=""
resum1=""
coment1=""


while [ -z cnt1 -o -z loc1 -o -z pcat1 -o -z nr1 -o -z coment1 ]; do
	echo -e "Ingrese cnt (Usuario final afectado): \c"
	read cnt1

	echo -e "Ingrese loc (Ubicación): \c"
	read loc1

	echo -e "Ingrese pcat (Área de solicitud): \c"
	read pcat1

	echo -e "Ingrese nr (Servicio TI): \c"
	read nr1
	
	echo -e "Ingrese resumen (Subjet): \c"
	read resum1

	echo -e "Ingrese un comentario: \c"
	read coment1

done
coment2=$(echo $coment1 |sed 's/ /%20/g')


echo "curl -X POST "¡¡¡INGRESAR URL!!!" -H 'cache-control: no-cache' -H 'content-type: application/x-www-form-urlencoded' -d 'attrs=status%3Bcrs%3A5200%3Bcustomer%3Bcnt%3A$cnt1%3Bassignee%3Bcnt%3ABE1C93DC22D14B4680C305256AD9840F%3Bpriority%3Bpri%3A505%3Btype%3Bcrt%3A182%3Bdescription%3B$coment2%3Bsummary%3B$resum1%3BzLocation%3Bloc%3A$loc1%3Baffected_resource%3Bnr%3A$nr1%3Bcategory%3Bpcat%3A$pcat1%3Bzreporting_met%3Brptmeth%3A7305%3Bgroup%3Bcnt%3A09D8517028B2434C8870CE33833D56F2&attrsRet=ref_num&creador=cnt%3ABE1C93DC22D14B4680C305256AD9840F'"
