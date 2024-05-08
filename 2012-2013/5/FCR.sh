#!/bin/sh
#parte ricorsiva esame 15 gennaio 2014
cd $1
#NC variabile che contiene il numero di caratteri del file
NC=
valido=0

for i in *
do
  if test -f $i 
    then 
	NC=`wc -c < $i`
	if test $NC -gt $2
	then
		valido=1
		#memorizzo percorso assoluto file valido su file temporaneo
		echo `pwd`/$i >> $3
  	fi
  fi
done
#controllo se ho trovato almeno un file che soddisfa le specifiche allora il direttorio e' valido
if [ $valido -eq 1 ]
  then 
    echo "Trovata directory utile: `pwd`"
fi

#invocazione ricorsiva
for i in *
do
	if test -d $i -a -x $i
	then
		$0 `pwd`/$i $2 $3
	fi
done

