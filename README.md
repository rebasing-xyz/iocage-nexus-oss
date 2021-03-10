# IOCage TrueNAS Nexus OSS Plugin

TrueNAS IOCage Plugin for Nexus Repository OSS

 - Nexus OSS download page: https://help.sonatype.com/repomanager3/download

This repository contains all files needed to deploy it on TrueNAS.
For more information about the purpose of each file, please take a look [here](https://www.truenas.com/docs/hub/contributing/creating-plugins/).


## Installing manually

This step might requires elevated privilege on TrueNAS Web Console.


## Installing from TrueNAS Community Plugins

First download the plugin descriptor to your local system:

```bash
root@truenas[/tmp]# git clone https://github.com/rebasing-xyz/iocage-nexus-oss.git
root@truenas[/tmp]# cd iocage-nexus-oss
```

Install the plugin, remember to update the network settings as needed:

```bash
root@truenas[/tmp]# iocage -D fetch -P nexus-oss.json --branch main
```

By default, dhcp will be used.


## Work In Progress

This is a WIP plugin, and some features might not be available.
 - At this point, it exposes only plain text http protocol
 - No custom configuration for JVM, to do this edit this FILE manually and tune it to fit your needs.
 - Default exposed port is 8081.

Feel free to raise an issue [here](https://github.com/rebase-xyz/iocage-nexus-oss/issues/new/choose) if you find a bug or have suggestions for improvement.


## Known issues

 - Still using root to start the service, for some reason the shell gets frozen if testing it manually with
   `iocage -D fetch -P nexus-oss.json --branch main`
   

