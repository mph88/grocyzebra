#!/bin/ash
while true;do

# Use socat to listen on TCP to the docker container IP address and port specified in the Zebra scanner's IP Output section and store as variable barcodeinput
        barcodeinput="$(socat -u TCP-L:58627, STDOUT)"

# Set Barcode Buddy API url as a variable
        apiurl="http://[BARCODE BUDDY IP:PORT]api/action/scan?apikey=[BARCODE BUDDY API KEY]&add="

# Send barcodeinput to Barcode Buddy API url
        apirequest=$(curl $apiurl$barcodeinput)
        echo $apirequest
done
