#!/bin/sh
#esame 15 Gennaio 2014
#ricevo G1 G2 e K > 0
#assegnamo i parametri alle variabili
#controllo numero parametri
case $# in
  3);;
  *)	echo "Errore numero parametri"
	exit 1;;
esac

#controllo primo parametro direttorio leggibile ed eseguibile con path assoluto
case $1 in
  	/*)if [ ! -d $1 -o ! -x $1 ]
	   then
		echo "$1 Non direttorio o non eseguibile";
		exit 2
	   fi;;
  	*) echo "$1 Nome non assoluto"
	   exit 3;;
esac
#controllo secondo parametro direttorio leggibile ed eseguibile con path assoluto
case $2 in
  	/*)if [ ! -d $2 -o ! -x $2 ]
	   then
		echo "$2 Non direttorio o non eseguibile";
		exit 4
	   fi;;
  	*) echo "$2 Nome non assoluto"
	   exit 5;;
esac
#controllo numerico e strettamente positivo
expr $3 + 0 >/dev/null 2>&1
if [ $? -eq 2 -o $? -eq 3 ]
then
	echo "$3 parametro non numerico"
	exit 6
fi

if [ $3 -le 0 ]
then
	echo "$3 Non strettamente positivo" 
	exit 7
fi

#predisposizione ricorsione
PATH=`pwd`:$PATH
export PATH
#creo due file temporanei dove memorizzare percorsi assoluti file validi
>/tmp/conta1-$$
>/tmp/conta2-$$
#lancio FCR.sh con prima gerarchia G1 $K e il file temporaneo
FCR.sh $1 $3 /tmp/conta1-$$
cont1=`wc -l < /tmp/conta1-$$`
#lancio ancora FCR.sh con seconda gerachia G2 K e il file temporaneo
FCR.sh $2 $3 /tmp/conta2-$$
cont2=`wc -l < /tmp/conta2-$$`

echo "cont1 = $cont1"
echo "cont2 = $cont2"
echo i file trovati sono
cat /tmp/conta1-$$
echo e
cat /tmp/conta2-$$
#ora ho il numero globale di file validi
if [ $cont1 -eq $cont2 -a $cont1 -eq $3 ]
then
	15Gen14 `cat /tmp/conta1-$$` `cat /tmp/conta2-$$` 
fi 
#al termine rimuviamo i due file temporanei
rm /tmp/conta1-$$
rm /tmp/conta2-$$
