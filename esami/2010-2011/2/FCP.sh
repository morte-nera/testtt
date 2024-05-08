#!/bin/sh
#Soluzione della Prova dell'14 Settembre 2011

case $# in
0|1|2)	echo Errore: numero parametri is $# quindi pochi parametri. Usage is $0 dirass numerostrettpos1 numerostrettpos2 
	exit 1;;
3) 	echo OK: da qui in poi proseguiamo con $# parametri ;;
*)	echo Errore: numero parametri is $# quindi troppi parametri. Usage is $0 dirass numerostrettpos1 numerostrettpos2
	exit 1;;
esac

#controlliamo la gerarchia $1
case $1 in
	/*) if test ! -d $1 -o ! -x $1
	    then
	    echo $1 non direttorio
	    exit 2
	    fi;;
	*)  echo $1 non nome assoluto; exit 3;;
esac

#Controllo $2
case $2 in
	*[!0-9]*) echo $2 non numerico o non positivo
		  exit 4;;
	*) if test $2 -eq 0
	   then echo ERRORE: secondo parametro $2 uguale a zero
		exit 5
	   fi ;;
esac

#Controllo $3
case $3 in
	*[!0-9]*) echo $3 non numerico o non positivo
		  exit 6;;
	*) if test $3 -eq 0
	   then echo ERRORE: terzo parametro $3 uguale a zero
		exit 7
	   fi ;;
esac

#controllo che $2 strettamente minore di $3
if test $2 -ge $3
then
	echo ERRORE: secondo parametro $2 NON strettamente minore del terzo parametro $3
	exit 8
fi
#controlli sui parametri finiti possiamo passare a settare il path
PATH=`pwd`:$PATH
export PATH
FCR.sh $*    
