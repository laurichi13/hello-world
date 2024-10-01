#!/bin/bash

# Mostrar todos los nombres de archivos FASTQ
echo "Archivos FASTQ encontrados:"
for file in *.fastq *.fastq.gz; do
    if [[ -f "$file" ]]; then
        echo "$file"
        
        # Si el archivo está comprimido en .gz, usamos zcat para leerlo
        if [[ "$file" == *.gz ]]; then
            line_count=$(zcat "$file" | wc -l)
        else
            line_count=$(wc -l < "$file")
        fi

        # Mostrar número de líneas
        echo "Número de líneas en $file: $line_count"

        # Comprobar si el número de líneas es múltiplo de 4 (lecturas correctas)
        if (( line_count % 4 == 0 )); then
            echo "El archivo $file tiene lecturas correctamente formateadas."
        else
            incorrect_reads=$(( line_count % 4 ))
            echo "El archivo $file tiene $incorrect_reads lecturas incorrectas."
        fi
        echo "--------------------------------"
    else
        echo "No se encontraron archivos FASTQ."
    fi
done
