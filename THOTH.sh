#!/bin/bash

#The variables below represent different paths for each of the available options.
thothpathF="/home/horus/THOTH_FILES/TotalFailed_$(date +%s).txt"
thothpathR="/home/horus/THOTH_FILES/FailedRoot_$(date +%s).txt"
thothpathI="/home/horus/THOTH_FILES/Invalid_Users_$(date +%s).txt"
thothpathA="/home/horus/THOTH_FILES/Successful_NON-ROOT_Logins_$(date +%s).txt"
thothpathAR="/home/horus/THOTH_FILES/Successful_ROOT_Logins_$(date +%s).txt"

#----------------------------------------------------------------------------------------------
# This block displays the name of the program, as well as states prerequisites that need
# to be met before running it.
echo "THOTH" | figlet -f pagga | lolcat -s 20

echo ""
echo "The Auth.Log Analyser" | cowsay -f eyes | lolcat -s 10 

sleep 1
echo ""
echo "Ensure that this script is being run in the folder where the relevant auth.log file is located."
echo ""
sleep 1

#---------------------------------------------------------------------------------------------
# This block asks the user which file they would like to analyse, then stores that value in the
# variable -filename-
# It then lists the possible options the user has for the program, 
# then reads and stores the option number inputted in the variable
# -option-

echo "Which file would you like to analyse?"
read filename

echo ""
echo -e "What would you like to filter for?\nEnter the option number."
echo ""
echo "Options:"
echo -e "1. Filter for ALL FAILED ATTEMPTS\n2. Filter for FAILED ATTEMPTS as ROOT\n3. Filter for ALL INVALID USERS\n4. Filter for ALL SUCCESSFUL NON-ROOT attempts\n5. Filter for SUCCESSFUL ROOT attempts"
echo ""

read option
echo ""
#------------------------------------------------------------------------------------------------------
# This block executes a series of commands if the value of -option- is equal to the integer value 1.
# It stores information such as the logs for only failed attempts, the IP addresses of the failed attempts and
# the number of times each IP failed at accessing the system into the variables -failedfilt- and -failedfiltcount-
# This info is stored in the file =TotalFailed= via the filepath ~thothpathF~
#
# Information such as the IP that tried to access the system the most, how many times that IP tried accessing 
# the system, as well as the country of origin of said IP is stored in the variables
# -max_ip-, -max- and -max_ip_country- respectively. These variables are printed out to the terminal.

if [[ "$option" -eq 1 ]];then

	failedfilt=$(cat "$filename" | grep -iw "failed")
	echo "-------------------------------------------------------------------------------" >> "$thothpathF"
	echo "LOGS FOR ALL FAILED LOGIN ATTEMPTS" >> "$thothpathF"
	echo "-------------------------------------------------------------------------------" >> "$thothpathF"
	echo "$failedfilt" >> "$thothpathF"
	echo "-------------------------------------------------------------------------------" >> "$thothpathF"
	echo "IPs THAT FAILED LOGIN ATTEMPTS AND NO. OF FAILURES" >> "$thothpathF"
	echo "-------------------------------------------------------------------------------" >> "$thothpathF"
	failedfiltcount=$(cat "$filename" | grep -iw "failed" | awk '{print $(NF-3)}' | sort | uniq -c | sort -n)
	echo "$failedfiltcount" >> "$thothpathF"
	echo "-------------------------------------------------------------------------------" >> "$thothpathF"
	max=$(cat "$filename" | grep -iw "failed" | awk '{print $(NF-3)}' | sort | uniq -c | sort -n | awk '{print $1}' | tail -n 1)
	max_ip=$(cat "$filename" | grep -iw "failed" | awk '{print $(NF-3)}' | sort | uniq -c | sort -n | awk '{print $2}' | tail -n 1) 
	echo "REPORT END" >> "$thothpathF"
	echo "-------------------------------------------------------------------------------" >> "$thothpathF"
	echo "The IP ADDRESS $max_ip failed to log in the most." | lolcat -s 20
	echo "Attempts made: $max" | lolcat -s 20 
	max_ip_country=$(whois "$max_ip" | grep -i country | sort | uniq | awk '{print $2}')
	echo "IP Source: $max_ip_country" | lolcat -s 20

#-------------------------------------------------------------------------------------------------------
# Similar to the above block, the below commands will be executed if the value of -option- is equal
# to 2.
# Information like the logs of failed ROOT attempts and a list of IPs that failed root access, along
# with how many times each of them failed root access is outputted to the file =FailedRoot= via the
# ~thothpathR~ filepath, stored in the variables -failedroot- and -failedrootcount-.
#
# Other info, such as which IP attempted and failed root access the most, how many times they failed root access
# and the country of origin of the IP are printed to the terminal.

elif [[ "$option" -eq 2 ]];then

	failedroot=$(cat "$filename" | grep -iw "failed" | grep -iw "root")
	echo "-------------------------------------------------------------------------------" >> "$thothpathR"
	echo "LOGS FOR FAILED ROOT ATTEMPTS" >> "$thothpathR"
	echo "-------------------------------------------------------------------------------" >> "$thothpathR"
	echo "$failedroot" >> "$thothpathR"
	echo "-------------------------------------------------------------------------------" >> "$thothpathR"
	echo "IPs THAT ATTEMPTED ROOT LOGIN BUT FAILED" >> "$thothpathR"
	echo "-------------------------------------------------------------------------------" >> "$thothpathR"
	failedrootcount=$(cat "$filename" | grep -iw "failed" | grep -iw "root" | awk '{print $(NF-3)}' | sort | uniq -c | sort -n)
	echo "$failedrootcount" >> "$thothpathR"
	echo "-------------------------------------------------------------------------------" >> "$thothpathR"
	max_root=$(cat "$filename" | grep -iw "failed" | grep -iw "root" | awk '{print $(NF-3)}' | sort | uniq -c | sort -n | awk '{print $1}' | tail -n 1)
	max_root_ip=$(cat "$filename" | grep -iw "failed" | grep -iw "root" | awk '{print $(NF-3)}' | sort | uniq -c | sort -n | awk '{print $2}' | tail -n 1)
	echo "REPORT END" >> "$thothpathR"
	echo "-------------------------------------------------------------------------------" >> "$thothpathR"
	echo "The IP ADDRESS $max_root_ip failed to log in AS ROOT the most." | lolcat -s 20
	echo "Attempts made to access root: $max_root" | lolcat -s 20
	max_root_country=$(whois "$max_root_ip" | grep -i country | sort | uniq | awk '{print $2}')
	echo "IP source: $max_root_country"

#--------------------------------------------------------------------------------------------------------
# Similarly, this block stores the logs for all invalid users, as well as all of their names along with how
# many times each invalid user attempted and failed to gain access into the variables -invalid- and
# -invalid names-. These variables are outputted to the file =Invalid= via the filepath ~thothpathI~
#
# Other information, such as the how many invalid users there are, the name of the invalid user
# that attempted to log in the most, as well as the number
# of times they attempted to log in, are stored in the variable -invalid_count-, -invalid_max- and
# -invalid_max_attempt-. These variables are printed out to the terminal.

elif [[ "$option" -eq 3 ]];then

	invalid=$(cat "$filename" | grep -iw "invalid" | grep -ivw "failed" | grep -ivw "disconnected" | grep -ivw "connection")
	echo "-------------------------------------------------------------------------------" >> "$thothpathI"
	echo "INVALID USER LOGS" >> "$thothpathI"
	echo "-------------------------------------------------------------------------------" >> "$thothpathI"
	echo "$invalid" >> "$thothpathI"
	echo "-------------------------------------------------------------------------------" >> "$thothpathI"
	echo "LIST OF INVALID USERS AND NO. OF LOGINS ATTEMPTS" >> "$thothpathI"
	echo "-------------------------------------------------------------------------------" >> "$thothpathI"
	invalid_names=$(cat "$filename" | grep -iw "invalid" | grep -ivw "failed" | grep -ivw "disconnected" | grep -ivw "connection" | awk '{print $8}' | sort | uniq -c | sort -n)
	echo "$invalid_names" >> "$thothpathI"
	echo "-------------------------------------------------------------------------------" >> "$thothpathI"
	echo "REPORT END" >> "$thothpathI"
	echo "-------------------------------------------------------------------------------" >> "$thothpathI"
	invalid_count=$(cat "$filename" | grep -iw invalid | grep -ivw failed | grep -ivw disconnected | grep -ivw connection | awk '{print $8}' | sort | uniq -c | sort -n | wc -l)
	invalid_max=$(cat "$filename" | grep -iw invalid | grep -ivw failed | grep -ivw disconnected | grep -ivw connection | awk '{print $8}' | sort | uniq -c | sort -n | tail -n 1 | awk '{print $2}')
	invalid_max_attempt=$(cat "$filename" | grep -iw invalid | grep -ivw failed | grep -ivw disconnected | grep -ivw connection | awk '{print $8}' | sort | uniq -c | sort -n | tail -n 1 | awk '{print $1}')
	echo "There are $invalid_count INVALID USERS" | lolcat -s 20
	echo "The invalid user $invalid_max had the most break-in attempts" | lolcat -s 20
	echo "Number of attempts: $invalid_max_attempt" | lolcat -s 20

#--------------------------------------------------------------------------------------------------------
# Like every other option, two variable, -accepted- and -accepted_users- store the information for
# the logs of the accepted users into the system as well as the usernames that successfully accessed the system
# and the number of times each of the successful users accessed the system. This info is outputted to the file
# =Successful_NON-ROOT= via the filepath ~thothpathA~
#
# The variables -accepted_user_count-, -maxuser-,  -maxusercount- and -maxusercountry- store information for how many valid users accessed the systems, along with
# which valid user accessed the system the most, how many times they accessed the system and the country
# of origin of their IP address. This info is printed to the terminal.

elif [[ "$option" -eq 4 ]];then

	accepted=$(cat "$filename" | grep -iw "accepted" | grep -iw "user")
	echo "-------------------------------------------------------------------------------" >> "$thothpathA"
	echo "LIST OF SUCCESFUL LOGINS INTO SYSTEM - NON-ROOT USERS" >> "$thothpathA"
	echo "-------------------------------------------------------------------------------" >> "$thothpathA"
	echo "$accepted" >> "$thothpathA"
	echo "-------------------------------------------------------------------------------" >> "$thothpathA"
	echo "LIST OF USERS AND NO. OF LOGINS FOR EACH - NON-ROOT USERS" >> "$thothpathA"
	echo "-------------------------------------------------------------------------------" >> "$thothpathA"
	accepted_users=$(cat "$filename" | grep -iw "accepted" | grep -iw "user" | awk '{print $(NF-5)}' | sort | uniq -c | sort -n)
	echo "$accepted_users" >> "$thothpathA"
	echo "-------------------------------------------------------------------------------" >> "$thothpathA"
	echo "REPORT END" >> "$thothpathA"
	echo "-------------------------------------------------------------------------------" >> "$thothpathA"
	accepted_user_count=$(cat "$filename" | grep -iw "accepted" | grep -iw "user" | awk '{print $(NF-5)}' | sort | uniq -c | sort -n | wc -l)
	echo "There are a total of $accepted_user_count accepted logins on this system" | lolcat -s 20
	maxuser=$(cat "$filename" | grep -iw accepted | grep -iw user | awk '{print $(NF-5)}' | sort | uniq -c | sort -n | tail -n 1 | awk '{print $2}')
	maxusercount=$(cat "$filename" | grep -iw accepted| grep -iw user | awk '{print $(NF-5)}' | sort | uniq -c | sort -n | tail -n 1 | awk '{print $1}')
	echo -e "The user $maxuser logged in the most.\n A total of $maxusercount times."
	maxusercountry=$(whois "$maxuser" | grep -i country | sort | uniq | awk '{print $2}')
	echo "IP source: $maxusercountry"

#--------------------------------------------------------------------------------------------------------
# This block executes if the value of -option- is equal to 5. The 2 variables, -accepted_root-
# and -accepted_root_IPs- store the information
# for the logs of all the accepted root users as well as the list of IPs that gained root access, as well as
# how many times each IP gained root access. This info is stored in the file =Successful_ROOT= via the
# filepath ~thothpathAR~
#
# The variables --, -- and -- store information for the IP that accessed root the most, as well as the number
# of times that IP accessed the system, and the country source of that IP. This info is printed out to the
# terminal.


elif [[ "$option" -eq 5 ]];then

	accepted_root=$(cat "$filename" | grep -iw "accepted" | grep -iw "root")
	echo "-------------------------------------------------------------------------------" >> "$thothpathAR"
	echo "LIST OF SUCCESFUL LOGINS INTO SYSTEM - ROOT USER" >> "$thothpathAR"
	echo "-------------------------------------------------------------------------------" >> "$thothpathAR"
	echo "$accepted_root" >> "$thothpathAR"
	echo "-------------------------------------------------------------------------------" >> "$thothpathAR"
	echo "LIST OF IPs THAT GAINED ROOT ACCESS & NO.OF LOGINS" >> "$thothpathAR"
	echo "-------------------------------------------------------------------------------" >> "$thothpathAR"
	accepted_root_IPs=$(cat "$filename" | grep -iw "accepted" | grep -iw "root" | awk '{print $(NF-3)}' | sort | uniq -c | sort -n)
	echo "$accepted_root_IPs" >> "$thothpathAR"
	echo "-------------------------------------------------------------------------------" >> "$thothpathAR"
	echo "REPORT END" >> "$thothpathAR"
	echo "-------------------------------------------------------------------------------" >> "$thothpathAR"
	common_root_ip=$(cat "$filename" | grep -iw "accepted" | grep -iw "root" | awk '{print $(NF-3)}' | sort | uniq -c | sort -n | tail -n 1 | awk '{print $2}')
	common_root_count=$(cat "$filename" | grep -iw "accepted" | grep -iw "root" | awk '{print $(NF-3)}' | sort | uniq -c | sort -n | tail -n 1 | awk '{print $1}')
	echo "Root accessed was gained most commonly from the IP $common_root_ip." | lolcat
	echo "This IP gained access to root a total of $common_root_count times." | lolcat
	common_root_country=$(whois "$common_root_ip" | grep -i country | sort | uniq | awk '{print $2}')
	echo "IP Source: $common_root_country"

else
	echo ""
	echo ""
	echo "Invalid option. Please enter either a valid option number."
fi
