#!/bin/sh
#Soluzione dell'esame del 7 Settembre 2022

#controllo sul numero di parametri: deve essere maggiore o uguale a 3 
case $# in
0|1|2)	echo Errore: numero parametri $# quindi pochi parametri. Usage is $0 numero dirass1 dirass2 ...
	exit 1;;
*) 	echo DEBUG-OK: da qui in poi proseguiamo con $# parametri ;;
esac

#dobbiamo controllare che il primo parametro sia un numero, sia strettamente maggiore di 0 e dispari
case $1 in
*[!0-9]*) echo $1 non numerico o non positivo
	  exit 2;;
*) 	  if test `expr $1 % 2` -eq 0	#pari e quindi sbagliato
	  then
		  echo $1 pari e quindi non giusto
		  exit 3
	  else	  
		  echo DEBUG-primo parametro giusto $1
	  fi;;
esac

X=$1	#salviamo il numero nella variabile indicata dal testo e poi facciamo shift
shift

#ora in $* abbiamo solo i nomi delle gerarchie e quindi possiamo fare i controlli sui nomi assoluti e sulle directory in un for
for G 
do
	case $G in
	/*) if test ! -d $G -o ! -x $G
	    then
	    echo $G non directory o non attraversabile
	    exit 4
	    fi;;
	*)  echo $G non nome assoluto; exit 5;;
	esac
done
#controlli sui parametri finiti possiamo passare alle Q fasi dopo aver settato ed esportato il path
PATH=`pwd`:$PATH
export PATH

for G	#usiamo il nome indicato nel testo!
do
	echo DEBUG-fase per $G
	#invochiamo il file comandi ricorsivo con la gerarchia e il numero X
	FCR.sh $G $X    
done
