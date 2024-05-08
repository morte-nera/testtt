#Soluzione 16 Gennaio 2013
#!/bin/sh

#controllo numero parametri
case $# in
2);;
*)echo Errore: Usage is $0 dirass car
  exit 1
;;
esac

#controllo primo parametri nome assoluto e direttorio
case $1 in
/*) if test ! -d $1 -o ! -x $1
    then echo $1 non direttorio o non eseguibile 
	 exit 2
    fi
;;
*)echo $1 non nome assoluto
  exit 3
;;
esac

#controllo secondo parametro singolo carattere
case $2 in
?);;
*)echo $2 non singolo carattere
  exit 4
;;
esac

PATH=`pwd`:$PATH
export PATH
#creaiamo un file temporaneo che passeremo come ulteriore parametro al file comandi ricorsivo
> /tmp/conta$$
FCR.sh $1 $2 /tmp/conta$$
#stampiamo i nomi dei file trovati anche se il testo non lo richiede
cat /tmp/conta$$
#la chiamata alla parte C la commentiamo dato che per ora non è stata prodotta
#filec `cat /tmp/conta$$` $2 
rm /tmp/conta$$


