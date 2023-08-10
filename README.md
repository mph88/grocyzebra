# grocyzebra
Transmits barcode from Zebra scanner to Barcode Buddy or Grocy. Thanks to `dcough` for the inspiration. This simple script listens to TCP packets on a particular port and forwards it Barcode Buddy for ingestion into Grocy. This was tested on a Zebra TC72, running Android 11, but will likely work on any Zebra handheld computer that uses the Data Wedge application.

## Installation
1. Pull Image: `git clone [thisrepo]`
2. `cd grocyzebra`
3. Edit `scanner.sh` by replacing `[BARCODE BUDDY IP:PORT]` and `[BARCODE BUDDY API KEY]` according to your setup.
4. `docker build -t grocyzebra .` (don't forget the period!)
5. `docker run -dp 58627:58627 grocyzebra` or use the sample docker compose file below.
6. Install Barcode Buddy and/or Grocy apps on the Zebra device.
7. Install Data Wedge profiles on your Zebra device using the configs below as a template. The Barcode Buddy profile uses this listener, whereas the Grocy one does not and simply uses a keyboard paste command. I wanted to keep both apps having separate triggers, but you could easily combine the two or even change scanner.sh to fit your needs for any other application.

### Docker Compose
```yaml
version: "3.2"
services:
  grocyzebra:
    image: grocyzebra
    container_name: grocyzebra
    ports:
      - 58627:58627
    restart: unless-stopped
```
### Data Wedge Profile for Barcode Buddy
Create a new profile with the default settings and these changes:
```
Profile enabled: ✅
Applications
  Associated apps: * de.bulling.barcodebuddyscanner
Keystroke output
  Enabled: ❌
IP output
  Enabled: ✅
  Remote Wedge: ❌
  Protocol: TCP
  IP address: [IP address of grocyzebra]
  Port: 58627
    Basic data formatting
      IP output
        Enable: ✅
        Send data: ✅
        Send ENTER key: ✅
```

### Data Wedge Profile for Grocy
Create a new profile with the default settings and these changes:
```
Profile enabled: ✅
Applications
  Associated apps: * xyz.zedler.patrick.grocy
Keystroke output
  Enabled: ✅
  Basic data formatting
    Enable: ✅
    Send data: ✅
    Send ENTER key: ✅
```
