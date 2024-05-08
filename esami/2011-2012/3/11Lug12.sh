#!/bin/sh

#controllo numero parametri
case $# in
        2) ;;
        *) echo "Errore numero parametri: devono essere 2 (gerarchia e numero intero maggiore o uguale a 2)"; exit 1;;
esac
#controllo primo argomento
case $1 in
        /*) if test ! -d $1 -o ! -x $1
            then echo Non direttorio o non eseguibile; exit 1
            fi;;
        *) echo Nome direttorio non assoluto; exit 2;;
esac
G=$1

#controllo se l'argomento e' numerico
expr $2 + 0 >/dev/null 2>&1
if test $? -eq 2 -o $? -eq 3
then echo Parmetro non numerico; exit 3
fi
if test $2 -lt 2
then echo Numero non maggiore o uguale a 2; exit 4
fi
N=$2

PATH=`pwd`:$PATH
export PATH
#per sicurezza azzeriamo il file temporaneo dove le chiamate ricorsive scriveranno i nomi assoluti dei file trovati
filetemp=/tmp/filetemp$$
> $filetemp

11Lug12R.sh $G $N $filetemp
#non richiesto, ma male non fa 
T=`wc -l < $filetemp`
echo Numero di direttori trovati: $T
#ora per ogni direttorio trovato andiamo ad invocare la parte C
for i in `cat $filetemp`
do
	dim=0  #somma delle dimensioni per calcolare la media
	#ci spostiamo del direttorio giusto
	cd $i
	for j in *
	do
          d=`wc -c < $j`
          dim=`expr $dim + $d`
	done
        K=`expr $dim / $N`
	echo chiamo 11Lug12 * $K
	11Lug12 * $K
done
rm $filetemp
