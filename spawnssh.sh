#!/usr/bin/bash
echo -e '#!/usr/bin/bash' > collectssh
echo -e 'hostname=$1' >> collectssh
echo -e 'read -p "Username:" username' >> collectssh
echo -e 'read -sp "Password:" password' >> collectssh
echo -e 'secret=$password' >> collectssh
echo -e 'logtime=`date "+%Y%m%d-%H%M%S"`' >> collectssh
echo -e 'logfile="./${hostname}_${logtime}.log"' >> collectssh
echo -e 'expect -c "' >> collectssh
echo -e 'set timeout 5' >> collectssh
echo -e 'spawn ssh -oStrictHostKeyChecking=no ${username}@$1' >> collectssh
echo -e 'expect \"Password:\"' >> collectssh
echo -e 'sleep 3.5' >> collectssh
echo -e 'send \"${password}\\n\"' >> collectssh
echo -e 'expect \">\"' >> collectssh
echo -e 'sleep 3.5' >> collectssh
echo -e 'send \"enable\\n\"' >> collectssh
echo -e 'expect \"Password:\"' >> collectssh
echo -e 'sleep 3.5' >> collectssh
echo -e 'send \"${secret}\\n\"' >> collectssh
echo -e 'expect \"#\"' >> collectssh
echo -e 'sleep 3.5' >> collectssh
echo -e 'send \"ter len 0\\n\"' >> collectssh
echo -e 'expect \"#\"' >> collectssh
echo -e 'sleep 3.5' >> collectssh
echo -e 'log_file ${logfile}'  >> collectssh

IFS=$'\n'
for i in `cat ./commands`
do
  echo -e 'send \"'$i'\\n\"\nexpect \"#\"' >>collectssh
  echo -e 'sleep 3.5' >>collectssh
done

echo -e 'log_file' >> collectssh
echo -e \" >> collectssh
chmod 755 collectssh
