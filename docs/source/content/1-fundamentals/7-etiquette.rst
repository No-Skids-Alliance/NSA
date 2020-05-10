.. _hacker etiquette:

Hacker Etiquette
================
As a hacker of the ethical variety, you should always be mindful of the consequences of your actions, both in the physical and the digital realms. As such, we've compiled the following unofficial, highly subjective collection of rules and guidelines on Hacker Etiquette.


.. _keep it stable:

Keep it Stable
--------------
Don't crash systems if you can help it. Research your exploits. Know the risks. If possible, test exploits on a custom-built VM before attempting to use them against your target. Whatever you do, avoid taking actions that will destabilize a target.

In a CTF, destabilizing a target will result in other users being unable to hack that target. Sure, on sites like HTB you could just hit the `reset` button and revert the box, but that's bad form. Resetting a box will eject anyone currently trying to hack that box, causing them to have to start over. It's better to avoid crashing the system in the first place.

In the real world, crashing systems is a surefire way to be detected. In addition, it reduces your attack surface and could incur a significant cost to your target.


.. _don't be a dosser:

Don't be a DoSser
~~~~~~~~~~~~~~~~~
Along the same vein of :ref:`keep it stable`, `Denial of Service` attacks are one of the least useful and most obnoxious in a hacker's arsenal. They are a tool, like any other, and as such are not inherently good or evil. However, I'll hazard to say that 99% of the DoS attacks committed don't serve any good purpose. Don't be a DoSser.


.. _avoid brute-force:

Avoid Brute-Force
~~~~~~~~~~~~~~~~~
Another topic related to :ref:`keeping it stable <keep it stable>` is brute-force attacks. Generally speaking, you should avoid brute-force as much as possible, and when brute-force is necessary, do your best to limit the scope of the attack. Unbridled brute-force attacks can destabilize or crash target systems. They are noisy and increase your likelihood of detection. In most CTFs, brute-force techniques are unnecessary. In the real-world, if you're spraying `rockyou.txt` at a target's SSH login, you're already in the weeds.


.. _cover your tracks:

Cover Your Tracks
-----------------
Don't be a slob. Clean up after yourself. Whether you've uploaded files, changed databases or configurations, or made any other changes on a system, you should attempt to reverse these changes when they're no longer necessary.

In a CTF, leaving evidence of your attacks and attempts can spoil the challenge for other contenders, or give them an advantage by allowing them to take advantage of all your hard work. Before you say "just reset the box," remember what we said earlier: that's bad form. The reset button should only be used if the system is broken. It's better to just cover your tracks.

In the real world, leaving tracks on a system not only increases your chance of getting caught on that system, but it also makes it easier for other attackers to compromise your target.
