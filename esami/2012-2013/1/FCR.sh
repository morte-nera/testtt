#!/bin/sh
#FCR.sh 
#file comandi ricorsivo che scrive il nome dei direttori trovati sul file 
#il cui nome e' passato come terzo argomento

cd $1
#la variabile trovato ci serve per capire se abbiamo trovato almeno un file leggibile con la terminazione richiesta
trovato=0

for i in *
do
	#controlliamo solo i nomi dei file leggibili!
	if test -f $i -a -r $i
	then 	
		case $i in
		*.$2) trovato=1;;
		esac
	fi
done
if test $trovato -eq 1
then
#abbiamo trovato un direttorio che soddisfa le specifiche e quindi inseriamo il suo nome assoluto nel file temporaneo
pwd >> $3
fi
for i in *
do
	if test -d $i -a -x $i
	then
		#chiamata ricorsiava
		FCR.sh `pwd`/$i $2 $3
	fi
done

