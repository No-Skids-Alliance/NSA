.. _Lame Vuln Assess:

Vulnerability Assessment
========================

+-------------+-------------------+
|**Reference**|:ref:`searchsploit`|
+-------------+-------------------+


.. index:: SearchSploit

Now that we know what's running on the target, let's see if we can uncover any vulnerabilities. In the :ref:`Legacy <Legacy Vulnerability Scanning>` walk-through, we conducted a web search before turning to `SearchSploit`, but typically I like to do things the other way around.

`Google` and other search engines are a nearly-infinite repository of information. This can be a good thing, but it can also become a "rabbit-hole" as you chase down ever-more-archaic paths in the hopes of making an exploit work. `SearchSploit`, on the other hand, is finite. While it contains a robust selection of exploits for myriad services, it is still quite limited, which means it's a lot easier to avoid chasing false leads.

Personally, I prefer to use `Google` when `SearchSploit` provides no usable information, or when I need to learn more about a `SearchSploit` discovery.


vsftpd 2.3.4
------------
Let's take a look at what `SearchSploit` has to say about the software on our target. We'll start from the top with `vsftpd 2.3.4`:

.. code-block:: none

    kali@kali:~/HTB/Lame$ searchsploit --color --id vsftpd 2.3.4
    -------------------------------------------------------------------- ---------
     Exploit Title                                                      |  EDB-ID
    -------------------------------------------------------------------- ---------
    vsftpd 2.3.4 - Backdoor Command Execution (Metasploit)              | 17491
    -------------------------------------------------------------------- ---------
    Shellcodes: No Results


Wonderful! Right off the bat we've found a potential `Command Execution` vulnerability. We'll take a note, then move on to the next service.


OpenSSH 4.7p1
-------------
Our next scan is for `OpenSSH 4.7p1`:

.. code-block:: none

    kali@kali:~/HTB/Lame$ searchsploit --color --id openssh 4.7
    -------------------------------------------------------------------- ---------
     Exploit Title                                                      |  EDB-ID
    -------------------------------------------------------------------- ---------
    OpenSSH 2.3 < 7.7 - Username Enumeration                            | 45233
    OpenSSH 2.3 < 7.7 - Username Enumeration (PoC)                      | 45210
    OpenSSH < 6.6 SFTP (x64) - Command Execution                        | 45000
    OpenSSH < 6.6 SFTP - Command Execution                              | 45001
    OpenSSH < 7.4 - 'UsePrivilegeSeparation Disabled' Forwarded Unix Dom| 40962
    OpenSSH < 7.4 - agent Protocol Arbitrary Library Loading            | 40963
    OpenSSH < 7.7 - User Enumeration (2)                                | 45939
    -------------------------------------------------------------------- ---------
    Shellcodes: No Results


There are a lot of possibilities here, but nothing that specifically mentions version 4. Of the results, three are in regards to user enumeration, two involve command execution, and one is a local vulnerability. We can rule out the local vuln, since we're trying to gain remote access. We can also ignore the user enumeration vulnerabilities, since our `Samba` enumeration provided a list of users. The two remaining vulnerabilities are in regards to SFTP, and require known credentials in order to function. You can see this for yourself by using ``searchsploit -x`` to examine the source code for the provided exploits:

.. code-block:: none

    kali@kali:~/HTB/Lame$ searchsploit -x 45001
      Exploit: OpenSSH < 6.6 SFTP - Command Execution
          URL: https://www.exploit-db.com/exploits/45001
         Path: /usr/share/exploitdb/exploits/linux/remote/45001.py
    File Type: Python script, ASCII text executable, with CRLF line terminators

This command reveals the source code to the exploit:

.. code-block:: python

    # OpenSSH <= 6.6 SFTP misconfiguration exploit for 32/64bit Linux
    [...]
    username = 'secforce'
    password = 'secforce'
    [...]
    ssh.connect(hostname = host, port = port, username = username, password = password)
    [...]

In the above lines, we can see that the script requires a username and password, which we don't have. It appears that none of `SearchSploit`'s results will be of any use.


Samba 3.0.20
------------
Moving on to `Samba`:

.. code-block:: none

    kali@kali:~/HTB/Lame$ searchsploit --color --id samba 3.0.20
    -------------------------------------------------------------------- ---------
     Exploit Title                                                      |  EDB-ID
    -------------------------------------------------------------------- ---------
    Samba 3.0.10 < 3.3.5 - Format String / Security Bypass              | 10095
    Samba 3.0.20 < 3.0.25rc3 - 'Username' map script' Command Execution | 16320
    Samba < 3.0.20 - Remote Heap Overflow                               | 7701
    Samba < 3.0.20 - Remote Heap Overflow                               | 7701
    Samba < 3.6.2 (x86) - Denial of Service (PoC)                       | 36741
    -------------------------------------------------------------------- ---------
    Shellcodes: No Results


Our search revealed four possible vulnerabilities (one is repeated). The first two look promising; one appears to be a security bypass, and the other is a command-execution vulnerability. The next two are identical, and are specifically for ``Samba < 3.0.20``, meaning any version `prior to` our target version. These likely won't work for us. Finally, we've got no interest in the DoS exploit (remember, :ref:`don't be a dosser`).

Two out of four ain't bad! We'll make a note of the two potential vulnerabilities, and move on.


Debian 9 and Linux Kernel 4.9
-----------------------------
When seeking vulnerabilities for specific services, you'll often come up empty-handed. Vulnerabilities require analysts to discover them, and hackers to publish exploit code, otherwise they'll never be found in places like `Exploit Database`. If your target is running obscure software, such as a little-known niche web service or custom software developed "in-house," they might be full of vulnerabilities that have yet to be discovered!

Even with well-known services like `Samba`, a search including a version number might return no results. To find what you need, you may have to broaden your search to include more varied results.

When seeking vulnerabilities in a particular `Operating System`, however, we encounter the exact opposite problem; instead of having too few results to choose from, we wind up with too many.

.. figure:: images/0-google.png
   :width: 600px
   :align: center
   :alt: Google search for Debian 9 exploits: 855,000 results.

   `Google` search for `Debian 9` exploits: 855,000 results.

Even our `SearchSploit` results are expansive:

.. code-block:: none

    kali@kali:~/HTB/Lame$ searchsploit --color --id debian 9
    -------------------------------------------------------------------- ---------
     Exploit Title                                                      |  EDB-ID
    -------------------------------------------------------------------- ---------
    BSD/OS 2.1 / DG/UX 4.0 / Debian 0.93 / Digital UNIX 4.0 B / FreeBSD | 19203
    BSD/OS 2.1 / DG/UX 7.0 / Debian 1.3 / HP-UX 10.34 / IBM AIX 4.2 / SG| 19172
    BSD/OS 2.1 / DG/UX 7.0 / Debian 1.3 / HP-UX 10.34 / IBM AIX 4.2 / SG| 19173
    Caldera OpenLinux 2.2 / Debian 2.1/2.2 / RedHat 6.0 - Vixie Cron MAI| 19474
    Debian 2.0 - Super Syslog Buffer Overflow                           | 19270
    Debian 2.0/2.0 r5 / FreeBSD 3.2 / OpenBSD 2.4 / RedHat 5.2 i386 / S.| 19373
    Debian 2.0/2.0 r5 / FreeBSD 3.2 / OpenBSD 2.4 / RedHat 5.2 i386 / S.| 19374
    Debian 2.1 - apcd Symlink                                           | 19735
    Debian 2.1 - HTTPd                                                  | 19253
    Debian 2.1 - Print Queue Control                                    | 19384
    Debian 2.1/2.2 - Man Cache File Creation                            | 20897
    Debian OpenSSH - (Authenticated) Remote SELinux Privilege Escalation| 6094
    Debian suidmanager 0.18 - Command Execution                         | 19080
    Debian XTERM - 'DECRQSS/comments' Code Execution                    | 7681
    gpm 1.18.1/1.19 / Debian 2.x / RedHat 6.x / S.u.S.E 5.3/6.x - gpm Se| 19816
    Linux Kernel (Debian 7.7/8.5/9.0 / Ubuntu 14.04.2/16.04.2/17.04 / Fe| 42275
    Linux Kernel (Debian 7/8/9/10 / Fedora 23/24/25 / CentOS 5.3/5.11/6.| 42274
    Linux Kernel (Debian 9/10 / Ubuntu 14.04.5/16.04.2/17.04 / Fedora 23| 42276
    Linux Kernel 2.0.x (Debian 2.1 / RedHat 5.2) - Packet Length with Op| 19675
    Linux Kernel 2.2/2.3 (Debian Linux 2.1 / RedHat Linux 6.0 / SuSE Lin| 19241
    Linux Kernel 2.6 (Debian 4.0 / Ubuntu / Gentoo) UDEV < 1.4.1 - Local| 8478
    Linux Kernel 2.6.32-5 (Debian 6.0.5) - '/dev/ptmx' Key Stroke Timing| 24459
    Linux Kernel 2.6.x / 3.10.x / 4.14.x (RedHat / Debian / CentOS) (x64| 45516
    Linux Kernel 4.13 (Debian 9) - Local Privilege Escalation           | 44303
    Linux Kernel < 2.6.19 (Debian 4) - 'udp_sendmsg' Local Privilege Esc| 9575
    Linux Kernel < 2.6.7-rc3 (Slackware 9.1 / Debian 3.0) - 'sys_chown()| 718
    Linux Kernel < 3.16.39 (Debian 8 x64) - 'inotfiy' Local Privilege Es| 44302
    ntfs-3g (Debian 9) - Local Privilege Escalation                     | 41240
    OpenSSL 0.9.8c-1 < 0.9.8g-9 (Debian and Derivatives) - Predictable P| 5622
    OpenSSL 0.9.8c-1 < 0.9.8g-9 (Debian and Derivatives) - Predictable P| 5720
    OpenSSL 0.9.8c-1 < 0.9.8g-9 (Debian and Derivatives) - Predictable P| 5632
    phpGroupWare 0.9.13 - Debian Package Configuration                  | 21365
    Samba 2.2.8 (Linux Kernel 2.6 / Debian / Mandrake) - Share Privilege| 23674
    Stanford University bootpd 2.4.3 / Debian 2.0 - netstd              | 19256
    -------------------------------------------------------------------- ---------
    Shellcodes: No Results

Operating Systems are big, complex machines built of thousands of interconnected parts. When seeking vulnerabilities in an OS or kernel, you'll want to get a bit more specific. Have you gained access to the system, and you're trying to gain root? You'll want to search for `privilege escalation`:

.. code-block:: none

    kali@kali:~/HTB/Lame$ searchsploit --color --id debian 9 privilege escalation
    -------------------------------------------------------------------- ---------
     Exploit Title                                                      |  EDB-ID
    -------------------------------------------------------------------- ---------
    BSD/OS 2.1 / DG/UX 4.0 / Debian 0.93 / Digital UNIX 4.0 B / FreeBSD | 19203
    BSD/OS 2.1 / DG/UX 7.0 / Debian 1.3 / HP-UX 10.34 / IBM AIX 4.2 / SG| 19172
    BSD/OS 2.1 / DG/UX 7.0 / Debian 1.3 / HP-UX 10.34 / IBM AIX 4.2 / SG| 19173
    Debian OpenSSH - (Authenticated) Remote SELinux Privilege Escalation| 6094
    Linux Kernel (Debian 7.7/8.5/9.0 / Ubuntu 14.04.2/16.04.2/17.04 / Fe| 42275
    Linux Kernel (Debian 7/8/9/10 / Fedora 23/24/25 / CentOS 5.3/5.11/6.| 42274
    Linux Kernel (Debian 9/10 / Ubuntu 14.04.5/16.04.2/17.04 / Fedora 23| 42276
    Linux Kernel 2.6 (Debian 4.0 / Ubuntu / Gentoo) UDEV < 1.4.1 - Local| 8478
    Linux Kernel 2.6.x / 3.10.x / 4.14.x (RedHat / Debian / CentOS) (x64| 45516
    Linux Kernel 4.13 (Debian 9) - Local Privilege Escalation           | 44303
    Linux Kernel < 2.6.19 (Debian 4) - 'udp_sendmsg' Local Privilege Esc| 9575
    Linux Kernel < 2.6.7-rc3 (Slackware 9.1 / Debian 3.0) - 'sys_chown()| 718
    Linux Kernel < 3.16.39 (Debian 8 x64) - 'inotfiy' Local Privilege Es| 44302
    ntfs-3g (Debian 9) - Local Privilege Escalation                     | 41240
    Samba 2.2.8 (Linux Kernel 2.6 / Debian / Mandrake) - Share Privilege| 23674
    -------------------------------------------------------------------- ---------
    Shellcodes: No Results

That's still a lot of results, but we could narrow it down more and more until we find what we're looking for. However, this is a time-consuming process without a great deal of payoff, so as with brute-force attacks, I typically avoid a deep-dive into OS and kernel vulnerabilities until I've exhausted all other possibilities. If I can't find what I'm looking for on the first page of `Google` results, I'm probably barking up the wrong tree (or my `Google-fu` is weak).


Possible Targets
----------------
Here are the results of our vulnerability search, including EDB IDs:

* `vsftpd 2.3.4`: Backdoor Command Execution (17491)
* `Samba 3.0.20`: Security Bypass (10095) and Command Execution (16320)

It's not a lot, but three potential vulnerabilities is better than none!
