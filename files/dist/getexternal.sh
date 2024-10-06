#! /bin/bash
# vim: set tabstop=4 shiftwidth=4 expandtab filetype=sh:

if ! hash wget; then
    echo "wget is not installed. On a Mac, install it with MacPorts or Homebrew."
fi

echo "Downloading items..."

mkdir -p files/external/source
wget -O files/external/source/ciopfs-0.4.tar.gz http://www.brain-dump.org/projects/ciopfs/ciopfs-0.4.tar.gz
wget -O files/external/source/macipgw.zip https://github.com/jasonking3/macipgw/archive/4f77c0933544767885c33c25545c48cc368a6dab.zip
wget -O files/external/source/netatalk-2.4.10.tar.xz https://github.com/Netatalk/netatalk/releases/download/netatalk-2-4-10/netatalk-2.4.10.tar.xz
wget -O files/external/source/nulib2-3.1.0a2.zip https://github.com/fadden/nulib2/archive/20fe7efb4d37fedf807416c16d74d51d893ea48a.zip
wget -O files/external/source/unar-1.8.1.zip https://github.com/incbee/Unarchiver/archive/unar-1.8.1.zip

mkdir -p files/external/appleii
wget -O files/external/appleii/Apple_II_System_Disk_3.2.sea.bin http://download.info.apple.com/Apple_Support_Area/Apple_Software_Updates/English-North_American/Apple_II/Apple_II_Supplemental/Apple_II_System_Disk_3.2.sea.bin
wget -O files/external/appleii/p8.atalk.po http://apple2.guidero.us/lib/exe/fetch.php/projects/p8.atalk.po
wget -O files/external/appleii/Asimov.shk http://www.ninjaforce.com/downloads/Asimov.shk
wget -O files/external/appleii/MOUNTIT.SHK http://www.brutaldeluxe.fr/products/apple2gs/MOUNTIT.SHK
wget -O files/external/appleii/TCPIP30b11.SHK http://www.apple2.org/marinetti/TCPIP30b11.SHK
wget -O files/external/appleii/PPPX.1.3d4.SHK http://www.apple2.org/marinetti/PPPX.1.3d4.SHK
wget -O files/external/appleii/dsk2file.shk http://dwheeler.com/6502/oneelkruns/dsk2file.zip
wget -O files/external/appleii/gshk11.sea http://www.nulib.com/library/gshk11.sea
wget -O files/external/appleii/shrinkit.sdk http://www.nulib.com/library/shrinkit.sdk
wget -O files/external/appleii/spectrum_platinum_2mg.zip http://speccie.uk/speccie/downloads/spectrum_platinum.2mg.zip
wget -O files/external/appleii/uthernet2ll.bxy http://speccie.uk/speccie/downloads/uthernet2ll.bxy
wget -O files/external/appleii/uthernetll.bxy http://speccie.uk/speccie/downloads/uthernetll.bxy
wget -O files/external/appleii/NetDisk10.shk https://github.com/sheumann/NetDisk/releases/download/v1.0/NetDisk10.shk
wget -O files/external/appleii/AFPBridgeB1.shk https://github.com/sheumann/AFPBridge/releases/download/v1.0b1/AFPBridgeB1.shk

unset safeUrl samUrl snapUrl webberUrl networkerUrl checkfileUrl
safeUrl=$(wget -qO- http://speccie.uk/software/safe2/ | grep -i 'safe2.*bxy' | tr '<>' '\n' | grep href | cut -d '=' -f 2 | tr -d '"')
samUrl=$(wget -qO- http://speccie.uk/software/sam2/ | grep -i 'sam2.*bxy' | tr '<>' '\n' | grep href | cut -d '=' -f 2 | tr -d '"')
snapUrl=$(wget -qO- http://speccie.uk/software/snap/ | grep -i 'snap.*bxy' | tr '<>' '\n' | grep href | cut -d '=' -f 2 | tr -d '"')
webberUrl=$(wget -qO- http://speccie.uk/software/webber/ | grep -i 'webber.*bxy' | tr '<>' '\n' | grep href | cut -d '=' -f 2 | tr -d '"')
networkerUrl=$(wget -qO- http://speccie.uk/software/networker2/ | grep -i 'netwrk.*bxy' | tr '<>' '\n' | grep href | cut -d '=' -f 2 | tr -d '"')
checkfileUrl=$(wget -qO- http://speccie.uk/software/check-file-permanent-initialisation-file/ | grep -i 'chkfile.*bxy' | tr '<>' '\n' | grep href | cut -d '=' -f 2 | tr -d '"')
wget -O files/external/appleii/safe2.bxy "$safeUrl"
wget -O files/external/appleii/sam2.bxy "$samUrl"
wget -O files/external/appleii/snap.bxy "$snapUrl"
wget -O files/external/appleii/webber.bxy "$webberUrl"
wget -O files/external/appleii/networker.bxy "$networkerUrl"
wget -O files/external/appleii/checkfile.bxy "$checkfileUrl"

mkdir -p files/appleii
mkdir -p files/appleii/a2ws
wget -O files/appleii/a2ws/A2GS.WS.HDV https://appleii.ivanx.com/a2server/files/appleii/a2ws/A2GS.WS.HDV
wget -O files/appleii/MarinettiB1.SHK https://appleii.ivanx.com/a2server/files/appleii/MarinettiB1.SHK
wget -O files/appleii/FARALLON.B1.PO https://appleii.ivanx.com/a2server/files/appleii/FARALLON.B1.PO
wget -O files/appleii/A2CLOUD.HDV https://appleii.ivanx.com/a2server/files/appleii/A2CLOUD.HDV
wget -O files/safe2-setup.tgz https://appleii.ivanx.com/a2server/files/safe2-setup.tgz
wget -O files/snap-groups.tgz https://appleii.ivanx.com/a2server/files/snap-groups.tgz
wget -O files/snap-setup.tgz https://appleii.ivanx.com/a2server/files/snap-setup.tgz

for gsosInstall in {1..4}; do
    activeDisk=0
    mkdir -p files/external/appleii/gsos60${gsosInstall}
    
    diskNames=( Install System.Disk SystemTools1 SystemTools2 Fonts synthLAB )
    if (( $gsosInstall == 1 )); then
        gsosURL="http://archive.org/download/download.info.apple.com.2012.11/download.info.apple.com.2012.11.zip/download.info.apple.com%2FApple_Support_Area%2FApple_Software_Updates%2FEnglish-North_American%2FApple_II%2FApple_IIGS_System_6.0.1%2F"
        wget -O files/external/appleii/gsos601/Disk_7_of_7-Apple_II_Setup.sea.bin "http://archive.org/download/download.info.apple.com.2012.11/download.info.apple.com.2012.11.zip/download.info.apple.com%2FApple_Support_Area%2FApple_Software_Updates%2FEnglish-North_American%2FApple_II%2FApple_IIGS_System_6.0.1%2FDisk_7_of_7-Apple_II_Setup.sea.bin"
    elif (( $gsosInstall == 2 )); then
        gsosURL="http://mirrors.apple2.org.za/Apple%20II%20Documentation%20Project/Software/Operating%20Systems/Apple%20IIGS%20System/Disk%20Images/"
        diskNames=( Install System.Disk SystemTools1 SystemTools2 SystemTools3 Fonts1 Fonts2 synthLAB )
        diskWebNames=( Install System%20disk System%20tools%201 System%20tools%202 System%20tools%203 Fonts%201 Fonts%202 Synthlab )
    elif (( $gsosInstall == 3 )); then
        gsosURL="http://mirrors.apple2.org.za/ftp.apple.asimov.net/images/gs/os/gsos/Apple_IIGS_System_6.0.3/"
    elif (( $gsosInstall == 4 )); then
        diskNames=( Install System.Disk SystemTools1 SystemTools2 SystemTools3 Fonts Fonts2 synthLAB )
        gsosURL="http://mirrors.apple2.org.za/ftp.apple.asimov.net/images/gs/os/gsos/Apple_IIGS_System_6.0.4/PO%20Disk%20Images/"
    fi

    for diskname in ${diskNames[@]}; do
        outfile="files/external/appleii/gsos60${gsosInstall}/$diskname.po"
        (( activeDisk++ ))
        if (( $gsosInstall == 1 )); then
            wget -O files/external/appleii/gsos601/"Disk_${activeDisk}_of_7-${diskname}.sea.bin" "${gsosURL}Disk_${activeDisk}_of_7-${diskname}.sea.bin"
        elif (( $gsosInstall == 2 )); then
            wget -O $outfile "$gsosURL/IIGS%20System%206.0.2%20-%20Disk%20${activeDisk}%20${diskWebNames[$activeDisk-1]}.po"
        elif (( $gsosInstall == 3 )); then
            wget -O $outfile "$gsosURL/$diskname.po"
        elif (( $gsosInstall == 4 )); then
            wget -O $outfile "$gsosURL/$diskname.po"
        fi
    done
done
