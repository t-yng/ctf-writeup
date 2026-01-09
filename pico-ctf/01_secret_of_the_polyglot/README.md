# Secret of the Polyglot

## Information

- **Event**: picoCTF 2024
- **Difficulty:** Easy
- **Date Completed:** 2026-01-08

## Overview
Examining a pdf file to find the flag.

## Check the pdf file

There is a part of the flag in the pdf file as text.

![image1.png](images/image1.png)

## Extract the flag

### pdfinfo
See the information of the pdf file.

```shell
$ pdfinfo flag2of2-final.pdf
Producer:        GPL Ghostscript 10.01.2
CreationDate:    Tue Mar 12 00:04:32 2024 UTC
ModDate:         Tue Mar 12 00:04:32 2024 UTC
Custom Metadata: no
Metadata Stream: yes
Tagged:          no
UserProperties:  no
Suspects:        no
Form:            none
JavaScript:      no
Pages:           1
Encrypted:       no
Page size:       595 x 842 pts (A4)
Page rot:        0
File size:       3362 bytes
Optimized:       no
PDF version:     1.4
```

Check the metadata of the pdf file. There is no valuable information in the metadata.

```shell
$ pdfinfo -meta flag2of2-final.pdf
<?xpacket begin='' id='W5M0MpCehiHzreSzNTczkc9d'?>
<?adobe-xap-filters esc="CRLF"?>
<x:xmpmeta xmlns:x='adobe:ns:meta/' x:xmptk='XMP toolkit 2.9.1-13, framework 1.6'>
<rdf:RDF xmlns:rdf='http://www.w3.org/1999/02/22-rdf-syntax-ns#' xmlns:iX='http://ns.adobe.com/iX/1.0/'>
<rdf:Description rdf:about="" xmlns:pdf='http://ns.adobe.com/pdf/1.3/' pdf:Producer='GPL Ghostscript 10.01.2'/>
<rdf:Description rdf:about="" xmlns:xmp='http://ns.adobe.com/xap/1.0/'><xmp:ModifyDate>2024-03-12T00:04:32Z</xmp:ModifyDate>
<xmp:CreateDate>2024-03-12T00:04:32Z</xmp:CreateDate>
<xmp:CreatorTool>UnknownApplication</xmp:CreatorTool></rdf:Description>
<rdf:Description rdf:about="" xmlns:xapMM='http://ns.adobe.com/xap/1.0/mm/' xapMM:DocumentID='uuid:a719dcc2-1820-11fa-0000-a987e57da984'/>
<rdf:Description rdf:about="" xmlns:dc='http://purl.org/dc/elements/1.1/' dc:format='application/pdf'><dc:title><rdf:Alt><rdf:li xml:lang='x-default'>Untitled</rdf:li></rdf:Alt></dc:title></rdf:Description>
</rdf:RDF>
</x:xmpmeta>

<?xpacket end='w'?>
```

### Hidden text
Check the hidden text in the pdf file.

```shell
$ pdftotext flag2of2-final.pdf output.txt
$ cat output.txt
1n_pn9_&_pdf_724b1287}
```

There is no hidden text in the pdf file.

### exiftool
See the exif data of the pdf file.   
I found the image file in the pdf file.

```shell
$ exiftool flag2of2-final.pdf
ExifTool Version Number         : 13.36
File Name                       : flag2of2-final.pdf
Directory                       : .
File Size                       : 3.4 kB
File Modification Date/Time     : 2026:01:09 00:28:05+00:00
File Access Date/Time           : 2026:01:09 00:28:08+00:00
File Inode Change Date/Time     : 2026:01:09 00:28:05+00:00
File Permissions                : -rw-r--r--
File Type                       : PNG
File Type Extension             : png
MIME Type                       : image/png
Image Width                     : 50
Image Height                    : 50
Bit Depth                       : 8
Color Type                      : RGB with Alpha
Compression                     : Deflate/Inflate
Filter                          : Adaptive
Interlace                       : Noninterlaced
Profile Name                    : ICC profile
Profile CMM Type                : Little CMS
Profile Version                 : 4.3.0
Profile Class                   : Display Device Profile
Color Space Data                : RGB
Profile Connection Space        : XYZ
Profile Date Time               : 2023:11:02 17:42:31
Profile File Signature          : acsp
Primary Platform                : Apple Computer Inc.
CMM Flags                       : Not Embedded, Independent
Device Manufacturer             :
Device Model                    :
Device Attributes               : Reflective, Glossy, Positive, Color
Rendering Intent                : Perceptual
Connection Space Illuminant     : 0.9642 1 0.82491
Profile Creator                 : Little CMS
Profile ID                      : 0
Profile Description             : GIMP built-in sRGB
Profile Copyright               : Public Domain
Media White Point               : 0.9642 1 0.82491
Chromatic Adaptation            : 1.04788 0.02292 -0.05022 0.02959 0.99048 -0.01707 -0.00925 0.01508 0.75168
Red Matrix Column               : 0.43604 0.22249 0.01392
Blue Matrix Column              : 0.14305 0.06061 0.71393
Green Matrix Column             : 0.38512 0.7169 0.09706
Red Tone Reproduction Curve     : (Binary data 32 bytes, use -b option to extract)
Green Tone Reproduction Curve   : (Binary data 32 bytes, use -b option to extract)
Blue Tone Reproduction Curve    : (Binary data 32 bytes, use -b option to extract)
Chromaticity Channels           : 3
Chromaticity Colorant           : Unknown
Chromaticity Channel 1          : 0.64 0.33002
Chromaticity Channel 2          : 0.3 0.60001
Chromaticity Channel 3          : 0.15001 0.06
Device Mfg Desc                 : GIMP
Device Model Desc               : sRGB
Pixels Per Unit X               : 11811
Pixels Per Unit Y               : 11811
Pixel Units                     : meters
Modify Date                     : 2023:11:02 17:57:06
Comment                         : Created with GIMP
Warning                         : [minor] Trailer data after PNG IEND chunk
Image Size                      : 50x50
Megapixels                      : 0.003
```

### Find the embedded image
PNG image is embedded in the pdf file.

```shell
$ binwalk flag2of2-final.pdf
DECIMAL       HEXADECIMAL     DESCRIPTION
--------------------------------------------------------------------------------
0             0x0             PNG image, 50 x 50, 8-bit/color RGBA, non-interlaced
914           0x392           PDF document, version: "1.4"
1149          0x47D           Zlib compressed data, default compression
```

### Extract the image

```shell
$ foremost -i flag2of2-final.pdf -o output
Processing: flag2of2-final.pdf
|*|

$ tree output/
output/
├── audit.txt
└── png
    └── 00000000.png
```

I found the part of the flag in the image file.

![image2.png](images/image2.png)

## Completed
Flag: `picoCTF{f1u3n7_1n_pn9_&_pdf_724b1287}`
