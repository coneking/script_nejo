#!/bin/bash

# Arreglo con variables para cada opción a ingresar por teclado
arreglo=('j' 'k' 'l' "m" "n" "o")

# Contador para recorrer el arreglo
contador=0
while [ $contador -le 5 ];do
        # For para recorrer cada opción
        for i in "cnt" "loc" "pcat" "nr" "resumen" "comentario"; do
                # declare = declara como variable el valor del $contador
                # y le agrega un valor, en este caso "nada"
                declare "${arreglo[$contador]}="""
                # Si el arreglo está vacio consultará la pregunta correspondiente del for
                while [ -z ${!arreglo[$contador]} ]; do
                        echo -e "Ingrese $i: \c"
                        read ${arreglo[$contador]}
                done
        # Aumento el contador para seguir recorriendo el for
        let contador++
        done
done


echo "curl -X POST "¡¡¡INGRESAR URL!!!" -H 'cache-control: no-cache' -H 'content-type: application/x-www-form-urlencoded' -d 'attrs=status%3Bcrs%3A5200%3Bcustomer%3Bcnt%3A${!arreglo[0]}%3Bassignee%3Bcnt%3ABE1C93DC22D14B4680C305256AD9840F%3Bpriority%3Bpri%3A505%3Btype%3Bcrt%3A182%3Bdescription%3B${!arreglo[1]}comentario%3Bsummary%3B${!arreglo[2]}%3BzLocation%3Bloc%3A${!arreglo[3]}%3Baffected_resource%3Bnr%3A${!arreglo[4]}%3Bcategory%3Bpcat%3A${!arreglo[5]}%3Bzreporting_met%3Brptmeth%3A7305%3Bgroup%3Bcnt%3A09D8517028B2434C8870CE33833D56F2&attrsRet=ref_num&creador=cnt%3ABE1C93DC22D14B4680C305256AD9840F'"
