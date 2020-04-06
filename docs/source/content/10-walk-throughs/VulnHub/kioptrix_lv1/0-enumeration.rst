.. _Kioptrix Level 1 Enumeration:

Enumeration
===========

.. index::
   single: arp-scan

+-------------+--------------------------+
|**Reference**|:ref:`arp-scan <arp-scan>`|
+-------------+--------------------------+

Before we can start scanning our target for open ports and running services, we must first identify where it is on the network. There are a number of ways to do this, but for the purposes of this tutorial, we'll use the `arp-scan` utility.

Before we run `arp-scan`, we need to know what our IP is, so we know which subnet to scan. For this, we can use the ``ip a`` command:

.. code-block:: none

    kali@kali:~$ ip a
    [...]
    3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
        link/ether 08:00:27:85:c7:a2 brd ff:ff:ff:ff:ff:ff
        inet 10.1.1.100/24 brd 10.1.1.255 scope global dynamic noprefixroute eth1
           valid_lft 502sec preferred_lft 502sec
        inet6 fe80::a00:27ff:fe85:c7a2/64 scope link noprefixroute
           valid_lft forever preferred_lft forever

My system's IP is ``10.1.1.100``. Yours may be different. Be sure to take note of the IP, because you'll need it later!

The command-line we'll use for `arp-scan` is as follows:

.. code-block:: none

    sudo arp-scan -I eth1 -l

Notice that we're using the ``-l`` flag. This will scan the entire local subnet. Also, we need to specify the network interface on which the VMs reside, using the ``-I`` command-line argument. In this example, I'm using ``eth1``, as this is the interface revealed in the previous ``ip a`` command. You'll want to modify your `arp-scan` command to suit the subnet and network interface on which your `Kali` and `Kioptrix` VMs reside.

Here's what the output of the tool looks like:

.. code-block:: none

    kali@kali:~$ sudo arp-scan -I eth1 -l
    Interface: eth1, type: EN10MB, MAC: 08:00:27:85:c7:a2, IPv4: 10.1.1.100
    Starting arp-scan 1.9.7 with 256 hosts (https://github.com/royhills/arp-scan)
    10.1.1.1        0a:00:27:00:00:00       (Unknown: locally administered)
    10.1.1.1        08:00:27:72:bd:42       PCS Systemtechnik GmbH (DUP: 2)
    10.1.1.102      08:00:27:4d:93:21       PCS Systemtechnik GmbH

    3 packets received by filter, 0 packets dropped by kernel
    Ending arp-scan 1.9.7: 256 hosts scanned in 2.113 seconds (121.15 hosts/sec). 3 responded

In this example, we can see that `arp-scan` identified our local IP as ``10.1.1.100``, as seen in the top-right corner of the tool's output. Following this, the tool lists the IPs and MAC addresses of the rest of the systems discovered on the network. The ``10.1.1.1`` IP is managed by `VirtualBox`'s virtual networking subsystem. ``10.1.1.102``, on the other hand, is the IP of `Kioptrix Level 1`, our target for this exercise.
