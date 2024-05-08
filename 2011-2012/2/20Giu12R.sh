#!/bin/sh
#entro nel direttorio
cd $1
for i in *
do
        if test -f $i 
        then
                if test `wc -l < $i` -ge $2
                then 	
			#abbiamo trovato un file che soddisfa le specifiche 
			#stampiamo il suo nome assoluto sullo standard output e
			#appendiamo il suo nome nel file temporaneo che servira' per il file comandi principale
			echo File trovato  `pwd`/$i
                        echo `pwd`/$i >> /tmp/filetemp
                fi
        fi
done

#chiamata ricorsiva
for i in *
do
        if test -d $i -a -x $i
        then 
		#chiamata ricorsiva
		$0 `pwd`/$i $2
        fi
done
