.. _Lame Enum:

Enumeration
===========

+-------------+-------------------------------+
|**Reference**|:ref:`enum4linux <enum4linux>` |
|             |                               |
|             |:ref:`nmap <nmap>`             |
|             |                               |
|             |:ref:`smbclient`               |
+-------------+-------------------------------+



Port and Service Scanning
-------------------------

To start things off, let's ping the target to ensure it's online:

.. code-block:: none

    kali@kali:~/HTB/Lame$ ping 10.10.10.3 -c3
    PING 10.10.10.3 (10.10.10.3) 56(84) bytes of data.
    64 bytes from 10.10.10.3: icmp_seq=1 ttl=63 time=59.8 ms
    64 bytes from 10.10.10.3: icmp_seq=2 ttl=63 time=59.6 ms
    64 bytes from 10.10.10.3: icmp_seq=3 ttl=63 time=58.4 ms

    --- 10.10.10.3 ping statistics ---
    3 packets transmitted, 3 received, 0% packet loss, time 2006ms
    rtt min/avg/max/mdev = 58.425/59.254/59.772/0.592 ms

.. index::
   single: nmap

Excellent. Using `nmap`, we'll scan for open ports and see what services are running. This time, let's use the ``-A`` command-line argument to tell `nmap` to run a standard battery of `Nmap Scripting Engine` scripts against the open ports, to see what else we can learn:

.. code-block:: none

    kali@kali:~/HTB/Lame$ sudo nmap -A 10.10.10.3 | tee lame.nmap
    Starting Nmap 7.80 ( https://nmap.org ) at 2020-05-27 14:37 EDT
    Nmap scan report for 10.10.10.3
    Host is up (0.060s latency).
    Not shown: 996 filtered ports
    PORT    STATE SERVICE     VERSION
    21/tcp  open  ftp         vsftpd 2.3.4
    |_ftp-anon: Anonymous FTP login allowed (FTP code 230)
    [...]
    22/tcp  open  ssh         OpenSSH 4.7p1 Debian 8ubuntu1 (protocol 2.0)
    [...]
    139/tcp open  netbios-ssn Samba smbd 3.X - 4.X (workgroup: WORKGROUP)
    445/tcp open  netbios-ssn Samba smbd 3.0.20-Debian (workgroup: WORKGROUP)
    [...]
    Host script results:
    |_clock-skew: mean: 2h01m58s, deviation: 2h49m45s, median: 1m55s
    | smb-os-discovery:
    |   OS: Unix (Samba 3.0.20-Debian)
    |   Computer name: lame
    |   NetBIOS computer name:
    |   Domain name: hackthebox.gr
    |   FQDN: lame.hackthebox.gr
    |_  System time: 2020-05-27T14:40:11-04:00
    [...]
    Nmap done: 1 IP address (1 host up) scanned in 63.09 seconds

We've identified four open ports, with four associated services:

* `vsftpd 2.3.4` on port 21
* `OpenSSH 4.7p1` on port 22
* `Samba smbd 3.0.20` on ports 139 and 445

We've also identified that the system is running `Debian Linux`, that it calls itself `lame`, and that its `Fully Qualified Domain Name` (FQDN) is `lame.hackthebox.gr`. This is a solid start!

.. note::

    Back before the site was located at `hackthebox.eu <https://hackthebox.eu/>`_, `HackTheBox` used to be located at `hackthebox.gr`. The `Lame` target was created back before HTB moved to the new domain, hence the `lame.hackthebox.gr` FQDN.

Let's see what else we can learn about this system from the open ports available.



.. _Lame FTP Enum:

Enumerating FTP
---------------

In the `nmap` results, we were informed that `vsftpd 2.3.4` is configured to allow anonymous login. Let's explore! First, we'll login as ``Anonymous``. Typically, the password doesn't matter, but I like to use ``IEUser@``, since this has been historically used by `Internet Explorer` when it accesses anonymous FTP servers:

.. code-block:: none

    kali@kali:~/HTB/Lame$ ftp 10.10.10.3
    Connected to 10.10.10.3.
    220 (vsFTPd 2.3.4)
    Name (10.10.10.3:kali): Anonymous
    331 Please specify the password.
    Password:
    230 Login successful.
    Remote system type is UNIX.
    Using binary mode to transfer files.
    ftp>

Nice! We've authenticated with the remote FTP server. Let's see what's around:

.. code-block:: none

    ftp> ls -lah
    200 PORT command successful. Consider using PASV.
    150 Here comes the directory listing.
    drwxr-xr-x    2 0        65534        4096 Mar 17  2010 .
    drwxr-xr-x    2 0        65534        4096 Mar 17  2010 ..
    226 Directory send OK.

Unfortunately, the directory is empty. Perhaps this FTP server allows anonymous uploads? Let's try. I'll upload my `nmap` scan results, but any file will do:

.. code-block:: none

    ftp> put lame.nmap
    local: lame.nmap remote: lame.nmap
    200 PORT command successful. Consider using PASV.
    553 Could not create file.

No such luck.



.. _Lame SMB Enum:

Enumerating Samba
-----------------

.. index:: enum4linux

`Samba` is quite often a treasure trove of useful information. However, we'll need to configure our system to communicate with `Lame`, since it's using an older version of `Samba`. To do this, we'll need to modify `Kali`'s `Samba` configuration as seen in the :ref:`Kioptrix Level 1 <Kioptrix Level 1 Samba Enumeration>` walk-through. As the ``root`` user, modify the ``/etc/samba/smb.conf`` file on your `Kali` VM, adding the following lines immediately after the ``[global]`` line:

.. code-block:: none

    client min protocol = CORE
    client max protocol = SMB3

With that complete, we'll begin enumerating `Samba` by using `enum4linux`. This utility has seen better days; quite often the script will spit out tons of errors as it runs, but it still returns some useful information. In order to strip out the errors and clean up the output, I'll use `tee` to pipe the output from the tool into a file called ``lame.enum4linux``:

.. code-block:: none

    kali@kali:~/HTB/Lame$ sudo enum4linux 10.10.10.3 | tee lame.enum4linux
    Starting enum4linux v0.8.9 ( http://labs.portcullis.co.uk/application/enum4linux/ ) on Wed May 27 15:22:48 2020

     ==========================
    |    Target Information    |
     ==========================
    Target ........... 10.10.10.3
    [...]

When the script is complete, we can review the output saved in ``lame.enum4linux`` to see what useful information was collected:

.. code-block:: none

    [...]
    ====================================
    |    OS information on 10.10.10.3    |
     ====================================
    [...]
    [+] Got OS info for 10.10.10.3 from srvinfo:
    	LAME           Wk Sv PrQ Unx NT SNT lame server (Samba 3.0.20-Debian)
    	platform_id     :	500
    	os version      :	4.9
    	server type     :	0x9a03

     ===========================
    |    Users on 10.10.10.3    |
     ===========================
    [...]
    index: 0x6 RID: 0xbba acb: 0x00000010 Account: user	Name: just a user,111,,	Desc: (null)
    index: 0x7 RID: 0x42a acb: 0x00000011 Account: www-data	Name: www-data	Desc: (null)
    index: 0x8 RID: 0x3e8 acb: 0x00000011 Account: root	Name: root	Desc: (null)
    [...]
    =======================================
    |    Share Enumeration on 10.10.10.3    |
     =======================================

    	Sharename       Type      Comment
    	---------       ----      -------
    	print$          Disk      Printer Drivers
    	tmp             Disk      oh noes!
    	opt             Disk
    	IPC$            IPC       IPC Service (lame server (Samba 3.0.20-Debian))
    	ADMIN$          IPC       IPC Service (lame server (Samba 3.0.20-Debian))
    Reconnecting with SMB1 for workgroup listing.

    	Server               Comment
    	---------            -------

    	Workgroup            Master
    	---------            -------
    	WORKGROUP            LAME

    [+] Attempting to map shares on 10.10.10.3
    //10.10.10.3/print$	Mapping: DENIED, Listing: N/A
    //10.10.10.3/tmp	Mapping: OK, Listing: OK
    //10.10.10.3/opt	Mapping: DENIED, Listing: N/A
    //10.10.10.3/IPC$	[E] Can't understand response:
    NT_STATUS_NETWORK_ACCESS_DENIED listing \*
    //10.10.10.3/ADMIN$	Mapping: DENIED, Listing: N/A
    [...]

There's a lot of output! Let's parse through it, from the top.

.. code-block:: none

    [+] Got OS info for 10.10.10.3 from srvinfo:
      LAME           Wk Sv PrQ Unx NT SNT lame server (Samba 3.0.20-Debian)
      platform_id     :	500
      os version      :	4.9
      server type     :	0x9a03

We can see here that the ``os version`` is listed as ``4.9``. It's important to note that this isn't the `Debian` version, but rather the version of the `Linux` kernel installed. Kernel ``4.9`` was the default kernel in `Debian 9`, so this is likely the version of `Debian` installed on the system.

Next, we can see all the users on the system, including the following line:

.. code-block:: none

    index: 0x6 RID: 0xbba acb: 0x00000010 Account: user	Name: just a user,111,,	Desc: (null)

The target has a single non-root, non-service account called ``user``.

We can also see what shares are available on the device:

.. code-block:: none

    Sharename       Type      Comment
    ---------       ----      -------
    print$          Disk      Printer Drivers
    tmp             Disk      oh noes!
    opt             Disk
    IPC$            IPC       IPC Service (lame server (Samba 3.0.20-Debian))
    ADMIN$          IPC       IPC Service (lame server (Samba 3.0.20-Debian))
    Reconnecting with SMB1 for workgroup listing.

The ``tmp`` share looks interesting, as does ``opt``. In the next section, we can see which shares are available to anonymous users:

.. code-block:: none

    //10.10.10.3/tmp	Mapping: OK, Listing: OK
    //10.10.10.3/opt	Mapping: DENIED, Listing: N/A

.. index:: smbclient

Looks like we won't be able to access the ``opt`` share, but the ``tmp`` share is available. We can use `smbclient` to explore its contents, authenticating via a `null session`:

.. code-block:: none

    kali@kali:~/HTB/Lame$ smbclient -U '' -N //10.10.10.3/tmp/
    Try "help" to get a list of possible commands.
    smb: \> ls
      .                                   D        0  Wed May 27 15:37:54 2020
      ..                                 DR        0  Sun May 20 14:36:12 2012
      5143.jsvc_up                        R        0  Wed May 27 14:35:05 2020
      .ICE-unix                          DH        0  Wed May 27 14:33:56 2020
      .X11-unix                          DH        0  Wed May 27 14:34:21 2020
      .X0-lock                           HR       11  Wed May 27 14:34:21 2020

                    7282168 blocks of size 1024. 5678792 blocks available

Interesting... Let's see if we can download that ``5143.jsvc_up`` file:

.. code-block:: none

    smb: \> get 5143.jsvc_up
    NT_STATUS_ACCESS_DENIED opening remote file \5143.jsvc_up

No such luck. Can we upload files? Let's try:

.. code-block:: none

    smb: \> put lame.nmap
    putting file lame.nmap as \lame.nmap (12.7 kb/s) (average 12.7 kb/s)
    smb: \> ls
      .                                   D        0  Wed May 27 16:33:42 2020
      ..                                 DR        0  Sun May 20 14:36:12 2012
      5143.jsvc_up                        R        0  Wed May 27 14:35:05 2020
      lame.nmap                           A     2496  Wed May 27 16:33:42 2020
      .ICE-unix                          DH        0  Wed May 27 14:33:56 2020
      .X11-unix                          DH        0  Wed May 27 14:34:21 2020
      .X0-lock                           HR       11  Wed May 27 14:34:21 2020

                    7282168 blocks of size 1024. 5678788 blocks available

Success! We were able to upload ``lame.nmap`` to the server. This service can be used as a point of ingress for files we need to get onto the system. Can we download the file we just uploaded?

.. code-block:: none

    smb: \> get lame.nmap
    getting file \lame.nmap of size 2496 as lame.nmap (9.7 KiloBytes/sec) (average 9.8 KiloBytes/sec)

Nice! It looks like we can both upload and download files on this service. This could prove useful in the future. I don't want to leave that file there, however. It's always a good idea to :ref:`cover your tracks`, so I'll use the ``rm`` command to remove the file:

.. code-block:: none

    smb: \> rm lame.nmap
    smb: \> ls
      .                                   D        0  Wed May 27 17:07:59 2020
      ..                                 DR        0  Sun May 20 14:36:12 2012
      5143.jsvc_up                        R        0  Wed May 27 14:35:05 2020
      .ICE-unix                          DH        0  Wed May 27 14:33:56 2020
      .X11-unix                          DH        0  Wed May 27 14:34:21 2020
      .X0-lock                           HR       11  Wed May 27 14:34:21 2020

                    7282168 blocks of size 1024. 5678792 blocks available

Nice.



Enumeration Wrap-Up
-------------------
We now have a pretty good view of what's happening on this system. We've identified the following software running on the target:

* `Debian 9`
* `Linux Kernel 4.9`
* `vsftpd 2.3.4`
* `OpenSSH 4.7p1`
* `Samba 3.0.20`

We've discovered that an account called ``user`` exists on the host, and that there's an open `Samba` share called ``tmp``, where we can upload and retrieve files. We also know that this service calls itself ``lame.hackthebox.gr``, which could be important to know as well.

With this information in-hand, let's see what kinds of vulnerabilities we can find.
