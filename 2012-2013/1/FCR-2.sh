#!/bin/sh
#FCR.sh 
#file comandi ricorsivo che scrive il nome dei direttori trovati sul file 
#il cui nome e' passato come terzo argomento
cd $1
#la variabile file ci serve per capire se abbiamo trovato almeno un file con le caratteristiche cercate e per avere nella fase B i nomi di tutti i file trovati
file=

for i in *
do
	#controlliamo solo i nomi dei file leggibili!
	if test -f $i -a -r $i
	then 	
		case $i in
		*.$2) 
		#salviamo i nomi assoluti nei file in una variabile (serve solo se siamo nella fase B)
			file="$file `pwd`/$i" 
		esac
	fi
done
if test "$file"
then
#abbiamo trovato un direttorio che soddisfa le specifiche e quindi inseriamo il suo nome assoluto nel file temporaneo
pwd >> $3
#facciamo il controllo se siamo nella seconda fase
if test $4 = B 
then
	#calcoliamo se siamo nel direttorio richiesto
	conta=`wc -l < $3`
	if test $conta -eq $5
	then
	for j in $file
	do
		#stampiamo nome assoluto
        	echo Nome assoluto file $j
      		#stampiamo prima linea del file
        	head -1 < $j
	done
	fi
fi
fi

for i in *
do
	if test -d $i -a -x $i
	then
		#chiamata ricorsiava
		FCR.sh `pwd`/$i $2 $3 $4 $5
	fi
done


