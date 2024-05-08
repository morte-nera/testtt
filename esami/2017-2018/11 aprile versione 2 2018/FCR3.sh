#!/bin/sh
#FCR.sh 
#file comandi ricorsivo che scrive il nome dei file creati sul file temporaneo 
#il cui nome e' passato come terzo argomento
NL= 	#variabile in cui salviamo il numero di linee del file corrente
cd $1 #ci posizioniamo nella directory giusta

case $1 in
*/$2)
	for i in *
	do
		if test -f $i -a -r $i	#per ogni file leggibile della directory cercata
		then
			NL=`wc -l < $i`
			if test $NL -ge 5	 #controlliamo la lunghezza in linee del file ora rispetto a 5!
			then
				tail -5 $i | head -1 > $i.quintultima	#creiamo un file con il nome specificato
				echo `pwd`/$i.quintultima >> $3		#salviamo il suo nome nel file temporaneo
			else
				> $i.NOquintultima			#creiamo un file con il nome specificato
				echo `pwd`/$i.NOquintultima >> $3	#salviamo il suo nome nel file temporaneo
			fi
		fi
	done;;
*);;
esac
for i in *
do
	if test -d $i -a -x $i
	then
		#chiamata ricorsiva cui passiamo come primo parametro il nome assoluto del directory 
		FCR3.sh `pwd`/$i $2 $3 
	fi
done
