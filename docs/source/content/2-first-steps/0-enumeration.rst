Enumeration
===========

+-------------+------------------+
|**Reference**|:ref:`nmap <nmap>`|
+-------------+------------------+

After connecting to the HackTheBox VPN and initializing the `Legacy` VM, we can begin enumerating the target. We'll start by using `nmap` to ping the system, to see if it's online:

.. code-block:: none

    kali@kali:~$ nmap -sn 10.10.10.4
    Starting Nmap 7.80 ( https://nmap.org ) at 2020-03-14 13:27 EDT
    Note: Host seems down. If it is really up, but blocking our ping probes, try -Pn
    Nmap done: 1 IP address (0 hosts up) scanned in 3.07 seconds

Some systems will not respond to pings despite being online. This is often true for Windows systems, such as our current target. This is why `nmap` reported that the host seems to be offline. Fortunately for us, we know that `Legacy` is online and listening, because the HackTheBox dashboard tells us so:

.. figure:: images/0-legacy-online.png
   :width: 400 px
   :align: center
   :alt: Screenshot of HackTheBox, showing that `Legacy` is online.

Next, we'll identify open ports on the target, as well as what software might be listening on each of those ports. Since we know the target isn't responding to ICMP pings, we'll use the ``-Pn`` command-line argument to tell `nmap` to scan without pinging first:

.. code-block:: none

    kali@kali:~$ nmap -Pn 10.10.10.4
    Starting Nmap 7.80 ( https://nmap.org ) at 2020-03-14 12:52 EDT
    Nmap scan report for 10.10.10.4
    Host is up (0.056s latency).
    Not shown: 997 filtered ports
    PORT     STATE  SERVICE
    139/tcp  open   netbios-ssn
    445/tcp  open   microsoft-ds
    3389/tcp closed ms-wbt-server

    Nmap done: 1 IP address (1 host up) scanned in 7.83 seconds
