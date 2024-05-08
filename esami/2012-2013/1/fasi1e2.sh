#!/bin/sh
#Soluzione della Prima Prova in itinere del 12 Aprile 2013
#versione 1 che usa un file temporaneo e non usa FCR.sh per la seconda fase

case $# in
3)	case $1 in
	/*) if test ! -d $1 -o ! -x $1
	    then
	    echo $1 non direttorio
	    exit 1
	    fi;;
	*)  echo $1 non nome assoluto; exit 2;;
	esac;;
*) 	echo Errore: Usage is $0 dirass stringa numero 
	exit 3;;
esac

#puo' avere senso controllare che il secondo parametro non contenga un carattere / 
case $2 in
*/*) echo Errore: $f non in forma relativa semplice
    exit 3;;
*) ;;
esac

#Controllo terzo parametro
expr $3 + 0  > /dev/null 2>&1
N1=$?
if test $N1 -ne 2 -a $N1 -ne 3
then echo numerico $3 #siamo sicuri che numerico
     if test $3 -le 0
     then echo $3 non positivo
          exit 4
     fi
else
  echo $3 non numerico
  exit 5
fi

PATH=`pwd`:$PATH
export PATH

#Iniziamo la prima fase
#creiamo un file conta$$ il cui nome viene passato come argomento
> /tmp/conta$$

echo fase A 
#invochiamo il file comandi ricorsivo con solo i primi due parametri (il terzo non serve) e con il nome del file temporaneo
FCR.sh $1 $2 /tmp/conta$$   

#N.B. Andiamo a contare le linee del file /tmp/conta$$
D=`wc -l < /tmp/conta$$` 
echo Il numero di direttori totali della gerarchia che soddisfano la specifica = $D 
#Stampiamo (come richiesto dal testo) i loro nomi assoluti
cat /tmp/conta$$
#Controlliamo se dobbiamo passare alla seconda fase
if test $D -gt $3
then 
#Passiamo ora alla seconda fase che non viene risolta in questo caso con il file ricorsivo FCR.sh, ma direttamente in questo file comandi
#chiediamo all'utente il numero X
echo -n "Dammi il numero X che deve essere compreso fra 1 e $3: "
read X
#Controllo X
expr $X + 0  > /dev/null 2>&1
N1=$?
if test $N1 -ne 2 -a $N1 -ne 3
then echo numerico $X #siamo sicuri che numerico
     if test $X -lt 1 -o $X -gt $3
     then echo $X non compreso 
	  rm /tmp/conta$$ #poiche' stiamo uscendo a causa di un errore, cancelliamo il file temporaneo!
          exit 6
     fi
else
  echo $X non numerico
  rm /tmp/conta$$ #poiche' stiamo uscendo a causa di un errore, cancelliamo il file temporaneo!
  exit 7
fi

echo fase B 
#selezioniamo direttamente il nome del direttorio richiesto
d=`head -$X < /tmp/conta$$ | tail -1`
echo direttorio selezionato $d
cd $d
for i in *
do
if test -f $i -a -r $i
then
case $i in
*.$2) #stampiamo nome assoluto
	echo Nome assoluto file `pwd`/$i 
      #stampiamo prima linea del file
	head -1 < $i;;
*) ;;
esac
fi
done 
fi

#da ultimo eliminiamo il file temporaneo
rm /tmp/conta$$
