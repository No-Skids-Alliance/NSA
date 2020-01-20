Pentest Methodology
===================
As in other areas of engineering and science, pentesting is most effective when based on the foundation of a solid methodology. A variety of penetration testing methodologies have been published, each outlining a set of phases and objectives. These methodologies help ensure a thorough, comprehensive test, and help hackers stay organized and maximize their effectiveness.

One of the most basic and widely-recognized standards is the `Penetration Testing Execution Standard`_ (PTES). Other standards, such as the `Open Source Security Testing Methodology Manual`_ (OSSTMM) or the `Penetration Testing Framework`_ (PTF), are widely-used as well.

.. _Penetration Testing Execution Standard: http://www.pentest-standard.org/index.php/Main_Page
.. _Open Source Security Testing Methodology Manual: https://www.isecom.org/research.html
.. _Penetration Testing Framework: http://www.vulnerabilityassessment.co.uk/Penetration%20Test.html

.. note::

  For more information about various methodologies, check out the `OWASP Wiki`_.

.. _OWASP Wiki: https://www.owasp.org/index.php/Penetration_testing_methodologies

Let's take a closer look at the PTES. Here's a summary breakdown:

1. Pre-Engagement Interactions
    * All the "business stuff" that must be done prior to the engagement.
    * Determine the :index:`scope` of the engagement.
    * Declare the rules of engagement.
    * Discuss time constraints.
    * Negotiate hourly fee.
2. Intelligence Gathering
    * Collect information about the target.
    * :index:`OSINT`
    * Passive Reconnaissance (No direct contact with targets.)
    * Active Reconnaissance (Direct contact with targets.)
3. Threat Modeling
    * Determine the most valuable targets, and most likely attackers.
    * Helps prioritize targets/attacks and maximize the value of the test.
4. Vulnerability Analysis
    * Discover flaws which can be leveraged by an attacker.
    * Enumerate potential weak-points (vulnerable services, policies, etc.).
5. Exploitation
    * Actively exploit discovered weaknesses to confirm vulnerabilities.
6. Post-Exploitation
    * Discover additional information, routes to compromise, etc.
    * Exfiltrate valuable data.
    * Maintain and expand access.
7. :index:`Reporting <report>`
    * Convey the results of the test to the client.
    * High-level summary as well as low-level, in-depth analysis and walkthrough.

At first glance, this might seem pretty complicated. And if you take a closer look at the [PTES](http://www.pentest-standard.org/index.php/Main_Page), you'll find that there are a great many steps involved in each section of the test. However, the PTES and other methodologies aren't as complicated as they seem. They include detailed information and instructions, but this is mainly to prevent accidental oversight.

In truth, each of the established :index:`penetration testing <penetration test>` methodologies essentially follow the Scientific Method:

1. Ask a question.
2. Do background research.
3. Construct a hypothesis.
4. Test with an experiment.
5. Did the experiment work?
    * No? Troubleshoot the procedure, then return to 4.
    * Yes? Proceed to 6.
6. Analyze the data and draw conclusions.
7. Do the results align with your hypothesis?
    * Partially / not at all? Use your experimental data as the basis for new research and experiments. Proceed to 8.
    * Yes? Proceed to 8.
8. Communicate the results.

A penetration test is, essentially, the Scientific Method on a loop. Simplified, it looks like this:

1. Research: Collect as much information as possible.
2. Analyze: Consider the information, and devise a plan of action.
3. Act: Carry out the plan, and report the results.

This loop can be seen in the PTES:

1. Pre-Engagement Interactions
    * Scientific Method: Ask a question. ("How is my client vulnerable to attack?")
    * Establish the parameters and scope of the test. (This is, essentially, just asking a more specific question.)
2. Intelligence Gathering
    * Research: Gather as much knowledge about the client as possible.
3. Threat Modeling
    * Analyze: Consider and prioritize likely attackers and targets.
    * Act: Carry out the remainder of the test based on the established priorities.
4. Vulnerability Analysis
    * Discovery: Investigate each priority target, learning all you can.
    * Analysis: Consider and prioritize likely weaknesses.
5. Exploitation
    * Act: Exploit weaknesses according to established priorities.
6. Post-Exploitation
    * Discovery: With new levels of access/control, gain as much information as possible.
    * Analysis: Consider and prioritize additional weaknesses or ways to gain additional access/control.
    * Action: Continue the test until a satisfactory conclusion has been reached.
7. Reporting
    * Scientific Method: Communicate the results.

If we break it down further, a :index:`penetration test` is just a large scientific experiment comprising a series of smaller scientific experiments, each following the complete Scientific Method. For example, let's say that in step 4, a hacker discovered a possible :index:`Remote Code Execution` (RCE) vulnerability in the target's system. To determine whether the RCE can be exploited, the hacker essentially conducts a scientific experiment:

1. Ask a question: `"Is this service vulnerable?"`
2. Do background research: `Find possible exploit code. Determine target OS and architecture. Consider potential shellcodes.`
3. Construct a hypothesis: `"I believe that Exploit A with Shellcode B will result in remote access to the target."`
4. Test with an experiment: `Run the exploit.`
5. Did it work? `"Yes!"`
6. Analyze the data and draw conclusions: `"The target service is vulnerable to Exploit A with Shellcode B, providing the attacker with a remote shell."`
7. Do the results align with your hypothesis? `"Yes."`
8. Communicate the results: `Add the data to the report.`

As you can see, each step of the penetration test "experiment" can be considered an experiment on its own.
