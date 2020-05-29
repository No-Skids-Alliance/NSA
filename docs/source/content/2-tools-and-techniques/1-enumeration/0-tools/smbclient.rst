.. _smbclient:

smbclient: FTP-Like Client for SMB & Samba
==========================================

.. index:: !smbclient

+-----------+------------------------------------------------------------------------------------------------+
|**OS**     | Linux / MacOS / BSD / Solaris                                                                  |
+-----------+------------------------------------------------------------------------------------------------+
|**Website**| `https://www.samba.org/ <https://www.samba.org/samba/docs/current/man-html/smbclient.1.html>`_ |
+-----------+------------------------------------------------------------------------------------------------+

+---------+------------------------------------------------------+
|                  **Reference  Walk-Throughs**                  |
+=========+======================================================+
|`VulnHub`|:ref:`Lame <Lame SMB Enum>`                           |
+---------+------------------------------------------------------+



What is smbclient?
------------------
The `smbclient` utility, shipped with `Samba`, provides an FTP-like client to access SMB or `Samba` shares on servers. It can be used to explore a system's shared files, as well as to upload and download files to a share.


How does it work?
-----------------
By communicating with remote SMB-compatible systems, `smbclient` can interact with shared directories and files in the same manner as FTP. It also features additional functionality, such as the ability to list all the shares available on a host. It can use `null sessions` to communicate, but can also utilize any authentication credentials you may have, including `Kerberos` credentials.


Using smbclient
---------------
To use `smbclient`, just type ``smbclient`` in a terminal, along with the appropriate command-line arguments. Examples:

.. code-block:: none

    smbclient --help
    smbclient -U '' -N -L //10.10.10.3/
    smbclient -U '' -N //10.10.10.3/tmp/

At a minimum, `smbclient` expects to be provided with the service IP, and possibly even a share path.


``-U``: Specify the Username
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
**Example:** ``smbclient -U '' //10.10.10.3/tmp/``

The ``-U`` flag allows you to specify a username for authentication with the SMB share. If the username is not specified, `smbclient` will use the same username as the currently-active user. To establish a `null session`, use a blank username, as seen in the example above.


``-N``: Use Null Password
~~~~~~~~~~~~~~~~~~~~~~~~~
**Example:** ``smbclient -U '' -N //10.10.10.3/tmp/``

When authenticating, `smbclient` will ask you for a password. By using the ``-N`` flag, you tell `smbclient` to use a `Null` (empty) password. This is commonly used for `null session` access.


``-L``: List Available Shares
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
**Example:** ``smbclient -U '' -L //10.10.10.3/``

By supplying the ``-L`` command-line argument, you tell `smbclient` to list the shares available on the specified IP. (When using this flag, you need only provide the IP.) Example:

.. code-block:: none

    kali@kali:~/HTB/Lame$ smbclient -U '' -N -L //10.10.10.3/

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

In this example, we can see that there are two custom shares: ``tmp`` and ``opt``.


Post-Login Commands
~~~~~~~~~~~~~~~~~~~
After authenticating with `smbclient` and accessing a share, you'll be provided with a command prompt which looks like this:

.. code-block:: none

    kali@kali:~/HTB/Lame$ smbclient -U '' -N //10.10.10.3/tmp/
    Try "help" to get a list of possible commands.
    smb: \>

This is an interactive command prompt, similar to that of the basic FTP command-line interface. The following are some commonly-used commands:

* ``get``: Retrieve a file from the system.
* ``put``: Upload a file to the system.
* ``rm``: Delete a file on the system.
* ``ls``: List the contents of the current directory.
* ``help``: Learn more commands, and how they work.
* ``exit``: Disconnect and quit `smbclient`.
