IPCamViewer is an ActiveX control that allows to output to any application the current JPG view of any IP camera with JPG output by using it's HTTP address.


# How to use #

## Register the ActiveX control ##

regsvr32.exe IPCamViewer.ocx

## Add the IPCamViewer control to you application ##

![http://img405.imageshack.us/img405/2669/vsshot98.jpg](http://img405.imageshack.us/img405/2669/vsshot98.jpg)

## Set default settings ##

  * **Host** (eg: 192.168.1.62)
  * **Port** (eg: 80)
  * **JpgURL** (eg: /imagep/picture.jpg or eg: /picture.jpg?username=admin&password=1234)
  * **Autoconnect** (eg: true to auconnect when loaded)

## Start it ##

  * **Connect**
  * **Disconnect**

## Advanced settings ##

### Authentication ###

  * **Username** (eg: admin)
  * **Password** (eg: 1234)

### Automatic capture ###

  * **Autocapture** (eg: true to auto save picture to jpg at every interval)
  * **CapturePath** (eg: c:\temp or c:\temp\)
  * **CaptureInterval** (eg: 1000 for 1000ms = 1s)
  * **CameraName** (eg: mycamera will output a file named "mycamera-13-07-12-14-32-01.jpg" for a capture taken the 12nd of July 2013 at 14:32 and 01 second)


## Delphi users ##

IPCamViewer is a VCL component, a component package and all sources and are provided. (You need at least the Indy 10 libraries).