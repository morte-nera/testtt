#!/bin/sh
#FCR.sh 
#file comandi ricorsivo della prova del 14 Settembre 2011

cd $1
#la variabile NF ci serve per contare il numero di file leggibili
NF=0
#la variabile files ci serve per imemorizzare i file leggibili
files=

for i in *
do
	#controlliamo solo i nomi dei file leggibili perche' cosi' richiede il testo!
	if test -f $i -a -r $i
	then 
		#aggiorniamo la variabile del conteggio	
		NF=`expr $NF + 1`
		files="$files $i"		
	fi
done

if test $NF -ge $2 -a $NF -le $3
then
echo TROVATO direttorio  `pwd`
#dobbiamo invocare la parte C
14Set11 $files
fi

for i in *

do
	if test -d $i -a -x $i
	then
		#chiamata ricorsiva
		$0 `pwd`/$i $2 $3
	fi
done
