#!/bin/sh
#FCR.sh 
#file comandi ricorsivo 

cd $1

#la variabile NC ci serve per il numero di caratteri
NC=
#la variabile count per contare i file leggibili e quindi ci serve per sapere se siamo su un file di posizione dispari
count=0
#la variabile files ci serve per raccogliere i nomi dei file in posizione dispari
files=

for F in *	#nome F stabilito dal testo!
do
	#controlliamo solo i nomi dei file per il discorso della posizione!
	if test -f $F 
	then 	
		count=`expr $count + 1`
		#ora controlliamo la leggibilita' come indicato nella specifica!
		if test -r $F
		then 	
		   NC=`wc -c < $F`
		   if test $NC -eq $2	#lunghezza in caratteri esattamente uguale a X
		   then
		   #abbiamo trovato un file che soddisfa le specifiche, controlliamo che sia in posizione dispari e nel caso inseriamo il suo nome nella variabile files
			if test `expr $count % 2` -eq 1
			then
			   echo TROVATO file `pwd`/$F	 #stampiamo il nome assoluto come richiesto
			   files="$files $F"
			fi
		   fi
		fi
	fi
done

if test "$files"	#se abbiamo trovato almeno un file che soddisfa le specifiche, chiamiamo la parte C
then
	echo siamo nella dir $1 e chiamiamo la parte C con $files
	7Set22 $files
fi

for i in *
do
	if test -d $i -a -x $i
	then
		#chiamata ricorsiva: ATTENZIONE A PASSARE IL NOME ASSOLUTO DELLA dir INDIVIDUATA!
		FCR.sh `pwd`/$i $2
	fi
done

