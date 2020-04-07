.. _enum4linux:

enum4linux: SMB & Samba Enumeration
===================================

.. index:: !enum4linux

+-----------+----------------------------------------------+
|**OS**     | Linux                                        |
+-----------+----------------------------------------------+
|**Website**| https://github.com/portcullislabs/enum4linux |
+-----------+----------------------------------------------+

+---------+------------------------------------------------------+
|                  **Reference  Walk-Throughs**                  |
+=========+======================================================+
|`VulnHub`|:ref:`Kioptrix Level 1 <Kioptrix Level 1 Enumeration>`|
+---------+------------------------------------------------------+



What is enum4linux?
-------------------
The `enum4linux` tool allows you to enumerate information from `Windows` and `Samba` systems. Written in `Perl`, it is basically a wrapper around a number of other utilities, providing a unified, simplified script capable of collecting a significant amount of information.


How does it work?
-----------------
This utility relies heavily on `null sessions`, which are anonymous connections to inter-process communication services on the target system. Using `null sessions`, as well as a few other techniques, the `enum4linux` utility can extract information including (but not limited to) hardware information, OS information, usernames, password policies, open ports, and shared printers and filesystems.


Using enum4linux
----------------

.. note::

    To run most effectively, `enum4linux` requires root privileges, so it's best to run this tool via `sudo` or as the ``root`` user.

To use `enum4linux`, simply type ``sudo enum4linux`` in the command line, followed by the necessary command-line arguments. At a minimum, `enum4linux` expects to be given the IP address of the system you intend to scan.

By default, if no additional command-line arguments are supplied, `enum4linux` assumes the ``-a`` flag, which automatically runs a robust set of enumeration techniques.
