.. _Python File Transfers:

Transferring Files with Python
==============================

+---------+--------------------------------------------------------+
|                   **Reference  Walk-Throughs**                   |
+=========+========================================================+
|`VulnHub`|:ref:`Kioptrix Level 1 <Koptrix Lv1 Python HTTP Server>`|
+---------+--------------------------------------------------------+


Most modern `Linux` distributions are shipped with `Python 2` and/or `Python 3` pre-installed. The following methods can be used to easily send files from a sender to a recipient system using `Python`.


Hosting an Ad-Hoc HTTP Server
-----------------------------
One simple method for sharing a file across the network is by creating an ad-hoc HTTP server on the sender system, then downloading shared files to the recipient system using any number of HTTP clients, such as `wget` or `curl`.

.. note::

    If you intend to host an HTTP server on port 80, as per common usage, you'll need to run the following commands with root- or admin-level permissions. It is therefore advised, on Unix-like systems, to use the `sudo` utility to run these commands as ``root``.

To host an ad-hoc HTTP server with `Python 3`, use the following command:

.. code-block:: none

    python3 -m http.server 80

With `Python 2`, use the following command instead:

.. code-block:: none

    python -m SimpleHTTPServer 80

In either case, to stop the HTTP server, you can hit **Ctrl-C**.
