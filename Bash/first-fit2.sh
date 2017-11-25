clear
echo -e "Número de bloques de memoria: \c"
read numero
arreglo=()
for ((i=1;i<=$numero;i++)); do
        arreglo=("${arreglo[@]}" "elemento$i")
        echo -e "Valor para el bloque de memoria $i: \c"
        read valor
        arreglo[$i]=$valor
done

echo -e "Arreglo a mostrar: \c"
read numero0
echo "Arreglo $numero0: ${arreglo[$numero0]}"


echo
echo -e "Número de procesos: \c"
read numero2
arreglo2=()
for ((i=1;i<=$numero2;i++)); do
        arreglo2=("${arreglo2[@]}" "elemento$i")
        echo -e "Valor para el proceso $i: \c"
        read valor2
        arreglo2[$i]=$valor2
done

contador=1
while [ $contador -lt ${#arreglo[@]} ]; do
        if [ ${arreglo2[$contador]} -le ${arreglo[$contador]} ] 2>/dev/null; then
                resta=$(expr ${arreglo[$contador]} - ${arreglo2[$contador]})
                echo "Memoria desperdiciada del bloque de memoria $contador: $resta Kb"
        	let contador++
	else
                echo "Proceso $contador es mayor que la memoria, esperada"
                let contador++
                        espera=$(expr $contador - 1)
                        if [ ${arreglo2[$espera]} -le ${arreglo[$contador]} ] 2>/dev/null; then
                                echo "Corriendo proceso encolado"
                                resta=$(expr ${arreglo[$contador]} - ${arreglo2[$espera]})
                                echo "Memoria desperdiciada del bloque de memoria $espera: $resta Kb"
                        	#let contador++
			else
                        	echo Sigo esperando por un Bloque de memoria más grande
				echo
				#let contador++
		   	fi
        fi
done

