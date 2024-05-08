#!/bin/sh
#file comandi ricorsivo che torna il numero totale di livelli 
#contati fino a quel punto

#echo siamo nella fase $3
cd $1
conta=`expr $2 + 1`
#il primo livello verra' contato come livello 1
livello_max=$conta
for i in *
do
        if test -d $i -a -x $i
        then
#		echo stiamo per andare in `pwd`/$i
                FCR.sh `pwd`/$i $conta $3 $4
                ret=$?
		if test $ret -gt $livello_max 
                then
                        livello_max=$ret
                fi
        fi
done

#echo in `pwd` conta = $conta
if test $3 = B	#solo se siamo nella fase B bisogna fare questa parte di codice, mentre quella precedente e' comune ad entrambe le fasi! 
then
#echo siamo passati alla fase $3
if test $4 -eq $conta 
then
	echo  Adesso visualizzo il contenuto del direttorio `pwd` che fa parte del livello $4
	ls -l #se dovessimo visualizzare tutte le info inclusi i file nascosti sarebbe ls -la oppure inclusi i file nascosti a parte . e .. sarebbe ls -lA
fi 
fi 
exit $livello_max	#N.B. codice comune a tutte le fasi!
