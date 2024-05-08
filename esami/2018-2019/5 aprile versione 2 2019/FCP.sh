#!/bin/sh
#Soluzione della Prima Prova in itinere del 5 Aprile 2019 - testo turni 3 e 4
#versione che usa un file temporaneo e usa FCR.sh per tutte le fasi

#controllo sul numero dei parametri N >= 2 e quindi N+1 >=3
case $# in
0|1|2)  echo Errore: numero parametri is $# quindi pochi parametri. Usage is $0 nomedir dirass1 dirass2 ...
        exit 1;;
*)      echo DEBUG-OK: da qui in poi proseguiamo con $# parametri ;;
esac

#Controllo primo parametro sia dato in forma relativa semplice
case $1 in
*/*) echo Errore: $1 non in forma relativa semplice
    exit 2;;
*) ;;
esac

D=$1 #salviamo il primo parametro
#quindi ora possiamo usare il comando shift
shift

#ora in $* abbiamo solo i nomi delle gerarchie e quindi possiamo fare i controlli sui nomi assoluti e sulle directory in un for
for i
do
        case $i in
        /*) if test ! -d $i -o ! -x $i
            then
            echo $i non directory o non traversabile
            exit 3
            fi;;
        *)  echo $i non nome assoluto; exit 4;;
        esac
done
#controlli sui parametri finiti possiamo passare alle N fasi
PATH=`pwd`:$PATH
export PATH
> /tmp/conta$$ #creiamo/azzeriamo il file temporaneo. NOTA BENE: SOLO 1 file temporaneo!

for i
do
        echo fase per $i
        #invochiamo il file comandi ricorsivo con la gerarchia, il nome relativo della directory e il file temporaneo
        FCR.sh $i $D /tmp/conta$$
done
#terminate tutte le ricerche ricorsive cioe' le N fasi
#N.B. Andiamo a contare le linee del file /tmp/conta$$
echo Il numero di file totali che sono stati trovati sono = `wc -l < /tmp/conta$$`
c=0	#variabile che serve nel for successivo per capire se l'elemento corrente del for e' un nome assoluto di file o la sua posizione
for i in `cat /tmp/conta$$`
do
        #Stampiamo (come richiesto dal testo) i nomi assoluti dei file trovati e la lunghezza in linee
 	c=`expr $c + 1`
	if test `expr $c % 2` -eq 1
	then 
		echo elemento dispari, quindi nome assoluto del file $i
		nomefile=$i	#memorizzamo il nome del file che ci serve nella iterazione seguente
       	else 
		echo elemento pari, quindi lunghezza in linee del file = $i
		echo -n "dammi un numero compreso fra 1 e 4 estremi compresi  "
		read K
		#controlliamo che quanto inserito dall'utente sia una stringa numerica (con case)
		case $K in
		*[!0-9]*) echo stringa inserita non numerica
		          exit 5;;
		*) ;;
      		esac		
		#controlliamo che il numero sia nel range giusto 
		if test $K -ge 1 -a $K -le 4
		then
			#poiche' alcuni testi richiedevano la linea k-esima dall'inizio e altri la linea k-esima dalla fine, si sono riportate entrambe le versioni!
			echo la linea $K-esima da inizio del file 
			head -$K $nomefile | tail -1
			echo la linea $K-esima dalla fine del file 
			tail -$K $nomefile | head -1
		else echo Numero inserito $K non nel range #in questo caso, decisiamo di non uscire con errore, ma di passare al prossimo se esiste!
		fi
	fi
done

#da ultimo eliminiamo il file temporaneo
rm /tmp/conta$$
