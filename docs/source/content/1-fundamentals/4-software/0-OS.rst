Virtual Machines and Operating Systems
======================================

.. index::
   single: hacker
   single: penetration test
   single: report

Perhaps the most fundamental choice in designing your hacker toolkit will be which Operating System (OS) to use. Prior to virtualization technology, the choice of OS was crucial, as it limited the range of tools available. Hackers often chose to use Linux, as it supported the largest range of pentesting tools at the lowest up-front cost. However, with the rise of virtual machines (VMs), which allow users to run multiple `guest` OSes inside a `host` OS, hackers were granted the freedom to run whichever host and guest OSes they wanted. In recent years, virtualization has become one of the most prevalent and important technologies, with numerous virtualization options available to users.

.. index::
   single: VMWare
   single: VirtualBox
   single: virtualization
   single: virtual machine

Presently, two of the biggest names in desktop virtualization are `VMWare`_ and `VirtualBox`_, the former a commercial entity, the latter open-source. Both offer free software for running virtual machines.

.. _VMWare: https://www.vmware.com/
.. _VirtualBox: https://www.virtualbox.org/

Hackers use all sorts of OSes with various configurations, often using virtualization to run more specialized systems like :index:`Kali Linux` from within their host OS. These guest OSes are used to conduct attacks, while notes and reports are kept on the host OS. When the job is complete, post-pentest cleanup is as easy as deleting or reverting the VM.

Despite the freedom granted by virtualization, hackers must still make a choice of what guest OSes to use, and for which purposes.

.. note::

    Entire books have been written on the subject of virtualization, and a wide variety of software and hardware platforms exist for the purpose. As such, an in-depth discussion is beyond the scope of this guide. Definitely learn as much as you can; virtualization is one of the most important technologies of our time.


Microsoft Windows
-----------------

While the selection of offensive hacking tools is more limited on Windows systems, there are still plenty of options available, making it a worthy inclusion in a hacker's offensive toolkit. In fact, software distributions like `Flare-VM`_ and `Commando-VM`_ by `FireEye`_ enable hackers to quickly and easily configure their Windows systems for penetration-testing and forensics.

.. _Flare-VM: https://github.com/fireeye/flare-vm
.. _Commando-VM: https://github.com/fireeye/commando-vm
.. _FireEye: https://www.fireeye.com/

Windows VMs aren't just useful for offensive operations, however. Hackers often use Windows VMs for testing attacks and mitigation, or for compiling software to be used on other Windows systems. To this end, Microsoft released a free `Windows 10 Development Environment`_, featuring a full suite of development tools. A selection of other free `Windows Virtual Machines`_ are also available, enabling developers and hackers to test a variety of Windows versions and browsers.

.. _Windows 10 Development Environment: https://developer.microsoft.com/en-us/windows/downloads/virtual-machines
.. _Windows Virtual Machines: https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/


Apple macOS
-----------

Based on the `Berkeley Software Distribution`_ (BSD), Apple's `macOS`_ has gained a large following among hackers and non-hackers alike. It's a popular choice for host OS, thanks to security, stability, speed, and personal preference. However, macOS is not commonly used as a guest VM, largely due to the technical and legal complications involved. This hasn't prevented hackers from using macOS in their pentests, but it has limited the availability of macOS to those willing to `purchase a Mac`_ (or create a "`Hackintosh`_").

.. _Berkeley Software Distribution: https://en.wikipedia.org/wiki/Berkeley_Software_Distribution
.. _macOS: https://www.apple.com/macos/
.. _purchase a Mac: https://www.apple.com/mac/
.. _Hackintosh: https://hackintosh.com/

For hackers looking to use macOS as the foundation of their toolkit, instead of simply using VMs, the most common tools can be installed via `Homebrew`_. Some have turned to `Docker`_ to run tools otherwise unavailable on macOS, but this is just another form of virtualization. (Not that there's anything wrong with that.)

.. _Homebrew: https://brew.sh/
.. _Docker: https://www.docker.com/


Linux
-----

By far the most popular choice for hackers, `Linux`_ has become a main-stay in the Information Security industry. While popular distributions like `Arch`_, `CentOS`_, `Debian`_ and `Fedora`_ serve as a solid foundation for developing a toolkit, many hackers opt for pre-configured pentest-focused distributions like `BlackArch`_, `Kali`_ and `Parrot`_ for use in their VMs.

.. _Linux: https://en.wikipedia.org/wiki/Linux
.. _Arch: https://www.archlinux.org/
.. _CentOS: https://www.centos.org/
.. _Debian: https://www.debian.org/
.. _Fedora: https://getfedora.org/
.. _BlackArch: https://blackarch.org/
.. _Kali: https://www.kali.org/
.. _Parrot: https://parrotlinux.org/

Much like Windows, Linux VMs are also quite useful for testing attacks and mitigation, software development, and other functions. In fact, with the prevalence of Linux systems in corporate and internet-facing environments, the ability to navigate and operate a Linux system is an essential hacker skill.

.. note::

    In the InfoSec world, the `Kali Linux`_ distribution has become the de facto standard. The distribution includes a robust pentesting toolkit, pre-configured for the sake of simplicity. As such, the remainder of this guide will assume the use of :index:`Kali Linux`, unless otherwise stated. That being said, the tools and techniques in the guide are not specific to Kali, and can oft be used with little or no alteration in other Linux distributions.

    Readers unfamiliar with Kali should read `the Kali documentation`_ and/or the free `Kali Linux Revealed`_ ebook. This guide assumes a basic familiarity with Kali.

.. _Kali Linux: https://www.kali.org/
.. _the Kali documentation: https://www.kali.org/docs/
.. _Kali Linux Revealed: https://www.kali.org/download-kali-linux-revealed-book/


And So On...
------------
Many other Operating Systems exist beyond the Big Three. The Berkeley Software Distribution (BSD) has a variety of descendants, such as `FreeBSD`_, `OpenBSD`_ and `NetBSD`_. In some environments, you'll find systems running `Solaris`_ or one of its open-source descendants, such as `illumos`_ and its derivative `OpenIndiana`_. You might even find systems running `FreeDOS`_ or `ReactOS`_, open-source alternatives to MS-DOS and Windows (respectively).

.. _FreeBSD: https://www.freebsd.org/
.. _NetBSD: https://www.netbsd.org/
.. _OpenBSD: https://www.openbsd.org/
.. _Solaris: https://en.wikipedia.org/wiki/Solaris_(operating_system)
.. _illumos: https://www.illumos.org/
.. _OpenIndiana: https://www.openindiana.org/
.. _FreeDOS: https://www.freedos.org/
.. _ReactOS: https://reactos.org/

.. note::

    No matter which OS you prefer to use, you should strive to familiarize yourself with each of the Big Three (Windows, macOS, and Linux), and probably BSD and Solaris as well. You never know what you'll encounter; adaptability is crucial.

    Here are a few resources for learning how to use the various systems' command-line interfaces (since this will often be your first point of contact with a system):

    * Windows: `ComputerHope CMD.EXE Tutorial`_
    * macOS: `Apple Developer Portal Command Line Primer`_
    * Linux: `Linux.com Command Line Basics`_

.. _ComputerHope CMD.EXE Tutorial: https://www.computerhope.com/issues/chusedos.htm
.. _Apple Developer Portal Command Line Primer: https://developer.apple.com/library/archive/documentation/OpenSource/Conceptual/ShellScripting/CommandLInePrimer/CommandLine.html
.. _Linux.com Command Line Basics: https://www.linux.com/tutorials/how-use-linux-command-line-basics-cli/
