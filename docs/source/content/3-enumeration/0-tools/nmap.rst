.. _nmap:

`nmap`: the Network Mapper
==========================

+------+---+
|**OS**|All|
+------+---+


What is `nmap`?
---------------
The `nmap` utility is one of the oldest and most-used tools in the hacker's arsenal. As the name implies, it allows you to map networks, identifying not only what machines exist on a network, but also which ports are open on those machines. It also includes a great deal of additional functionality, such as identifying the software and operating systems running on target systems. It also has the ability to run scripts to identify vulnerabilities or reveal additional information about targets. In fact, entire books have been written about `nmap`, exploring its various capabilities and functionality.


How does it work?
-----------------
By sending carefully-crafted packets to a system, `nmap` can listen to the system's replies in order to determine additional information about that system. For example, using the `TCP three-way handshake`_, `nmap` can check to see whether a TCP port is open on a target system.

.. _TCP three-way handshake: https://en.wikipedia.org/wiki/Handshaking#TCP_three-way_handshake


Using `nmap`
------------
To use `nmap`, simply type ``nmap`` in a command prompt, followed by the necessary command-line arguments. Examples:

.. code-block:: none

    nmap scanme.nmap.org
    nmap -v -sn 192.168.0.0/16 10.0.0.0/8
    nmap -Pn 10.10.10.4

At a minimum, `nmap` expects one or more IP addresses to be provided. Multiple addresses can be expressed via wildcards (i.e. ``10.10.10.*``), hyphenated ranges (i.e. ``10.10.10.100-150``), and even via CIDR notation (i.e. ``10.10.10.0/24``).


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
