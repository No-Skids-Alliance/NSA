Capturing Flags
===============
Now that we've got access to our target system, let's open a command prompt and see if we can find any juicy information. We'll do this by typing the ``shell`` command, which provides us access to the familiar `Windows` command-line:

.. code-block:: none

    meterpreter > shell
    Process 404 created.
    Channel 1 created.
    Microsoft Windows XP [Version 5.1.2600]
    (C) Copyright 1985-2001 Microsoft Corp.

    C:\WINDOWS\system32>

.. index::
   single: Capture the Flag

In most CTF competitions, you'll be hunting for "flags," which are typically short strings contained in text files which are intended to prove that you've successfully completed the challenge. On `HackTheBox`, these flags are typically stored in users' Desktop folders. Let's see which users we can access on this system, using the ``dir`` command. First, we'll get a directory listing of the ``C:\`` drive:

.. code-block:: none

    C:\WINDOWS\system32>dir C:\
    dir C:\
     Volume in drive C has no label.
     Volume Serial Number is 54BF-723B

     Directory of C:\

    16/03/2017  07:30 ��                 0 AUTOEXEC.BAT
    16/03/2017  07:30 ��                 0 CONFIG.SYS
    16/03/2017  08:07 ��    <DIR>          Documents and Settings
    16/03/2017  07:33 ��    <DIR>          Program Files
    16/03/2020  12:32 ��    <DIR>          WINDOWS
                   2 File(s)              0 bytes
                   3 Dir(s)   6.473.027.584 bytes free

On this system, user accounts are stored in the ``Documents and Settings`` folder. Let's see what's inside that folder:

.. code-block:: none

    C:\WINDOWS\system32>dir "C:\Documents and Settings\"
    dir "C:\Documents and Settings\"
     Volume in drive C has no label.
     Volume Serial Number is 54BF-723B

     Directory of C:\Documents and Settings

    16/03/2017  08:07 ��    <DIR>          .
    16/03/2017  08:07 ��    <DIR>          ..
    16/03/2017  08:07 ��    <DIR>          Administrator
    16/03/2017  07:29 ��    <DIR>          All Users
    16/03/2017  07:33 ��    <DIR>          john
                   0 File(s)              0 bytes
                   5 Dir(s)   6.473.027.584 bytes free

Notice that I surround the directory path in quotes; this is because there are spaces in the folder name. Without the quotes, `Windows` would think I was asking for a listing of the ``C:\Documents`` folder, which doesn't exist.

There appear to be two users on this system: ``Administrator`` and ``john``. Let's see what's on John's desktop:

.. code-block:: none

    C:\WINDOWS\system32>dir "C:\Documents and Settings\john\Desktop"
    dir "C:\Documents and Settings\john\Desktop"
     Volume in drive C has no label.
     Volume Serial Number is 54BF-723B

     Directory of C:\Documents and Settings\john\Desktop

    16/03/2017  08:19 ��    <DIR>          .
    16/03/2017  08:19 ��    <DIR>          ..
    16/03/2017  08:19 ��                32 user.txt
                   1 File(s)             32 bytes
                   2 Dir(s)   6.473.027.584 bytes free

Aha! There's a ``user.txt`` file. Let's see what's inside. To do this, we'll use the ``type`` command, which prints out the contents of the file:

.. code-block:: none

    C:\WINDOWS\system32>type "C:\Documents and Settings\john\Desktop\user.txt"
    type "C:\Documents and Settings\john\Desktop\user.txt"
    e69af0e4f443de7e36876fda4ec7644f

Bingo! There's our first flag! We can now submit that strange-looking string (``e69af0e4f443de7e36876fda4ec7644f``) in the `HackTheBox` page for `Legacy` to claim the User flag. Next, let's see what's on the ``Administrator`` account's desktop:

.. code-block:: none

    C:\WINDOWS\system32>dir "C:\Documents and Settings\Administrator\Desktop"
    dir "C:\Documents and Settings\Administrator\Desktop"
     Volume in drive C has no label.
     Volume Serial Number is 54BF-723B

     Directory of C:\Documents and Settings\Administrator\Desktop

    16/03/2017  08:18 ��    <DIR>          .
    16/03/2017  08:18 ��    <DIR>          ..
    16/03/2017  08:18 ��                32 root.txt
                   1 File(s)             32 bytes
                   2 Dir(s)   6.473.027.584 bytes free

We've found a ``root.txt`` file! This will typically contain the "root" flag, which proves we've gained admin access to the target system. Let's see what's inside, once again using the ``type`` command:

.. code-block:: none

    C:\WINDOWS\system32>type "C:\Documents and Settings\Administrator\Desktop\root.txt"
    type "C:\Documents and Settings\Administrator\Desktop\root.txt"
    993442d258b0e0ec917cae9e695d5713

Excellent! We've now obtained the "root" flag, and can claim it on `HackTheBox`. At this point, we've successfully completed this CTF system! We can now disconnect from the box using the ``exit`` command twice, once to leave the `Windows` command terminal, and again to exit `Meterpreter`.

.. note::

    While using ``exit`` twice has disconnected us from the target system, the `Meterpreter` payload still exists on the target system. This is generally considered bad form in a penetration test, as we're leaving behind malicious payloads without cleaning up our tracks. For the purposes of this walk-through, however, we'll overlook this oversight.

Congratulations! You've successfully completed your first `HackTheBox` CTF challenge, and gained some valuable experience in the process. Feel free to continue reading through the rest of the chapters in order, or skip ahead to the :ref:`walkthroughs` section to see walk-throughs of other machines!
