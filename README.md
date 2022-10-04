# Thoth
A bash script to analyze and parse information on auth.log files in Linux systems
This script takes a file then provides the user with various options to quickly pull different kinds of information from an auth.log.

# Usage

First, we need to CD into the THOTH folder

![image](https://user-images.githubusercontent.com/105451443/193734768-581280e6-d899-411b-a4bc-03df6e669eb8.png)

Then, we need to go into the auth_logs folder, which is where we will move the scripts that we want to analyze.

![image](https://user-images.githubusercontent.com/105451443/193734941-828ab73f-7b0c-447a-ae09-958626979163.png)

In this case here, we have 3 auth.log files we can use. We are ready to begin.

# Intro Screen

![image](https://user-images.githubusercontent.com/105451443/193735510-e4349ef9-4270-4176-b2ca-e1b2e0a309a0.png)

Here, we need to input the name of the file we would like to analyse. Let's use the first one: "auth.log"

![image](https://user-images.githubusercontent.com/105451443/193735650-7af91748-1494-4296-9719-d61166a964ce.png)

As we can see, we are provided with a number of options. Let's go through each of them and see what they do.
---

# Option 1 - filter for **ALL** failed attempts

![image](https://user-images.githubusercontent.com/105451443/193735882-9dc12535-e9af-446b-9749-430e668637b9.png)

Selecting the first options makes the script parse the file and filter out the following:
1. The **IP address** with the **most failed login attempts**
2. The **number** of failed attempts made by the IP address
3. The **country of origin** of the culprit IP address

If we go back to the THOTH_FILES folder, we will also be able to see a generated report with more detailed information, should we need to filter through the information ourselves.

![image](https://user-images.githubusercontent.com/105451443/193736352-aaa9ec61-73cf-41db-bb7b-bdb606860fa9.png)

Here's what we see when we cat the file:

### Logs for all failed password attempts

![image](https://user-images.githubusercontent.com/105451443/193736595-0a2f06c9-e1a1-49b8-96df-dfec6065826f.png)

### List of ips that failed login attempts and the number of times each IP attempted access

![image](https://user-images.githubusercontent.com/105451443/193736787-174f1261-8f45-4cac-ae76-813335634195.png)

Next, let's have a look at option 2.
---
# Option 2 - Filter for **Failed Attempts as Root**

![image](https://user-images.githubusercontent.com/105451443/193737210-42a96201-28cb-4bc9-9e39-6ed1699b60ba.png)

The info this option provides is similar to the 1st option, we are provided with:
1. **IP address** that **attempted but failed to log in as Root** the **MOST**
2. **Number** of times the IP address attempted login
3. **Country of origin** of the culprit IP

All the options will output results, and then save a report with more detailed information. 
With option 2, if we navigate to the THOTH_FILES folder, we will see:

![image](https://user-images.githubusercontent.com/105451443/193737672-9bb69f2f-51d3-4ac3-af80-1c068d989e56.png)


The FailedRoot file contains the report. If we cat it, we will see:
### Logs for all Failed Root Attempts

![image](https://user-images.githubusercontent.com/105451443/193737736-4446619e-76a4-475f-9acd-93f15965a70e.png)

### List of IPs that attempted login

![image](https://user-images.githubusercontent.com/105451443/193737837-0d249715-809a-462d-a23f-d3d28d1ed75b.png)

---

# Option 3 - Filter for **All Invalid Users**

![image](https://user-images.githubusercontent.com/105451443/193738168-27f0c702-0e65-4073-a416-db1c8443d484.png)

Option 3 gives us slightly different information.
It tells us the following:
1. How many **unique invalid usernames** were attempted
2. **Which user** attempted login **the most**
3. How many **times the identified invalid user attempted login**

If we look in the THOTH_FILES folder, we will see the following generated report:

![image](https://user-images.githubusercontent.com/105451443/193738721-5a6814c6-169e-4601-bdc7-137e210dd0e4.png)

The report is generated with the filename "Invalid Users"
If we cat this file, we will see:

### Invalid user logs

![image](https://user-images.githubusercontent.com/105451443/193738889-5d42828e-8505-499e-b555-64e03191e857.png)

### List of users and number of login attempts

![image](https://user-images.githubusercontent.com/105451443/193738964-480fcf78-1f2c-4c29-82f0-0af3bd9c195f.png)

---

# Option 4 - Filter for **All successful non-root attempts**

![image](https://user-images.githubusercontent.com/105451443/193739299-7d39d628-cc64-41b8-b7fe-f8eae5c880ad.png)

This particular auth.log had no successful logins.
In the report generated, we can observe the following categories:

![image](https://user-images.githubusercontent.com/105451443/193739614-ad14fff6-4e30-4c6e-aaac-6b3d4a884e7c.png)

---

# Option 5 - Filter for **All successful attempts as ROOT**

![image](https://user-images.githubusercontent.com/105451443/193740030-68b8f41d-6f09-4fb4-8d12-723cfeb25d1e.png)

This options shows us:
1. **Which IP** gained root access successfully the most number of times
2. **How many times** said IP gained root access
3. **Country of origin** of identified IP

This can be useful when trying to spot anomalies such as logins from odd regions.

Like the other options, this option generates a report:

![image](https://user-images.githubusercontent.com/105451443/193740465-703688f7-3eb3-4153-85b1-dbfe7b401e00.png)

The report is saved with the filename "Successful ROOT logins"
If we cat the file, we can see the following categories:

![image](https://user-images.githubusercontent.com/105451443/193740635-9cf6c501-05ae-497f-8b1f-2a45ef562d4c.png)
---
And that's it for this script! As you can see, this is a very rudimentary script, intended more as a way to practice and implement text manipulation inside of bash scripts. 

# END

