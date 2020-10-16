# ABAP Object Oriented Basics 2019

[![REUSE status](https://api.reuse.software/badge/github.com/SAP-samples/abap-oo-basics)](https://api.reuse.software/info/github.com/SAP-samples/abap-oo-basics)

## Description
This is an update to the 10 year old ABAP Object Oriented eLearning series.  What started as an update to improve the video resolution also turned into modernizing the tooling and ABAP syntax used to teach the basic Object Oriented concepts.
Here is the YouTube Playlist that goes along with this code sample:
https://www.youtube.com/playlist?list=PLoc6uc3ML1JT55KwLJVe1QXnsP9emoJG2

ABAP OO 2019 Part 1 - Introduction

[![](http://img.youtube.com/vi/SMk9dy9IfME/0.jpg)](http://www.youtube.com/watch?v=SMk9dy9IfME "ABAP OO 2019 Part 1 - Introduction")

ABAP OO 2019 Part 2 - Static vs. Instance

[![](http://img.youtube.com/vi/Kq6L3pdXAp0/0.jpg)](http://www.youtube.com/watch?v=Kq6L3pdXAp0 "ABAP OO 2019 Part 2 - Static vs. Instance")

ABAP OO 2019 Part 3 - Visibility

[![](http://img.youtube.com/vi/JGCNWGhxyIA/0.jpg)](http://www.youtube.com/watch?v=JGCNWGhxyIA "ABAP OO 2019 Part 3 - Visibility")

ABAP OO 2019 Part 4 - Exceptions

[![](http://img.youtube.com/vi/1YX1mveqXj4/0.jpg)](http://www.youtube.com/watch?v=1YX1mveqXj4 "ABAP OO 2019 Part 4 - Exceptions")

ABAP OO 2019 Part 5 - Inheritance

[![](http://img.youtube.com/vi/bqxqGTzQ5sM/0.jpg)](http://www.youtube.com/watch?v=bqxqGTzQ5sM "ABAP OO 2019 Part 5 - Inheritance")

## Requirements
Make sure to fulfill the following requirements:
* You have access to an SAP Cloud Platform ABAP Environment instance (see [here](https://blogs.sap.com/2018/09/04/sap-cloud-platform-abap-environment) for additional information).
* You have downloaded and installed ABAP Development Tools (ADT). Make sure to use the most recent version as indicated on the [installation page](https://tools.hana.ondemand.com/#abap). 
* You have created an ABAP Cloud Project in ADT that allows you to access your SAP Cloud Platform ABAP Environment instance (see [here](https://help.sap.com/viewer/5371047f1273405bb46725a417f95433/Cloud/en-US/99cc54393e4c4e77a5b7f05567d4d14c.html) for additional information). Your log-on language is English.
* You have installed the [abapGit](https://github.com/abapGit/eclipse.abapgit.org) plug-in for ADT from the update site `http://eclipse.abapgit.org/updatesite/`.

## Download and Installation
Use the abapGit plug-in to install the ABAP OO Examples by executing the following steps:
1. In your ABAP cloud project, create an ABAP package for the demo content to be downloaded (leave the suggested values unchanged when following the steps in the package creation wizard).
2. To add the <em>abapGit Repositories</em> view to the <em>ABAP</em> perspective, click `Window` > `Show View` > `Other...` from the menu bar and choose `abapGit Repositories`.
3. In the <em>abapGit Repositories</em> view, click the `+` icon to clone an abapGit repository.
4. Enter the following URL of this repository: `https://github.com/SAP-samples/abap-oo-basics` and choose <em>Next</em>.
5. Create a new transport request that you only use for this demo content installation (recommendation) and choose <em>Finish</em> to link the Git repository to your ABAP cloud project. The repository appears in the abapGit Repositories View with status <em>Linked</em>.
6. Right-click on the new ABAP repository and choose `pull` to start the cloning of the repository contents. Note that this procedure may take a few minutes. 
8. Once the cloning has finished, the status is set to `Pulled Successfully`. Then refresh your project tree. 

As a result of the installation procedure above, the ABAP system creates an inactive version of all artifacts from the demo content

To activate all development objects from this sample: 
1. Click the mass-activation icon (<em>Activate Inactive ABAP Development Objects</em>) in the toolbar.  
2. In the dialog that appears, select all development objects in the transport request (that you created for the demo content installation) and choose `Activate`.

## Known Issues
In the ABAP Trial on SAP Cloud Platform you sharing an ABAP instance with many other users. Only one user on this system may import this sample as all object names must be globally unique. If you receive an error that the objects already exists upon import, search the system for classes named ZCL_OO_TUTORIAL*.  Someone has already imported the content in your trial system and you can simply start with that imported version. 

## How to obtain support
This project is provided "as-is": there is no guarantee that raised issues will be answered or addressed in future releases.

## License
Copyright (c) 2020 SAP SE or an SAP affiliate company. All rights reserved. 
This project is licensed under the Apache Software License, version 2.0 except as noted otherwise in the [LICENSE](LICENSES/Apache-2.0.txt) file.
