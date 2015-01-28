#!/bin/bash
#Location of WEB-INF directory where gateway XML's are stored
DIRTYBIRD="/usr/local/tomcat/webapps/ceGateway/WEB-INF"

#List of islands
GATEWAYS="accesso23 accesso24 accesso25 accesso26 accesso27 accesso28 accesso90"

#List of sections in each gateway xml
CES="ceTIXV3 ceSeasonPassV3 ceSMP ceTixManagerV3 ceCRM ceLoginV2 ceSeatManager ceReportsV3 ceTracker ceMail ceSessionManager ceZip ceClientSync ceTrialPay ceRSAEncryption"

#Define which section you want to update
SECTION=$1

#Define param key
PARAMKEY=$2

#Define logging Y or N
LOGYN=$3

#Setting up the LINENUMBER and PORT2 array
declare -A LINENUMBER
declare -A PORT2

#Set up PORT2 array
PORT2[accesso10]=03
PORT2[accesso14]=14
PORT2[accesso15]=15
PORT2[accesso16]=16
PORT2[accesso17]=17
PORT2[accesso18]=18
PORT2[accesso21]=21
PORT2[accesso22]=22
PORT2[accesso23]=23
PORT2[accesso24]=24
PORT2[accesso25]=25
PORT2[accesso26]=26
PORT2[accesso27]=27
PORT2[accesso28]=28
PORT2[accesso28]=90
PORT2[AFE]=03
PORT2[brevard]=09
PORT2[cedarfair]=19
PORT2[coco]=11
PORT2[countrysprings]=12
PORT2[CZV3]=01
PORT2[demo]=07
PORT2[parc]=05
PORT2[scz]=13
PORT2[Shared]=06
PORT2[SixFlagsV3]=04
PORT2[spaceneedle]=20

#Set the first half of the port value depending on which section of the XML is chosen for update
if [ $SECTION == "ceTIXV3" ]
then
	PORT1=20
elif [ $SECTION == "ceSeasonPassV3" ]
then
	PORT1=73
elif [ $SECTION == "ceSMP" ]
then
	PORT1=70
elif [ $SECTION == "ceTixManagerV3" ]
then
	PORT1=62
elif [ $SECTION == "ceCRM" ]
then
	PORT1=57
elif [ $SECTION == "ceLoginV2" ]
then
	PORT1=58
elif [ $SECTION == "ceSeatManager" ]
then
	PORT1=67
elif [ $SECTION == "ceReportsV3" ]
then
	PORT1=72
elif [ $SECTION == "ceTracker" ]
then
	PORT1=65
elif [ $SECTION == "ceMail" ]
then
	PORT1=50
elif [ $SECTION == "ceSessionManager" ]
then
	PORT1=61
elif [ $SECTION == "ceZip" ]
then
	PORT1=64
elif [ $SECTION == "ceClientSync" ]
then
	PORT1=89
elif [ $SECTION == "ceTrialPay" ]
then
	PORT1=86
elif [ $SECTION == "ceRSAEncryption" ]
then
	PORT1=87
else
	echo "Section Not Entered, exiting"
	exit
fi

#For loop to give line number values to each section in the LINENUMBER array
for i in $GATEWAYS
do
	LINENUMBER[$i]=`cat $DIRTYBIRD/$i.xml | sed -n '/'$SECTION'/='`

done

#Add 1 to each number (for appending purposes)
for i in $GATEWAYS
do
	LINENUMBER[$i]=`expr ${LINENUMBER[$i]} + 1`
done

#Here's where the magic happens
for i in $GATEWAYS
do
sed -i "${LINENUMBER[$i]} i \ \ <PARAM key=\"$PARAMKEY\" url=\"http://192.168.2.13:$PORT1${PORT2[$i]}\" logging_on=\"$LOGYN\"\ />" $DIRTYBIRD/$i.xml
done
#for i in $GATEWAYS
#do
#echo $i:
#echo ${LINENUMBER[$i]}
#done
