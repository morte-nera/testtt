#!/bin/sh
cd $1

#la variabile trovato serve per capire se si è trovato almeno un file che soddisfa le specifiche e quindi si deve stamapare il nome assoluto del direttorio
trovato=0

#converto la $2 in maiuscolo e minuscolo indipendentemente se all'origine è maiuscolo o minuscolo
mai=`echo $2| tr [:lower:] [:upper:]`
min=`echo $2| tr [:upper:] [:lower:]`
#echo $mai $min

for i in *
do #anche se non chiesto controllo se il file è leggibile perche 
   #l'esercizio prevede di cercare dentro il file 
   if test -f $i -a -r $i
   then
	if grep $mai $i > /dev/null
	then 
		if grep $min $i > /dev/null
		then trovato=1
	     	     echo `pwd`/$i >> $3
		fi
	fi
   fi
done

if test $trovato -eq 1
then echo Trovato direttorio: `pwd`
fi

for i in *
do 
	if test -d $i -a -x $i
   	then 
		FCR.sh `pwd`/$i $2 $3
   fi
done
