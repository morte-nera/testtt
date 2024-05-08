#!/bin/sh
#Soluzione dell'appello del 19 Giugno 2013

case $# in
3) 	;; #numero giusto di parametri	
*) 	echo Errore: Usage is $0 dirass numero1 numero2 
	exit 1;;
esac

#controllo sul primo parametro
case $1 in
	/*) if test ! -d $1 -o ! -x $1
	    then
	    echo $1 non direttorio
	    exit 2
	    fi;;
	*)  echo $1 non nome assoluto; exit 3;;
esac

#controllo sul secondo parametro che deve essere numerico e maggiore o uguale a 2
expr $2 + 0  > /dev/null 2>&1
r=$?
if test $r -ne 2 -a $r -ne 3
	then 	echo numerico $2 #siamo sicuri che numerico
     		if test $2 -lt 2 
     			then echo $2 non maggiore o uguale a 2
          		exit 4
     		fi
	else
  		echo $2 non numerico
  		exit 5
fi

#controllo sul terzo parametro che deve essere numerico e maggiore di 0
expr $3 + 0  > /dev/null 2>&1
r=$?
if test $r -ne 2 -a $r -ne 3
	then 	echo numerico $3 #siamo sicuri che numerico
     		if test $3 -le 0 
     			then echo $3 non maggiore di 0
          		exit 6
     		fi
	else
  		echo $3 non numerico
  		exit 7
fi

PATH=`pwd`:$PATH
export PATH

#invochiamo il file comandi ricorsivo con i tre parametri 
19giu13r.sh $1 $2 $3 

