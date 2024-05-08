#!/bin/sh
#FCR.sh
#file comandi ricorsivo che scrive il nome dei file creati sul file temporaneo
#il cui nome e' passato come terzo argomento
NL=     #variabile in cui salviamo il numero di linee del file corrente

cd $1 	#ci posizioniamo nella directory giusta

if test -f $2 -a -r $2 		#se esiste un file leggibile con il nome specificato
then
	NL=`wc -l < $2`
	if test $NL -ge 4 #solo se il numero di linee e' maggiore o uguale di 4 si deve contare il file
	then
     		echo `pwd`/$2 $NL >> $3 #NOTA BENE: su una stessa linea sono inseriti nome assoluto file trovato e sua lunghezza in linee: per il funzionamento del cat usato nel for del file principale e' assolutamente indifferente; l'unica cosa che cambia che facendo in questo modo NON serve dividere per due il conteggio
    	fi
fi

for i in *
do
        if test -d $i -a -x $i
        then
                #chiamata ricorsiva cui passiamo come primo parametro il nome assoluto della directory
                FCR.sh `pwd`/$i $2 $3
        fi
done
