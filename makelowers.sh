#!/bin/bash
ISLANDS=`ls /usr/local/shopv5/store | grep "-" | grep -v sw-sp | grep -v SF`
for i in $ISLANDS
do
	LISLAND=`echo $i | tr '[:upper:]' '[:lower:]'`
	ln -sf /usr/local/shopv5/store/5.4.3.2 $LISLAND
done
