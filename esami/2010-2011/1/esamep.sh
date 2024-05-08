#! /bin/sh
#Controllo che ci siano esattamente 3 parametri
case $# in
3);;
*) echo "Numero sbagliato di parametri: ci vogliono 3 parametri (nome ass dir, nome relativo file da cercare e numero intero positivo"
exit 1;;
esac

G=$1
F=$2
N=$3

#Controllo che sia il nome assoluto di direttorio
case $G in
	/*);;
	*) echo "$G non e' in forma assoluta"
	   exit 2;;
esac
#Controllo che sia un direttorio esplorabile
if test ! -d $G -o ! -x $G 
then
	echo "$G non e' un direttorio o non e' esplorabile"
	exit 3
fi

#Controllo che F sia un nome relativo
case $F in
	*/*) echo "$F non  e' in forma relativa"
	     exit 4;;
	*);;
esac

#Controllo che sia un numero > 0
test $N -gt 0 1>/dev/null 2>/dev/null
case $? in
	0);;
	*) echo "$N non e' un numero o non e' strettamente > 0"
	   exit 5;;
esac

PATH=`pwd`:$PATH
export PATH

#creaiamo un file temporaneo che serve solo per riportare le cose poi alla situazione precedente: non richiesto dalla soluzione
>  /tmp/perPulisci

#Fase A
#usiamo un file temporaneo che passeremo come ultimo parametro
> /tmp/esame$$
FCR.sh $G $F A /tmp/esame$$
#conto il numero di righe sul file temporaneo=numero di file trovati
NF=`wc -l < /tmp/esame$$`
echo "File trovati fase A: $NF"

#Se il numero file < N eseguo la fase B e C
if test $NF -lt $N
then 	
	FCR.sh $G $F B #nella fase B il file temporaneo non serve e quindi possiamo non passarlo!
	> /tmp/esame$$ #azzeriamo il file temporaneo
	FCR.sh $G $F C /tmp/esame$$
	#Riconto il numero di righe per controllare il numero dei file
	NF=`wc -l < /tmp/esame$$`
	echo "File trovati fase C: $NF"
fi
#da ultimo cancelliamo il file temporaneo
rm /tmp/esame$$
