#!/bin/sh

#controllo numero parametri
case $# in
        2) ;;
        *) echo "Errore numero parametri: devono essere 2 (gerarchia e numero intero strettamente positivo)"; exit 1;;
esac
#controllo primo argomento
case $1 in
        /*) if test ! -d $1 -o ! -x $1
            then echo Non direttorio o non eseguibile; exit 2
            fi;;
        *) echo Nome direttorio non assoluto; exit 3;;
esac
G=$1

#controllo se l'argomento e' numerico
expr $2 + 0 >/dev/null 2>&1
if test $? -eq 2 -o $? -eq 3
then echo Parametro non numerico; exit 4
fi
if test $2 -le 0
then echo Numero non strettamente positivo; exit 5
fi
K=$2

PATH=`pwd`:$PATH
export PATH
#per sicurezza azzeriamo il file temporaneo dove le chiamate ricorsive scriveranno i nomi assoluti dei file trovati
> /tmp/filetemp

20Giu12R.sh $G $K
#non richiesto, ma male non fa 
echo Numero di files trovati: `wc -l < /tmp/filetemp`
 
#ora per ogni file trovato andiamo ad invocare la parte C
for i in `cat /tmp/filetemp`
do
        N=`wc -l < $i`
        L=`wc -c < $i`
        H=`expr $L / $N`
	echo chiamo "20Giu12 $i $N $H"
        20Giu12 $i $N $H
done
rm  /tmp/filetemp

