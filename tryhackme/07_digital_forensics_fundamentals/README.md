# Hacker vs. Hacker

## Room Information

- **Room URL:** [https://tryhackme.com/room/digitalforensicsfundamentals](https://tryhackme.com/room/digitalforensicsfundamentals)
- **Date Completed:** 2025-12-07

## Overview
Learn about digital forensics and related processes and experiment with a practical example.

## Digital Forensics

Digital forensics is the process of investigating and analyzing digital evidence to determine the truth about a crime or incident. It is a critical component of the criminal justice system and is used to collect, preserve, and analyze digital evidence in a legal and ethical manner.

## Methodology
the National Institute of Standards and Technology (NIST) defines a general process for every case.

They introduce the process of digital forensics in four phases.

1. Collection
2. Examination
3. Analysis
4. Reporting

### Collection
The first phase is the collection of the evidence.  
The goal is to collect all the evidence related to the crime or incident.

### Examination
Investigator examines data and filters the data because the collected data may overwhelm.  
This data usually needs to be filtered, and the data of interest needs to be extracted. 

### Analysis
Analyzing the data by correlating it with multiple pieces of evidence to draw conclusions.

### Reporting
Making a report of the investigation and the conclusions drawn.

This report contains the investigation’s methodology and detailed findings from the collected evidence. It may also contain recommendations. 

### Types of Digital Forensics
- Computer Forensics
- Mobile Forensics
- Network Forensics
- Database Forensics
- Cloud Forensics
- Email Forensics

## Evidence Acquisition
### Chain of Custody
The document is used to ensure data integrity during the collection.

### Write Blocker
During the collection process, the data may be modified by background tasks. The write blocker is used to prevent the modification of the data.

## Windows Forensics
### FTK Imager
FTK Imager is a widely used tool for taking disk images of Windows operating systems.

### Autopsy
Autopsy is a popular open-source digital forensics platform.

It offers various features during image analysis, including keyword search, deleted file recovery, file metadata, extension mismatch detection, and many more.

### DumpIt
DumpIt offers the utility of taking a memory image from a Windows operating system.

### Volatility
Volatility is a powerful open-source tool for analyzing memory images.

## Practice Digital Forensics
### pdfinfo
pdfinfo is a tool that displays information about a PDF file.

```shell
$ pdfinfo ransom-letter.pdf
Title:          Pay NOW
Subject:        We Have Gato
Author:         Ann Gree Shepherd
Creator:        Microsoft® Word 2016
Producer:       Microsoft® Word 2016
CreationDate:   Wed Feb 23 09:10:36 2022 GMT
ModDate:        Wed Feb 23 09:10:36 2022 GMT
Tagged:         yes
UserProperties: no
Suspects:       no
Form:           none
JavaScript:     no
Pages:          1
Encrypted:      no
Page size:      595.44 x 842.04 pts (A4)
Page rot:       0
File size:      71371 bytes
Optimized:      no
PDF version:    1.7
```

### exiftool
exiftool is a tool that displays metadata about a image.

We can see the GPS location in the web map. You have to replace `deg` to `°` and the location is `51°30'51.90"N, 0°5'38.73"W`;

```shell
$ exiftool letter-image.jpg
[...]
GPS Position                    : 51 deg 30' 51.90" N, 0 deg 5' 38.73" W
[...]
```

![image.png](images/image1.png)

## Tools Used

- pdfinfo
- exiftool

## Completed

![image.png](images/image2.png)

