#!/bin/sh
#Soluzione della Prima Prova in itinere del 5 Aprile 2019 - testo turni 1 e 2
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

F=$1 #salviamo il primo parametro
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
        #invochiamo il file comandi ricorsivo con la gerarchia, il nome relativo del file e il file temporaneo
        FCR.sh $i $F /tmp/conta$$
done
#terminate tutte le ricerche ricorsive cioe' le N fasi
#N.B. Andiamo a contare le linee del file /tmp/conta$$
echo Il numero di file totali che sono stati trovati sono = `wc -l < /tmp/conta$$`
c=0	#variabile che serve nel for successivo per capire se l'elemento corrente del for e' un nome assoluto di file o la sua lunghezza in linee
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
		echo -n "dammi un numero compreso fra 1 e $i estremi compresi  "
		read X
		#controlliamo che quanto inserito dall'utente sia una stringa numerica (con case) 
		case $X in
		*[!0-9]*) echo stringa inserita $X non numerica
		          exit 5;;
		*) ;;
      		esac		
		#controlliamo che il numero sia nel range giusto 
		if test $X -ge 1 -a $X -le $i
		then
			#poiche' alcuni testi richiedevano le prime X linee e altri le ultime X linee, si sono riportate entrambe le versioni!
			echo le prime $X linee del file sono
			head -$X $nomefile
			echo le ultime $X linee del file sono
			tail -$X $nomefile
		else echo Numero inserito $X non nel range #in questo caso, decidiamo di non uscire con errore, ma di passare al prossimo se esiste!
		fi
	fi
done
#da ultimo eliminiamo il file temporaneo
rm /tmp/conta$$
