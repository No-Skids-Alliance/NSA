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
    * Determine the scope of the engagement.
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
7. Reporting
    * Convey the results of the test to the client.
    * High-level summary as well as low-level, in-depth analysis and walk-through.

At first glance, this might seem pretty complicated. And if you take a closer look at the [PTES](http://www.pentest-standard.org/index.php/Main_Page), you'll find that there are a great many steps involved in each section of the test. However, the PTES and other methodologies aren't as complicated as they seem. They include detailed information and instructions, but this is mainly to prevent accidental oversight.

In truth, each of the established penetration testing methodologies essentially follow the Scientific Method:

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

A penetration test is, essentially, the Scientific Method applied to security. In the pre-engagement interactions, you establish the experiment's question. Essentially, "How is my client vulnerable to attack?" The scope narrows the focus of the question, defining the constraints of the experiment. Once the scope is defined, you move on to the research portion, gathering intelligence about the target. Threat modeling enables you to construct a hypothesis about potential routes for exploitation. To confirm or reject hypotheses, pentesters conduct simulated attacks (experiments, essentially).

These simulated attacks each follow their own Scientific Method, from question ("Is this version of Sendmail vulnerable?") to hypothesis ("This CVE should provide remote code execution.") to experimentation, analysis, and conclusion ("This version of Sendmail is not vulnerable to this CVE."), after which the results of the experiment are recorded.

Once all the attacks are complete, the pentester analyzes all the data and draws conclusions, which are communicated to the client in a final report.
