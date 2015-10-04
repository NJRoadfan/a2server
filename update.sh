#! /bin/bash

currentVersion=124

if [[ -f /usr/local/etc/A2SERVER-version ]]; then
	installedVersion=$(cat /usr/local/etc/A2SERVER-version)
else
	installedVersion=100
fi

# Ensure URL we'll use ends in a /
case "$A2SERVER_SCRIPT_URL" in
	*/) scriptURL="$A2SERVER_SCRIPT_URL" ;;
	*) scriptURL="${A2SERVER_SCRIPT_URL:-http://appleii.ivanx.com/a2server}/" ;;
esac

autoAnswerYes=
for arg in $@; do
    if [[ $arg == "-y" ]]; then
        autoAnswerYes=1
        break
    fi
done

echo
echo "Update history:"
wget -qO- "${scriptURL}update/versionhistory.txt"
echo
echo "installed version: ${installedVersion:0:1}.${installedVersion:1:1}.${installedVersion:2:1}"
echo "current version: ${currentVersion:0:1}.${currentVersion:1:1}.${currentVersion:2:1}"
echo
if [[ $autoAnswerYes ]]; then
    REPLY="y"
else
    echo -n "Do you want to update (or reinstall) A2SERVER? "
    read
fi
if [[ ${REPLY:0:1} == "y" || ${REPLY:0:1} == "Y" ]]; then
    sudo rm /usr/local/etc/A2SERVER-version &> /dev/null
    # sudo rm /usr/local/etc/netatalk/a2boot/* &> /dev/null
    wget -q -O /tmp/setup "${scriptURL}setup"; source /tmp/setup "$@"
fi

unset currentVersion 2> /dev/null
unset installedVersion 2> /dev/null
