#!/bin/sh
#Soluzione dell'appello del 5 Giugno 2013
#versione che usa un file temporaneo 

case $# in
2)	case $1 in
	/*) if test ! -d $1 -o ! -x $1
	    then
	    echo $1 non direttorio
	    exit 1
	    fi;;
	*)  echo $1 non nome assoluto; exit 2;;
	esac;;
*) 	echo Errore: Usage is $0 dirass stringa numero 
	exit 2;;
esac

#puo' avere senso controllare che il secondo parametro non contenga un carattere / 
case $2 in
*/*) echo Errore: $f non in forma relativa semplice
    exit 3;;
*) ;;
esac

PATH=`pwd`:$PATH
export PATH

#creiamo un file conta$$ il cui nome viene passato come argomento
> /tmp/conta$$

#invochiamo il file comandi ricorsivo con i due parametri e con il nome del file temporaneo
5giu13r.sh $1 $2 /tmp/conta$$   

#N.B. Andiamo a contare le linee del file /tmp/conta$$
D=`wc -l < /tmp/conta$$` 
echo Il numero di direttori totali della gerarchia che soddisfano la specifica = $D 
#Stampiamo (come richiesto dal testo) i loro nomi assoluti
cat /tmp/conta$$
#chiediamo all'utente il numero X
echo -n "Dammi il numero X che deve essere compreso fra 1 e $D: "
read X
#Controllo X
expr $X + 0  > /dev/null 2>&1
N1=$?
if test $N1 -ne 2 -a $N1 -ne 3
then echo numerico $X #siamo sicuri che numerico
     if test $X -lt 1 -o $X -gt $D
     then echo $X non compreso 
	  rm /tmp/conta$$ #poiche' stiamo uscendo a causa di un errore, cancelliamo il file temporaneo!
          exit 4
     fi
else
  echo $X non numerico
  rm /tmp/conta$$ #poiche' stiamo uscendo a causa di un errore, cancelliamo il file temporaneo!
  exit 5
fi

echo fase B 
#selezioniamo direttamente il nome del direttorio richiesto
d=`head -$X < /tmp/conta$$ | tail -1`
echo direttorio selezionato $d
cd $d
files=	#variabile per memorizzare solo i nomi dei file 
for i in *
do
        if test -f $i
        then
                case $i in
                *.$2) files="$files $i";;
                esac
        fi
done
#invochiamo la parte C
echo files= $files
5giu13 $files

#da ultimo eliminiamo il file temporaneo
rm /tmp/conta$$
