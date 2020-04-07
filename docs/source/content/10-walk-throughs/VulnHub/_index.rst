VulnHub
=======
`VulnHub`_ is a website offering a wide variety of "Boot2Root" vulnerable virtual machines available for visitors to download free-of-charge. It predates `HackTheBox` by over a decade, with its first VM, `BadStore: 1.2.3`, having been posted in 2004.

.. _VulnHub: https://www.vulnhub.com/

Most of the VMs on `VulnHub` are designed to be compatible with either `VMWare` or `VirtualBox`. If you'd like to follow along on your own system, you'll need one of the two installed.

Also, it is advised to use `Host-Only Networking` to communicate between your `Kali` VM and the various `VulnHub` targets. This allows you to interact with the target as if they're on a local network, while keeping them segregated from the Internet as a whole.

.. toctree::
   :caption: VulnHub Targets

   kioptrix_lv1/_index.rst
