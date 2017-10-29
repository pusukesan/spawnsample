#!/usr/bin/bash
echo -e '#!/usr/bin/bash' > collecttelnet
echo -e 'hostname=$1' >> collecttelnet
echo -e 'read -p "Username:" username' >> collecttelnet
echo -e 'read -sp "Password:" password' >> collecttelnet
echo -e 'secret=$password' >> collecttelnet
echo -e 'logtime=`date "+%Y%m%d-%H%M%S"`' >> collecttelnet
echo -e 'logfile="./${hostname}_${logtime}.log"' >> collecttelnet
echo -e 'expect -c "' >> collecttelnet
echo -e 'set timeout 5' >> collecttelnet
echo -e 'spawn telnet $1' >> collecttelnet
echo -e 'expect \"Username:\"' >> collecttelnet
echo -e 'send \"${username}\\n\"' >> collecttelnet
echo -e 'expect \"Password:\"' >> collecttelnet
echo -e 'sleep 3.5' >> collecttelnet
echo -e 'send \"${password}\\n\"' >> collecttelnet
echo -e 'expect \">\"' >> collecttelnet
echo -e 'sleep 3.5' >> collecttelnet
echo -e 'send \"enable\\n\"' >> collecttelnet
echo -e 'expect \"Password:\"' >> collecttelnet
echo -e 'sleep 3.5' >> collecttelnet
echo -e 'send \"${secret}\\n\"' >> collecttelnet
echo -e 'expect \"#\"' >> collecttelnet
echo -e 'sleep 3.5' >> collecttelnet
echo -e 'send \"ter len 0\\n\"' >> collecttelnet
echo -e 'expect \"#\"' >> collecttelnet
echo -e 'sleep 3.5' >> collecttelnet
echo -e 'log_file ${logfile}'  >> collecttelnet

IFS=$'\n'
for i in `cat ./commands`
do
  echo -e 'send \"'$i'\\n\"\nexpect \"#\"' >>collecttelnet
  echo -e 'sleep 3.5' >>collecttelnet
done

echo -e 'log_file' >> collecttelnet
echo -e \" >> collecttelnet
chmod 755 collecttelnet
