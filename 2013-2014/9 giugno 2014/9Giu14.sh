#!/bin/sh
#Soluzione della Prova del 9 Giugno 2014
#versione che usa un file temporaneo e usa FCR.sh per tutte le fasi

case $# in
0|1)	echo Errore: numero parametri is $# quindi pochi parametri. Usage is $0 dirass1 dirass2 ...
	exit 1;;
*) 	echo OK: da qui in poi proseguiamo con $# parametri ;;
esac
#in $* abbiamo solo i nomi delle gerarchie e quindi possiamo fare i controlli sui nomi assoluti e sui direttori in un for
for i 
do
	case $i in
	/*) if test ! -d $i -o ! -x $i
	    then
	    echo $i non direttorio
	    exit 2
	    fi;;
	*)  echo $i non nome assoluto; exit 3;;
	esac
done
#controlli sui parametri finiti possiamo passare alle N fasi
PATH=`pwd`:$PATH
export PATH

n=1 #serve per dare un nome diverso ai file temporanei e volendo per dire in che fase siamo
for i
do
	> /tmp/conta$$-$n #creaimo/azzeriamo il file temporaneo
	echo fase $n 
 	#Il programma, per ognuna delle N fasi, deve richiedere all'utente un numero X intero strettamente positivo e maggiore di 255 
	echo -n "Dammi un numero intero strettamente positivo e maggiore di 255  "
	read X
	#Controllo X
	case $X in
	*[!0-9]*) echo non numerico o non positivo
		  rm /tmp/conta$$-$n #poiche' stiamo uscendo a causa di un errore, cancelliamo il file temporaneo!
		  exit 4;;
	*) ;;
	esac
	if test $X -le 255
	then
		echo Numero fornito $X non strettamente maggiore di 255 
		rm /tmp/conta$$-$n #poiche' stiamo uscendo a causa di un errore, cancelliamo il file temporaneo!
		exit 5
	fi
	#invochiamo il file comandi ricorsivo con la gerarchia, il carattere iniziale delle linee e il file temporaneo
	FCR.sh $i $X /tmp/conta$$-$n   
	n=`expr $n + 1`
done

#terminate tutte le ricerche ricorsive cioe' le N fasi
n=1 #serve per dare un nome diverso ai file temporanei e volendo per dire in che fase siamo
PFiles= #serve per accumulare tutti i primi file delle varie gerarchie
for i
do
	#N.B. Andiamo a contare le linee del file /tmp/conta$$-$n
	F=`wc -l < /tmp/conta$$-$n` 
	echo Il numero di file totali della gerarchia $i che soddisfano la specifica = $F 
	echo i file trovati sono 
	cat  /tmp/conta$$-$n
	#quindi, si deve selezionare (sempre per ogni gerarchia Gi) il primo file trovato PFi
	PFiles="$PFiles `head -1  < /tmp/conta$$-$n`"
	#da ultimo eliminiamo il file temporaneo
	rm /tmp/conta$$-$n
	n=`expr $n + 1`
done 
#Infine, si deve invocare la parte in C passando come parametri gli N nomi assoluti dei file selezionati PF0, PF1, ..., PFN-1. 
9Giu14 $PFiles
