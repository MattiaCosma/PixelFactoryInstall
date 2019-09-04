pix3link="https://dl.google.com/dl/android/aosp/crosshatch-qp1a.190711.020-factory-2eae0727.zip"
pix3xlink="https://dl.google.com/dl/android/aosp/crosshatch-qp1a.190711.020-factory-2eae0727.zip"
pix3alink="https://dl.google.com/dl/android/aosp/sargo-qp1a.190711.020-factory-afb4dbc1.zip"
pix3axlink="https://dl.google.com/dl/android/aosp/bonito-qp1a.190711.020-factory-1f47c677.zip"
pix2link="https://dl.google.com/dl/android/aosp/walleye-qp1a.190711.020-factory-fa9552ea.zip"
pix2xlink="https://dl.google.com/dl/android/aosp/taimen-qp1a.190711.020-factory-6f0233dd.zip"
pixlink="https://dl.google.com/dl/android/aosp/sailfish-qp1a.190711.020-factory-0bb95222.zip"
pixxlink="https://dl.google.com/dl/android/aosp/marlin-qp1a.190711.020-factory-2db5273a.zip"
adb_link="https://dl.google.com/android/repository/platform-tools_r29.0.2-linux.zip"
IMAGEZIP="image.zip"

cd ~/
if [ -d ~/install ]; then
 rm -rf ~/install
fi
mkdir install
cd install

#install adb
curl $adb_link -o adb.zip
unzip -qq adb.zip -d adb
export PATH=~/install/adb/platform-tools:$PATH
cd adb/platform-tools
adb devices

echo "Prima di tutto:"
echo "Abilita Debug USB"
echo "Abilita OEM Unlock"
echo "Backup dei tuoi dati"
echo ""
echo ""

echo "Qual'e il tuo device?"
echo "[1] Pixel 3"
echo "[2] Pixel 3a"
echo "[3] Pixel 3 Xl"
echo "[4] Pixel 3a Xl"
echo "[5] Pixel 2"
echo "[6] Pixel 2xl"
echo "[7] Pixel Xl"
echo "[8] Pixel"

read DEVICE

#download factory image
case $DEVICE in
  1 )
  curl $pix3link -o $IMAGEZIP
  unzip -qq $IMAGEZIP -d image
    ;;
  2 )
  curl $pix3alink -o $IMAGEZIP
  unzip -qq $IMAGEZIP -d image
    ;;
  3 )
  curl $pix3xlink -o $IMAGEZIP
  unzip -qq $IMAGEZIP -d image
    ;;
  4 )
  curl $pix3axlink -o $IMAGEZIP
  unzip -qq $IMAGEZIP -d image
    ;;
  5 )
  curl $pix2link -o $IMAGEZIP
  unzip -qq $IMAGEZIP -d image
    ;;
  6 )
  curl $pix2xlink -o $IMAGEZIP
  unzip -qq $IMAGEZIP -d image
    ;;
  7 )
  curl $pixxlink -o $IMAGEZIP
  unzip -qq $IMAGEZIP -d image
    ;;
  8 )
  curl $pixlink -o $IMAGEZIP
  unzip -qq $IMAGEZIP -d image
    ;;
esac

#Bootloader
echo "Unlocking bootloader..."
adb reboot Bootloader
fastboot flashing unlock
echo "Bootloader unlocked!"

#flash
cd image
echo "Flashing Factory Image..."
./flash-all
echo "Factory image flashed!"
cd ..

#Close Bootloader
echo "Closing Bootloader..."
fastboot flashing lock
echo "Bootloader closed!"
echo "SYSTEM UPDATED! REBOOT"
fastboot reboot system
