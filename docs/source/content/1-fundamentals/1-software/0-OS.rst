Virtual Machines and Operating Systems
======================================

.. index::
   single: hacker
   single: penetration test
   single: Kali Linux
   single: report

Perhaps the most fundamental choice in designing your hacker toolkit will be which Operating System (OS) to use. Prior to virtualization technology, the choice of OS was crucial, as it limited the range of tools available. Hackers often chose to use Linux, as it supported the largest range of pentesting tools at the lowest up-front cost. However, with the rise of virtual machines (VMs), which allow users to run multiple `guest` OSes inside a `host` OS, hackers were granted the freedom to run whichever host and guest OSes they wanted. In recent years, virtualization has become one of the most prevalent and important technologies, with numerous virtualization options available to users.

Presently, the two most widely-used virtualization technologies are `VMWare`_ and `VirtualBox`_, the former being a commercial product, and the latter being an open-source project.

.. _VMWare: https://www.vmware.com/
.. _VirtualBox: https://www.virtualbox.org/

These days hackers use all sorts of OSes with various configurations, often using virtualization to run more specialized systems like Kali Linux from within their host OS. Pentesters will often use disposable, virtualized guest OSes to conduct the actual penetration test, while using their preferred host OS for keeping records and writing pentest reports. When a pentest is complete, the hacker can delete or revert the guest OS, without impacting the host OS, making post-pentest clean-up quick and easy.

Despite the freedom granted by virtualization, hackers must still make a choice of what guest OSes to use, and for which purposes.


Microsoft Windows
-----------------

While the selection of offensive hacking tools is more limited on Windows systems, there are still plenty of options available, making it a worthy inclusion in a hacker's offensive toolkit. In fact, software distributions like `Flare-VM`_ and `Commando-VM`_ by `FireEye`_ enable hackers to quickly and easily configure their Windows systems for penetration-testing and forensics.

.. _Flare-VM: https://github.com/fireeye/flare-vm
.. _Commando-VM: https://github.com/fireeye/commando-vm
.. _FireEye: https://www.fireeye.com/

Windows VMs aren't just useful for offensive operations, however. Hackers often use Windows VMs for testing attacks and mitigations, or for compiling software to be used on other Windows systems. In fact, Microsoft has made pre-configured VM images available for free, enabling hackers and programmers to work with Windows without having to pay for a full license. A `Windows 10 Development Environment`_ was released, including pre-installed tools for software development and deployment. In addition, a selection of other `Windows Virtual Machines`_ were also released, for developers and hackers seeking to test on a variety of other Windows versions and browsers.

.. _Windows 10 Development Environment: https://developer.microsoft.com/en-us/windows/downloads/virtual-machines
.. _Windows Virtual Machines: https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/


Apple OS X
----------

Based on the Berkeley Systems Distribution (BSD), Apple's OS X has gained a large following among hackers and non-hackers alike. It's a popular choice for host OS, thanks to stability, speed, and personal preference. However, OS X is not commonly used as a guest VM, largely due to the technical and legal complications involved.

This hasn't prevented hackers from using OS X in their pentests, but it has limited the availability of OS X to those willing to purchase a Mac (or pirate the OS).


Linux
-----

By far the most popular choice for hackers, Linux has become a main-stay in the Information Security industry. While popular distributions like `Arch`_, `CentOS`_, `Debian`_ and `Fedora`_ serve as a solid foundation for developing a toolkit, many hackers opt for pre-configured pentest-focused distributions like `BlackArch`_, `Kali`_ and `Parrot`_ for use in their VMs.

.. _Arch: https://www.archlinux.org/
.. _CentOS: https://www.centos.org/
.. _Debian: https://www.debian.org/
.. _Fedora: https://getfedora.org/
.. _BlackArch: https://blackarch.org/
.. _Kali: https://www.kali.org/
.. _Parrot: https://parrotlinux.org/

Much like Windows, Linux VMs are also quite useful for testing attacks and mitigations, software development, and other functions. In fact, with the prevalence of Linux systems in corporate and internet-facing environments, the ability to navigate and operate a Linux system is an essential skill for hackers and information security professionals.

.. note::

    In the InfoSec world, the `Kali Linux`_ distribution has become the defacto standard. The distribution includes a robust pentesting toolkit, pre-configured for the sake of simplicity. As such, the remainder of this guide will assume the use of Kali Linux, unless otherwise stated. That being said, the tools and techniques in the guide are not specific to Kali, and can be used with little or no alteration in other Linux distributions.

.. _Kali Linux: https://www.kali.org/
