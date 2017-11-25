echo -e "Numero de bloques de memoria: \c"
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
echo -e "Numero de procesos: \c"
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
        if [ ${arreglo2[$contador]} -le ${arreglo[$contador]} ]; then
                resta=$(expr ${arreglo[$contador]} - ${arreglo2[$contador]})
                echo "Memoria desperdiciada del bloque de memoria $contador: $resta Kb"
        else
                echo "Proceso es mayor que la memoria, esperada"
                let contador++
#               while [ $contador -lt ${#arreglo[@]} ]; do
                        espera=$(expr $contador - 1)
                        #siguiente=$(expr $contador + 1)
                        #if [ ${arreglo2[2]} -le ${arreglo[3]} ]; then
                        if [ ${arreglo2[$espera]} -le ${arreglo[$contador]} ]; then
                                echo "Corriendo proceso encolado"
                                resta=$(expr ${arreglo[$contador]} - ${arreglo2[$espera]})
                                echo "Memoria desperdiciada del bloque de memoria $espera: $resta Kb"
                                let contador++
                        else
                                let contador++
                        fi
#               done
        fi
        let contador++
done

