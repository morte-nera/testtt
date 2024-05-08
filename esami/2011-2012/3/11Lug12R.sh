#!/bin/sh
#entro nel direttorio
cd $1
#azzero la variabile che serve per il conteggio dei file  
F=0
#azzero la variabile che serve per il conteggio dei direttori 
D=0
for i in *
do
        if test -f $i 
        then
		#aggiorniamo il contatore 
		F=`expr $F + 1`
	else 
		if test -d $i
		then
		D=`expr $D + 1`
		fi
        fi
done
                 
if test $F -eq $2 -a $D -eq 0
then
#abbiamo trovato un direttorio giusto
#stampiamo il nome su standard output
       echo Trovato direttorio giusto `pwd` 
#inseriamo il nome nel file temporaneo
       pwd >> $3
fi

#chiamata ricorsiva
for i in *
do
        if test -d $i -a -x $i
        then 
		#chiamata ricorsiva
		$0 `pwd`/$i $2 $3
        fi
done

