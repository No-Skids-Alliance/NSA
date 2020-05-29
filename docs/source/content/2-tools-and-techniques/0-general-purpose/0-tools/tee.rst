.. _tee:

Tee: Transparently Save Output from Tools
=========================================

.. index:: !tee

+-----------+------------------------------+
|**OS**     | All major sperating systems. |
+-----------+------------------------------+

+------------+------------------------------------------------------+
|                    **Reference  Walk-Throughs**                   |
+============+======================================================+
|`HackTheBox`|:ref:`Lame <Lame Enum>`                               |
+------------+------------------------------------------------------+
|`VulnHub`   |:ref:`Kioptrix Level 1 <Kioptrix Level 1 Enumeration>`|
+------------+------------------------------------------------------+



What is tee?
------------
The `tee` utility transparently pipes the output of a command-line utility into a text file, while continuing to display the output of the command as usual.


How does it work?
-----------------
By piping the output of a command into `tee`, the **STDOUT** (standard output) of that command becomes the **STDIN** (standard input) of `tee`. When `tee` receives this input, it sends the data to its own **STDOUT** (printing it to the screen) while simultaneously saving the output to a file.


Using tee
---------

.. note::

    The following instructions apply to the `tee` command on Unix-like systems, such as Linux or BSD. There is also a `tee` command in `FreeDOS`, `PowerShell`, and other systems. For more information on how to use `tee` in these contexts, you should exercise your Google-fu.

To use `tee`, simply pipe the output of another tool into the `tee` utility by using the pipe (``|``) symbol, and append any command-line modifiers you wish, followed by one or more file names to which you would like the output saved. Examples:

.. code-block:: none

    cat file1.txt | tee file2.txt
    enum4linux 10.1.1.102 | tee -a target.enum4linux
    echo "something important" | tee file1.txt file2.txt

At a minimum, `tee` expects to be passed at least one filename.


``-a``: Append to the Specified File(s)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
**Example:** ``cat file1.txt | tee -a file2.txt``

By default, `tee` will erase the contents of whatever output files are specified prior to writing the new contents. By using the ``-a`` flag, you can tell `tee` to append to the file instead. This preserves the existing data in the file, adding the new data to the end of the file.

This is similar to the ``>>`` redirection in `Linux`, which appends to the output file, as opposed to the ``>`` redirection, which overwrites the output file.
