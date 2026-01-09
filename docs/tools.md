# Tools

## Nmap

[Nmap](https://nmap.org/) is a tool that allows you to scan ports and services on a host.

- `-sV` is the version detection.
- `-oN` is the output file.

```shell
$ nmap -sV 10.49.143.242

Not shown: 999 closed tcp ports (reset)
PORT   STATE SERVICE VERSION
80/tcp open  http    Apache httpd 2.4.18 ((Ubuntu))
```

## Gobuster

[Gobuster](https://github.com/OJ/gobuster) is a tool that allows you to find directories and files on a web server.

- `-t` is the number of threads.
- `-w` is the wordlist to use.
- `-u` is the URL to scan.
- `-x` is the extension to scan.
- `-o` is the output file.

```shell
$ gobuster dir -u http://10.49.186.68 -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -t 50

===============================================================
Starting gobuster in directory enumeration mode
===============================================================
/blood                (Status: 301) [Size: 194] [--> http://10.49.186.68/blood/]
Progress: 220558 / 220558 (100.00%)
===============================================================
Finished
===============================================================
```


## SearchSploit
[SearchSploit](https://www.exploit-db.com/searchsploit) is a tool that allows you to search for exploits in the Exploit Database.

Path is the exploit allows you to attack the target with the vulnerability.

```shell
$ searchsploit fuel cms

---------------------------------------------------------------------------------------------------------------------------------------------------- ---------------------------------
 Exploit Title                                                                                                                                      |  Path
---------------------------------------------------------------------------------------------------------------------------------------------------- ---------------------------------
fuel CMS 1.4.1 - Remote Code Execution (1)                                                                                                          | linux/webapps/47138.py
Fuel CMS 1.4.1 - Remote Code Execution (2)                                                                                                          | php/webapps/49487.rb
Fuel CMS 1.4.1 - Remote Code Execution (3)                                                                                                          | php/webapps/50477.py
Fuel CMS 1.4.13 - 'col' Blind SQL Injection (Authenticated)                                                                                         | php/webapps/50523.txt
Fuel CMS 1.4.7 - 'col' SQL Injection (Authenticated)                                                                                                | php/webapps/48741.txt
Fuel CMS 1.4.8 - 'fuel_replace_id' SQL Injection (Authenticated)                                                                                    | php/webapps/48778.txt
Fuel CMS 1.5.0 - Cross-Site Request Forgery (CSRF)                                                                                                  | php/webapps/50884.txt
---------------------------------------------------------------------------------------------------------------------------------------------------- ---------------------------------
Shellcodes: No Results
```

You can download the exploit with the -m option.

```shell
$ searchsploit -m 50477

  Exploit: Fuel CMS 1.4.1 - Remote Code Execution (3)
      URL: https://www.exploit-db.com/exploits/50477
     Path: /usr/share/exploitdb/exploits/php/webapps/50477.py
    Codes: CVE-2018-16763
 Verified: False
File Type: Python script, ASCII text executable
Copied to: /home/kali/tryhackme/04_ignite/50477.py
```

## sqlmap
sqlmap is a tool that automates the process of detecting and exploiting SQL injection vulnerabilities in web applications.

[https://sqlmap.org/](https://sqlmap.org/)

## RustScan

[RustScan](https://github.com/RustScan/RustScan) is a faster port scanning tool than nmap.  
It scans only the ports that are open and it doesn't collect application version information.

You still should use nmap to scan the ports and application version information.

```shell
$ rustscan -a 10.49.186.68
┌──(kali㉿docker-desktop)-[~/tryhackme/06_hacker_vs_hacker]
└─$ rustscan -a 10.49.131.118 | tee rustscan.log
.----. .-. .-. .----..---.  .----. .---.   .--.  .-. .-.
| {}  }| { } |{ {__ {_   _}{ {__  /  ___} / {} \ |  `| |
| .-. \| {_} |.-._} } | |  .-._} }\     }/  /\  \| |\  |
`-' `-'`-----'`----'  `-'  `----'  `---' `-'  `-'`-' `-'
The Modern Day Port Scanner.
________________________________________
: http://discord.skerritt.blog         :
: https://github.com/RustScan/RustScan :
 --------------------------------------
You miss 100% of the ports you don't scan. - RustScan

[~] The config file is expected to be at "/home/kali/.rustscan.toml"
[~] File limit higher than batch size. Can increase speed by increasing batch size '-b 1048476'.
Open 10.49.131.118:22
Open 10.49.131.118:80
[~] Starting Script(s)
[>] Running script "nmap -vvv -p {{port}} -{{ipversion}} {{ip}} -e eth0" on ip 10.49.131.118
Depending on the complexity of the script, results may take some time to appear.
[~] Starting Nmap 7.95 ( https://nmap.org ) at 2025-12-05 04:11 UTC
Initiating Ping Scan at 04:11
Scanning 10.49.131.118 [4 ports]
Completed Ping Scan at 04:11, 0.02s elapsed (1 total hosts)
Initiating Parallel DNS resolution of 1 host. at 04:11
Completed Parallel DNS resolution of 1 host. at 04:12, 13.01s elapsed
DNS resolution of 1 IPs took 13.01s. Mode: Async [#: 1, OK: 0, NX: 0, DR: 1, SF: 0, TR: 3, CN: 0]
Initiating SYN Stealth Scan at 04:12
Scanning 10.49.131.118 [2 ports]
Discovered open port 22/tcp on 10.49.131.118
Discovered open port 80/tcp on 10.49.131.118
Completed SYN Stealth Scan at 04:12, 0.16s elapsed (2 total ports)
Nmap scan report for 10.49.131.118
Host is up, received reset ttl 64 (0.032s latency).
Scanned at 2025-12-05 04:12:06 UTC for 0s

PORT   STATE SERVICE REASON
22/tcp open  ssh     syn-ack ttl 64
80/tcp open  http    syn-ack ttl 64

Read data files from: /usr/share/nmap
Nmap done: 1 IP address (1 host up) scanned in 13.24 seconds
           Raw packets sent: 6 (240B) | Rcvd: 3 (128B)
```

## Wfuzz

[wfuzz](https://github.com/xmendez/wfuzz) is a tool that replaces any reference to the FUZZ keyword by the value of a given payload.

`FUZZ` is the keyword that will be replaced by the value of the payload.

- `-c` option is used to color the output.
- `-z` option is used to specify the payload.
- `--hh` option is used to hide responses with the specified code/lines/words/chars.

```shell
$ wfuzz -c -z file,/usr/share/wordlists/wfuzz/general/common.txt --hh 18 http://10.49.131.118/cvs/shell.pdf.php?FUZZ=id
```

## Linpeas

## Metasploit Framework
[Metasploit Framework](https://www.metasploit.com/) is a tool that allows you to exploit the web application.

You can search the vulnerabilities for any application and find exploits for it.

```shell
msf > search bolt

Matching Modules
================

   #  Name                                        Disclosure Date  Rank       Check  Description
   -  ----                                        ---------------  ----       -----  -----------
   0  exploit/unix/webapp/bolt_authenticated_rce  2020-05-07       great      Yes    Bolt CMS 3.7.0 - Authenticated Remote Code Execution
   1    \_ target: Linux (x86)                    .                .          .      .
   2    \_ target: Linux (x64)                    .                .          .      .
   3    \_ target: Linux (cmd)                    .                .          .      .
   4  exploit/multi/http/bolt_file_upload         2015-08-17       excellent  Yes    CMS Bolt File Upload Vulnerability


Interact with a module by name or index. For example info 4, use 4 or use exploit/multi/http/bolt_file_upload

msf > use 0
[*] Using configured payload cmd/unix/reverse_netcat
msf exploit(unix/webapp/bolt_authenticated_rce) >
```

## John the Ripper
[John the Ripper](https://www.openwall.com/john/) is a tool that allows you to crack password using a dictionary attack.

## Hashcat
[Hashcat](https://hashcat.net/hashcat/) is a tool that allows you to crack hashes using a dictionary attack.

You can find the mode from [example_hashes [hashcat wiki]](https://hashcat.net/wiki/doku.php?id=example_hashes)

```shell
# Crack the hash
$ hashcat '$apr1$BpZ.Q.1m$F0qqPwHSOG50URuOVQTTn.' /usr/share/wordlists/rockyou.txt -m 1600
...
$apr1$BpZ.Q.1m$F0qqPwHSOG50URuOVQTTn.:squidward
...
```

## BorgBackup
BorgBackup is a tool that allows you to backup and restore files using encryption.

[https://www.borgbackup.org/](https://www.borgbackup.org/)

```shell
# List the files
$ borg list home/field/dev/final_archive/
Enter passphrase for key /home/kali/tryhackme/09_cyborg/src/home/field/dev/final_archive:
music_archive                        Tue, 2020-12-29 14:00:38 [f789ddb6b0ec108d130d16adebf5713c29faf19c44cad5e1eeb8ba37277b1c82]

# Restore the files
$ borg extract home/field/dev/final_archive::music_archive
Enter passphrase for key /home/kali/tryhackme/09_cyborg/src/home/field/dev/final_archive:
```

### pdfinfo
pdfinfo is the Linux command that displays information about a PDF file.

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

## exiftool
exiftool is a tool that displays metadata about a image.

```shell
$ exiftool letter-image.jpg
[...]
GPS Position                    : 51 deg 30' 51.90" N, 0 deg 5' 38.73" W
[...]
```

## pdftotext
pdftotext is a tool that converts a pdf file to a text file.

```shell
$ pdftotext flag.pdf output.txt
$ cat output.txt
1n_pn9_&_pdf_724b1287}
```

## binwalk
[Binwalk](https://www.kali.org/tools/binwalk/) is a tool for searching a given binary image for embedded files and executable code.

```shell
$ binwalk flag.pdf
DECIMAL       HEXADECIMAL     DESCRIPTION
--------------------------------------------------------------------------------
0             0x0             PNG image, 50 x 50, 8-bit/color RGBA, non-interlaced
914           0x392           PDF document, version: "1.4"
1149          0x47D           Zlib compressed data, default compression
```

## foremost
[Foremost](https://www.kali.org/tools/foremost/) is a forensic program to recover lost files based on their headers, footers, and internal data structures.

Foremost can work on image files, such as those generated by dd, Safeback, Encase, etc, or directly on a drive.

```shell
$ foremost -i flag.pdf -o output
Processing: flag.pdf
|*|

$ tree output/
output/
├── audit.txt
└── png
    └── 00000000.png
```