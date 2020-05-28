.. _Lame Vuln Assess:

Vulnerability Assessment
========================

+-------------+-------------------+
|**Reference**|:ref:`nmap <nmap>` |
|             |                   |
|             |:ref:`searchsploit`|
+-------------+-------------------+



Searching for Vulnerabilities with SearchSploit
-----------------------------------------------

.. index:: SearchSploit

Now that we know what's running on the target, let's see if we can uncover any vulnerabilities. In the :ref:`Legacy <Legacy Vulnerability Scanning>` walk-through, we conducted a web search before turning to `SearchSploit`, but typically I like to do things the other way around.

`Google` and other search engines are a nearly-infinite repository of information. This can be a good thing, but it can also become a "rabbit-hole" as you chase down ever-more-archaic paths in the hopes of making an exploit work. `SearchSploit`, on the other hand, is finite. While it contains a robust selection of exploits for myriad services, it is still quite limited, which means it's a lot easier to avoid chasing false leads.

Personally, I prefer to use `Google` when `SearchSploit` provides no usable information, or when I need to learn more about a `SearchSploit` discovery.


vsftpd 2.3.4
~~~~~~~~~~~~
Let's take a look at what `SearchSploit` has to say about the software on our target. We'll start from the top with `vsftpd 2.3.4`:

.. code-block:: none

    kali@kali:~$ searchsploit --color vsftpd 2.3.4
    ------------------------------------------------------- ----------------------
     Exploit Title                                         |  Path
    ------------------------------------------------------- ----------------------
    vsftpd 2.3.4 - Backdoor Command Execution (Metasploit) | unix/remote/17491.rb
    ------------------------------------------------------- ----------------------
    Shellcodes: No Results

Wonderful! Right off the bat we've found a potential `Command Execution` vulnerability. We'll take a note, then move on to the next service.


OpenSSH 4.7p1
~~~~~~~~~~~~~
Our next scan is for `OpenSSH 4.7p1`:

.. code-block:: none

    kali@kali:~$ searchsploit --color openssh 4.7
    ------------------------------------------------------- -----------------------------
     Exploit Title                                         |  Path
    ------------------------------------------------------- -----------------------------
    OpenSSH 2.3 < 7.7 - Username Enumeration               | linux/remote/45233.py
    OpenSSH 2.3 < 7.7 - Username Enumeration (PoC)         | linux/remote/45210.py
    OpenSSH < 6.6 SFTP (x64) - Command Execution           | linux_x86-64/remote/45000.c
    OpenSSH < 6.6 SFTP - Command Execution                 | linux/remote/45001.py
    OpenSSH < 7.4 - 'UsePrivilegeSeparation Disabled' Forwa| linux/local/40962.txt
    OpenSSH < 7.4 - agent Protocol Arbitrary Library Loadin| linux/remote/40963.txt
    OpenSSH < 7.7 - User Enumeration (2)                   | linux/remote/45939.py
    ------------------------------------------------------- -----------------------------
    Shellcodes: No Results

There are a lot of possibilities here, but nothing that specifically mentions version 4. Of the results, three are in regards to user enumeration, two involve command execution, and one is a local exploit. We can rule out the local exploit, since we're trying to gain remote access. We can also ignore the user enumeration exploits, since our `Samba` enumeration provided a list of users. The two remaining exploits are in regards to SFTP, and require known credentials in order to function. You can see this for yourself by using ``searchsploit -x`` along with the exploit number:

.. code-block:: none

    kali@kali:~$ searchsploit -x 45001
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

In the above lines, we can see that the script requires a username and password, which we don't have.


Samba 3.0.20
~~~~~~~~~~~~
Moving on to `Samba`:

.. code-block:: none

    kali@kali:~$ searchsploit --color samba 3.0.20
    ------------------------------------------------------ ---------------------------
     Exploit Title                                        |  Path
    ------------------------------------------------------ ---------------------------
    Samba 3.0.10 < 3.3.5 - Format String / Security Bypass| multiple/remote/10095.txt
    Samba 3.0.20 < 3.0.25rc3 - 'Username' map script' Comm| unix/remote/16320.rb
    Samba < 3.0.20 - Remote Heap Overflow                 | linux/remote/7701.txt
    Samba < 3.0.20 - Remote Heap Overflow                 | linux/remote/7701.txt
    Samba < 3.6.2 (x86) - Denial of Service (PoC)         | linux_x86/dos/36741.py
    ------------------------------------------------------ ---------------------------
    Shellcodes: No Results

Our search revealed five possible vulnerabilities. The first two look promising; one appears to be a security bypass, and the other is a command-execution vulnerability. The next two are specifically for ``Samba < 3.0.20``, meaning any version `prior to` our target version. These likely won't work for us. Finally, we've got no interest in the DoS exploit (see: :ref:`don't be a dosser`).
