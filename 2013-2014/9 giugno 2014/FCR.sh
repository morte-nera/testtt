#!/bin/sh
#FCR.sh 
#file comandi ricorsivo che scrive il nome dei file trovati sul file 
#il cui nome e' passato come terzo argomento

cd $1
#la variabile NR ci serve per il numero di linee
NR=

for i in *
do
	#controlliamo solo i nomi dei file leggibili!
	if test -f $i -a -r $i
	then 	
		NR=`wc -l < $i`
		if test $NR -gt $2
		#i file devono avere un numero di linee strettamente maggiore di X (secondo parametro)
		then
			#abbiamo trovato un file che soddisfa le specifiche e quindi inseriamo il suo nome assoluto nel file temporaneo
			#echo TROVATO FILE `pwd`/$i 
			echo `pwd`/$i >> $3
		fi
	fi
done
for i in *
do
	if test -d $i -a -x $i
	then
		#chiamata ricorsiva
		$0 `pwd`/$i $2
	fi
done
