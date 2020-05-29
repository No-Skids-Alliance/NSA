.. _Kioptrix Lv1 Vuln Assess:

Vulnerability Assessment
========================

.. index::
   single: SearchSploit

+-------------+-------------------+
|**Reference**|:ref:`SearchSploit`|
+-------------+-------------------+

Now that we've enumerated the OS and services on the target, it's time to see if we can find any vulnerabilities that exist in those services. For this, we'll use `SearchSploit`, working through the list of our identified software to reveal as many potential exploits as we can find. We'll work from the previously-established list, starting from the top to the bottom, so that we don't miss anything.

By default, `SearchSploit` matches complete search parameters, so we'll start by specifying the full version number, then broaden the search as necessary to find better matches.

First up, there's `Apache` version 1.3.20:

.. code-block:: none

    kali@kali:~$ searchsploit --id apache 1.3.20
    -------------------------------------------------------------------------- ---------
     Exploit Title                                                            |  EDB-ID
    -------------------------------------------------------------------------- ---------
    Apache 1.3.20 (Win32) - 'PHP.exe' Remote File Disclosure                  | 21204
    Apache 1.3.6/1.3.9/1.3.11/1.3.12/1.3.20 - Root Directory Access           | 19975
    -------------------------------------------------------------------------- ---------
    Shellcodes: No Result

The first result in the list won't be useful to us, as it obviously only works on `Windows` machines. We can examine the second result with the ``-x`` flag followed by the `EDB-ID` of the exploit:

.. code-block:: none

    kali@kali:~$ searchsploit -x 19975
      Exploit: Apache 1.3.6/1.3.9/1.3.11/1.3.12/1.3.20 - Root Directory Access
          URL: https://www.exploit-db.com/exploits/19975
         Path: /usr/share/exploitdb/exploits/windows/remote/19975.pl
    File Type: ASCII text, with very long lines, with CRLF line terminators

When we use the ``-x`` flag like this, `SearchSploit` opens the exploit in the `less` utility, allowing us to browse through its source. Reading through the description of the exploit, we discover that it, too, only works on `Windows` machines. We'll hit the ``q`` button on the keyboard to exit the `less` utility, after which point we can see the additional information provided by `SearchSploit`, which reveals that the file is located in the ``windows`` exploit directory on-disk, further proof that this exploit is designed for `Windows`. Let's broaden our search a little, searching for ``apache 1.3``:

.. code-block:: none

    kali@kali:~$ searchsploit --id apache 1.3
    -------------------------------------------------------------------------- ---------
     Exploit Title                                                            |  EDB-ID
    -------------------------------------------------------------------------- ---------
    Apache 1.0/1.2/1.3 - Server Address Disclosure                            | 21067
    Apache 1.2.5/1.3.1 / UnityMail 2.0 - MIME Header Denial of Service        | 20272
    Apache 1.3 + PHP 3 - File Disclosure                                      | 20466
    [...]
    Apache Win32 1.3.x/2.0.x - Batch File Remote Command Execution            | 21350
    NCSA 1.3/1.4.x/1.5 / Apache HTTPd 0.8.11/0.8.14 - ScriptAlias Source Retr | 20595
    htpasswd Apache 1.3.31 - Local Overflow                                   | 466
    -------------------------------------------------------------------------- ---------
    Shellcodes: No Result

Looking through the list of results, once again nothing really stands out. There's a Remote Code Execution (RCE) exploit in the list, but it's for `mod_mylo`, which we didn't see was installed on the target.

Time to move on to the next service on the host. This time we'll be looking at `mod_ssl` version 2.8.4. Searching for the specific version provides no results, so we remove the last digit and search again:

.. code-block:: none

    kali@kali:~$ searchsploit --id mod_ssl 2.8
    -------------------------------------------------------------------------- ---------
     Exploit Title                                                            |  EDB-ID
    -------------------------------------------------------------------------- ---------
    Apache mod_ssl 2.8.x - Off-by-One HTAccess Buffer Overflow                | 21575
    Apache mod_ssl < 2.8.7 OpenSSL - 'OpenFuck.c' Remote Buffer Overflow      | 21671
    Apache mod_ssl < 2.8.7 OpenSSL - 'OpenFuckV2.c' Remote Buffer Overflow (1 | 764
    Apache mod_ssl < 2.8.7 OpenSSL - 'OpenFuckV2.c' Remote Buffer Overflow (2 | 47080
    -------------------------------------------------------------------------- ---------
    Shellcodes: No Result

Aha! It appears that `mod_ssl` versions prior to 2.8.7 (which includes 2.8.4) are vulnerable to a Remote Buffer Overflow attack, with associated exploits called ``OpenFuck.c`` and ``OpenFuckV2.c``. We'll make a note of their `EDB-ID` numbers and move on.

Our next target for investigation is `OpenSSL` version 0.9.6b. The full version number returns no results, and removing the ``.6b`` gives us nothing really worthwhile. Lots of Denial of Service (DoS) vulnerabilities, but we're not trying to crash the system, we're trying to gain access, privileges, or information.

Moving on, we'll now look at `Samba` version 2.2.1a. The full version number doesn't provide us with any results, but removing the ``.1a`` gives us a bounty:

.. code-block:: none

    kali@kali:~$ searchsploit --id samba 2.2
    -------------------------------------------------------------------------- ---------
     Exploit Title                                                            |  EDB-ID
    -------------------------------------------------------------------------- ---------
    Samba 2.0.x/2.2 - Arbitrary File Creation                                 | 20968
    Samba 2.2.0 < 2.2.8 (OSX) - trans2open Overflow (Metasploit)              | 9924
    Samba 2.2.2 < 2.2.6 - 'nttrans' Remote Buffer Overflow (Metasploit) (1)   | 16321
    [...]
    Samba 2.2.x - CIFS/9000 Server A.01.x Packet Assembling Buffer Overflow   | 22356
    Samba 2.2.x - Remote Buffer Overflow                                      | 7
    Samba < 2.2.8 (Linux/BSD) - Remote Code Execution                         | 10
    -------------------------------------------------------------------------- ---------
    Shellcodes: No Result

There appear to be a number of Remote Buffer Overflow and RCE exploits available for this version of `Samba`, including some with `Metasploit` modules. However, the last result, regarding the RCE exploit for `Linux` and `BSD`, looks appetizing, and doesn't depend upon `Metasploit`. Let's give that a shot, and if it doesn't work, we can come back to the list and try something else.

Our final target is `OpenSSH` version 2.9p2. Searching for the full version number provides no results. Removing the ``p2`` from the end doesn't help, so finally we search for version ``2.``. This time, there are a number of results, but there's only one RCE, and it's for `FreeBSD`. It seems we've hit a dead-end.

Having finished our `SearchSploit` investigation, we've discovered two potential targets for exploitation:

* `Apache`'s `mod_ssl`, via the `OpenFuck` exploits, and
* `Samba`, via the `Linux/BSD` RCE exploit.

In the next section, we'll put these exploits to the test.
