.. _nmap:

`nmap`: the Network Mapper
==========================

.. index:: !nmap

+-----------+-----------------------------+
|**OS**     |All major operating systems. |
+-----------+-----------------------------+
|**Website**|https://nmap.org/            |
+-----------+-----------------------------+

+------------+--------------------------------------------------------+
|                     **Reference  Walk-Throughs**                    |
+============+========================================================+
|`HackTheBox`|:ref:`HTB Legacy <Legacy Enumeration>`                  |
+------------+--------------------------------------------------------+
|`VulnHub`   |:ref:`Kioptrix Level 1 <Kioptrix Level 1 Port Scanning>`|
+------------+--------------------------------------------------------+



What is `nmap`?
---------------
The `nmap` utility is one of the oldest and most-used tools in the hacker's arsenal. As the name implies, it allows you to map networks, identifying not only what machines exist on a network, but also which ports are open on those machines. It also includes a great deal of additional functionality, such as identifying the software and operating systems running on target systems. It also has the ability to run scripts to identify vulnerabilities or reveal additional information about targets. In fact, entire books have been written about `nmap`, exploring its various capabilities and functionality.


How does it work?
-----------------
By sending carefully-crafted packets to a system, `nmap` can listen to the system's replies in order to determine additional information about that system. For example, using the `TCP three-way handshake`_, `nmap` can check to see whether a TCP port is open on a target system.

.. _TCP three-way handshake: https://en.wikipedia.org/wiki/Handshaking#TCP_three-way_handshake


Using `nmap`
------------
To use `nmap`, simply type ``nmap`` in the command-line, followed by the necessary arguments. Examples:

.. code-block:: none

    nmap scanme.nmap.org
    nmap -v -sn 192.168.0.0/16 10.0.0.0/8
    nmap -Pn 10.10.10.4

At a minimum, `nmap` expects one or more IP addresses to be provided. Multiple addresses can be expressed via wildcards (i.e. ``10.10.10.*``), hyphenated ranges (i.e. ``10.10.10.100-150``), and even via CIDR notation (i.e. ``10.10.10.0/24``).

By default, when run as an unprivileged (non-root) user, `nmap` uses a TCP Connect scan (``-sT``). When running as root, `nmap` uses a TCP SYN scan (``-sS``) by default. For more information on these scan types, see below.

To learn the various command-line arguments available in `nmap`, simply run ``nmap`` with no arguments. On unix-like systems, you can type ``man nmap`` to read the documentation of the tool.

The following are the most commonly-used command-line arguments and their descriptions:


``-sn``: Ping Scan (Disable Port Scan)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
**Example:** ``nmap -sn 10.10.10.0/24``

This scan uses `ICMP`_ packets to test whether the specified target(s) are reachable on the network. Some systems may not respond to ICMP pings, despite being online. This is often true in the case of Windows systems.

.. _ICMP: https://en.wikipedia.org/wiki/Internet_Control_Message_Protocol


``-Pn``: Skip Ping Scan
~~~~~~~~~~~~~~~~~~~~~~~
**Example:** ``nmap -Pn 10.10.10.0/24``

By default, `nmap` attempts to ping the specified target(s) before conducting a port scan, so as to avoid wasting time trying to scan nonexistent targets. However, if a host is online but not responding to ICMP pings, using the ``-Pn`` command-line argument will instruct `nmap` to skip the ping and conduct the port-scan with the assumption that the targets are online.


``-p[PORTS]``: Specify Ports to Scan
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
**Example:** ``nmap -p139 10.10.10.4``

The ``-p`` command-line modifier specifies the port(s) for `nmap` to scan. Ports can be specified in a number of ways:

* A single port (e.g. ``-p23`` to scan port 23)
* Multiple specific ports (e.g. ``-p23,25`` to scan ports 23 and 25)
* A range of ports (e.g. ``-p22-25`` to scan ports 22, 23, 24 and 25)
* A combination of the above (e.g. ``-p22,25-30`` to scan port 22 and ports 25 through 30)

If you wish to scan all ports on a host, you can use the ``-p-`` command-line modifier (e.g. ``nmap -p- 10.10.10.4``).


``-sT``: TCP Connect Scan
~~~~~~~~~~~~~~~~~~~~~~~~~
**Example:** ``nmap -sT 10.10.10.4``

This command-line argument tells `nmap` to conduct a TCP Connect scan, which attempts to establish a full TCP connection for each port by completing the TCP three-way handshake. This is the default scan method used by `nmap` when run as an unprivileged (non-root) user.


``-sS``: TCP SYN Scan
~~~~~~~~~~~~~~~~~~~~~
**Example:** ``nmap -sS 10.10.10.4``

This command-line argument tells `nmap` to conduct a `TCP SYN scan`_, which attempts to identify open ports without completing the full TCP three-way handshake. This method requires root privileges, and is the default scan method when `nmap` is run as a root-level user.

.. _TCP SYN scan: https://nmap.org/book/synscan.html


``-sV``: Software Version Detection
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
**Example:** ``nmap -sV 10.10.10.4``

This command-line argument tells `nmap` to attempt to identify the specific software running on each port, as well as the software's version. While some software might return vague information (or no information at all), most software provides this information readily. This information can be used to identify vulnerable services on the target.


``-O``: Operating System Detection
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
**Example:** ``nmap -O 10.10.10.4``

This command-line argument tells `nmap` to attempt to identify the target's Operating System information, including which version is installed. To do this, `nmap` analyses the open ports, as well as whatever other information it can gather from the target. While precise OS detection can be challenging, `nmap` is usually able to narrow down the options significantly.


``--script [SCRIPT(S)]``: Nmap Scripting Engine (NSE)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
**Example:** ``nmap -p139,445 --script smb-vuln-ms08-067 10.10.10.4``

This command-line argument tells `nmap` to execute a script against the specified target. On `Kali Linux`, scripts are located in the ``/usr/share/nmap/scripts/`` directory. By specifying ports with ``-p``, you can tell `nmap` to run the script against those specific ports. For a good example of NSE usage, check out the :ref:`Legacy <Legacy Vulnerability Scanning>` walkthrough. For more information about scripts, check out `nmap`'s `official documentation`_.

.. _official documentation: https://nmap.org/book/nse-usage.html
