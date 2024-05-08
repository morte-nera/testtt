#!/bin/sh
#file comandi ricorsivo dirass X  

cd $1

#definiamo una variabile per contenere il numero di righe
NR=

#definiamo una variabile per contenere il numero di righe che iniziano per un carattere alfabetico minuscolo
N=

#definiamo una variabile per memorizzare i nomi dei file 
file=

for i in *
do
	if test -f $i -a -r $i #se e' un file ed e' leggibile
	then
		#calcoliamo il numero di linee
		NR=`wc -l < $i`
        	#calcoliamo quante linee iniziano con un carattere alfabetico minuscolo
		N=`grep ^[a-z] $i | wc -l`
		#echo NR is $NR e N is $N
		if test $NR -eq $2 -a $N -eq $NR
		then
	  		file="$file $i" 
		fi
	fi
done

#se ho trovato almeno un file
if test "$file"
then
  echo TROVATO DIRETTORIO `pwd`
  echo che contiene i seguenti file che soddisfano la specifica $file
  echo DEVO CHIAMARE LA PARTE C\?
  read risposta
  case $risposta in
  s*|S*|y*|Y*) 16Lug14 $file $2;;
  *) echo Nessuna invocazione della parte C;;
  esac  
fi

for i in *
do
if test -d $i -a -x $i
then
  #echo RICORSIONE in `pwd`/$i  con conta uguale a $conta
  $0 `pwd`/$i $2 
fi
done
