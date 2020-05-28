.. _Lame Vuln Assess:

Vulnerability Assessment
========================

+-------------+-------------------+
|**Reference**|:ref:`nmap <nmap>` |
|             |                   |
|             |:ref:`searchsploit`|
+-------------+-------------------+


.. index:: SearchSploit

Now that we know what's running on the target, let's see if we can uncover any vulnerabilities. In the :ref:`Legacy <Legacy Vulnerability Scanning>` walk-through, we conducted a web search before turning to `SearchSploit`, but typically I like to do things the other way around.

`Google` and other search engines are a nearly-infinite repository of information. This can be a good thing, but it can also become a "rabbit-hole" as you chase down ever-more-archaic paths in the hopes of making an exploit work. `SearchSploit`, on the other hand, is finite. While it contains a robust selection of exploits for myriad services, it is still quite limited, which means it's a lot easier to avoid chasing false leads.

Personally, I prefer to use `Google` when `SearchSploit` provides no usable information, or when I need to learn more about a `SearchSploit` discovery.


vsftpd 2.3.4
~~~~~~~~~~~~
Let's take a look at what `SearchSploit` has to say about the software on our target. We'll start from the top with `vsftpd 2.3.4`:

.. code-block:: none

    kali@kali:~$ searchsploit --color --id vsftpd 2.3.4
    -------------------------------------------------------------------- ---------
     Exploit Title                                                      |  EDB-ID
    -------------------------------------------------------------------- ---------
    vsftpd 2.3.4 - Backdoor Command Execution (Metasploit)              | 17491
    -------------------------------------------------------------------- ---------
    Shellcodes: No Results


Wonderful! Right off the bat we've found a potential `Command Execution` vulnerability. We'll take a note, then move on to the next service.


OpenSSH 4.7p1
~~~~~~~~~~~~~
Our next scan is for `OpenSSH 4.7p1`:

.. code-block:: none

    kali@kali:~$ searchsploit --color --id openssh 4.7
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

In the above lines, we can see that the script requires a username and password, which we don't have. It appears that none of `SearchSploit`'s results will be of any use.


Samba 3.0.20
~~~~~~~~~~~~
Moving on to `Samba`:

.. code-block:: none

    kali@kali:~$ searchsploit --color --id samba 3.0.20
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


Our search revealed five possible vulnerabilities. The first two look promising; one appears to be a security bypass, and the other is a command-execution vulnerability. The next two are specifically for ``Samba < 3.0.20``, meaning any version `prior to` our target version. These likely won't work for us. Finally, we've got no interest in the DoS exploit (see :ref:`don't be a dosser`).

Two out of five ain't bad! We'll make a note of the two potential vulnerabilities, and move on.


Debian 9 and Linux Kernel 4.9
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
When seeking vulnerabilities for specific services, you'll often come up empty-handed. Vulnerabilities require analysts to discover them, and hackers to publish exploit code, otherwise they'll never be found in places like `Exploit Database`. If your target is running obscure software, such as a little-known niche web service or custom software developed "in-house," they might be full of vulnerabilities that have yet to be discovered!

When seeking vulnerabilities in a particular `Operating System`, however, we encounter the exact opposite problem. Instead of having too few results to choose from, we wind up with too many.

.. figure:: images/0-google.png
   :width: 600px
   :align: center
   :alt: Google search for Debian 9 exploits: 855,000 results.

   `Google` search for `Debian 9` exploits: 855,000 results.
