# Introduction

Hello! This little script was created to update Google Domains Dynamic DNS synthetic record through their RESTful API.
You can read more about it [here](https://support.google.com/domains/answer/6147083)
This script was created using [AutoIt](https://www.autoitscript.com/site/)

## Build

 1. Download and Install [AutoIt](https://www.autoitscript.com/site/autoit/downloads/)
 2. Right-Click the .au3 file and compile the script.

## How to use

Simply place the GDomain.exe and the config.ini file into a suitable folder and add a GDomain.exe shortcut to the Windows Startup folder.
Any shortcuts in the Startup folder will automatically run each time the user logs in to Windows.

### Configuration

Open the config.ini file and set the values of the fields.

 - **username**: The username provided by Google.
 - **password**: The password provided by Google.
 - **hostname**: The hostname you want to update.
 - **myip**: The current IP set on Google Domains for that hostname, can be left blank.
 - **interval**: The interval time for the script to check if the IP has changed. (Minutes)

## Output

The script writes a .log file where you can see all the activity.