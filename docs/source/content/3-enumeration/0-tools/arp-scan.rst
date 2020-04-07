.. _arp-scan:

`arp-scan`: The ARP Scanner
===========================

.. index:: !arp-scan

+-----------+--------------------------------------+
|**OS**     | Linux / MacOS / BSD / Solaris        |
+-----------+--------------------------------------+
|**Website**| https://github.com/royhills/arp-scan |
+-----------+--------------------------------------+

+---------+------------------------------------------------------+
|                  **Reference  Walk-Throughs**                  |
+=========+======================================================+
|`VulnHub`|:ref:`Kioptrix Level 1 <Kioptrix Level 1 Enumeration>`|
+---------+------------------------------------------------------+



What is `arp-scan`?
-------------------
The `arp-scan` utility scans networks to determine which IPs have been associated with which MAC addresses. It can be used to enumerate live systems on a network, and is even able to reveal systems that don't respond to ICMP Ping requests.


How does it work?
-----------------
The `arp-scan` utility sends ARP request packets for each of the specified IPs on the local network. By default, these ARP packets are sent to the Ethernet broadcast address (``ff:ff:ff:ff:ff:ff``), which relays the ARP request to all of the systems on the network. Live systems will reply with their IP address, allowing `arp-scan` to identify which IPs belong to which MAC addresses.

This utility will reveal systems even if they don't respond to an ICMP Ping request, because ARP is a fundamental network protocol used by all systems to enable communication with other devices. If a system did not reply to ARP requests, it would not be able to interact with other devices on the network.


Using `arp-scan`
----------------

.. note::

    The `arp-scan` utility requires root privileges to run, and should therefore be run with `sudo` or as the ``root`` user.

To use `arp-scan`, simply type ``sudo arp-scan`` in the command line, followed by the necessary command-line arguments. Examples:

.. code-block:: none

    sudo arp-scan 10.1.1.0/24
    sudo arp-scan -I eth1 10.1.1.0/24
    sudo arp-scan 10.1.1.100-10.1.1.150
    sudo arp-scan -I eth1 -f target-ips.txt

At a minimum, `arp-scan` expects an IP or range of IPs to be specified. Multiple IPs can be specified either using CIDR notation or a hyphenated range, as demonstrated above.

The `arp-scan` utility is quite versatile, and includes many command-line options. The most commonly-used options are detailed below. For more information, review the `arp-scan` manual pages by running ``man arp-scan`` in the command-line.


``--localnet`` or ``-l``: Scan the Local Subnet
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
**Example:** ``sudo arp-scan -l``

Scan all addresses on the local subnet based on the network interface configuration. Using this flag, `arp-scan` will determine the local system's IP address from the network interface, then will scan the remainder of the subnet. For example, if the local IP is ``10.1.1.100``, then `arp-scan` will scan the entire ``10.1.1.0/24`` subnet.


``--file`` or ``-f``: Read Target IPs from a File
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
**Example:** ``sudo arp-scan -f target-ips.txt``

This flag tells `arp-scan` to scan the IP addresses contained in the specified file. The file must be a basic text file, with one IP address per line, like so:

.. code-block:: none

    10.1.1.100
    10.1.1.101
    10.1.1.102


``--interface`` or ``-I``: Specify Network Interface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
**Example:** ``sudo arp-scan -I eth1 -l``

By default, `arp-scan` uses the first network interface it finds that isn't the loopback interface. (On `Linux` systems, this is often `eth0`.) To scan on a different interface, use the ``-I`` flag, followed by the name of the interface (such as ``eth1``).
