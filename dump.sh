#!/bin/bash

BIN=$1
if [ -z "$1" ]; then
  echo "Error: no folder was specified with data to dump"
  exit 1
fi

# Platform detection
if [[ ! -f "$BIN/ETC/WARNING.EMI" && ! -f "$BIN/ETC/CAPLOGO.EMI" ]]; then
  PLATFORM="USA"
elif [[ -f "$BIN/ETC/WARNING.EMI" ]]; then
  PLATFORM="PAL"
elif [[ -f "$BIN/ETC/CAPLOGO.EMI" ]]; then
  PLATFORM="PSP"
fi

echo "Platform detected: $PLATFORM"

BIN_DUMP_COMMANDS_PAL=(
  "python bof3tool.py rawdump -i UNPACKED/$BIN/BATTLE/BATTLE/BATTLE.4.bin -o DUMP/$BIN/BINARY/BATTLE.4.bin.atk_abl_use.json --offset 0x1A2B0 --quantity 4 --skip 4 --repeat 7 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/BATTLE/BATTLE/BATTLE.4.bin -o DUMP/$BIN/BINARY/BATTLE.4.bin.attack.json --offset 0x1A400 --quantity 12 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/BATTLE/BATTLE/BATTLE.4.bin -o DUMP/$BIN/BINARY/BATTLE.4.bin.examine.json --offset 0x1A41A --quantity 12 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/BATTLE/BATTLE/BATTLE.4.bin -o DUMP/$BIN/BINARY/BATTLE.4.bin.defend_charge_reprisal.json --offset 0x1A434 --quantity 12 --skip 1 --repeat 8 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/BOSS/BOSS025/BOSS025.14.bin -o DUMP/$BIN/BINARY/BOSS025.14.bin.turns_left.json --offset 0x1AD4 --quantity 12 --repeat 2 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/ETC/COMMU00/COMMU00.1.bin -o DUMP/$BIN/BINARY/COMMU00.1.bin.names.json --offset 0x3B00 --quantity 5 --skip 4 --repeat 60 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/ETC/COMMU01/COMMU01.8.bin -o DUMP/$BIN/BINARY/COMMU01.8.bin.common.json --offset 0x40A8 --quantity 8 --repeat 20 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/ETC/COMMU05/COMMU05.8.bin -o DUMP/$BIN/BINARY/COMMU05.8.bin.faeries.json --offset 0xD5C --quantity 8 --repeat 4 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/ETC/GAME/GAME.1.bin -o DUMP/$BIN/BINARY/GAME.1.bin.menu.json --offset 0x324B8 --quantity 8 --repeat 5 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/ETC/GAME/GAME.1.bin -o DUMP/$BIN/BINARY/GAME.1.bin.items.json --offset 0x331E8 --quantity 12 --skip 6 --repeat 92 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/ETC/GAME/GAME.1.bin -o DUMP/$BIN/BINARY/GAME.1.bin.key_items.json --offset 0x33860 --quantity 12 --skip 4 --repeat 16 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/ETC/GAME/GAME.1.bin -o DUMP/$BIN/BINARY/GAME.1.bin.weapons.json --offset 0x33960 --quantity 12 --skip 12 --repeat 83 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/ETC/GAME/GAME.1.bin -o DUMP/$BIN/BINARY/GAME.1.bin.armors.json --offset 0x34128 --quantity 12 --skip 10 --repeat 68 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/ETC/GAME/GAME.1.bin -o DUMP/$BIN/BINARY/GAME.1.bin.accessories.json --offset 0x34700 --quantity 12 --skip 8 --repeat 52 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/ETC/GAME/GAME.1.bin -o DUMP/$BIN/BINARY/GAME.1.bin.abilities.json --offset 0x34FA4 --quantity 12 --skip 8 --repeat 227 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/BMAGIC/MAGIC060/MAGIC060.1.bin -o DUMP/$BIN/BINARY/MAGIC060.1.bin.weak_exp_item.json --offset 0x1F64 --quantity 8 --repeat 5 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/SCENARIO/SCENA10/SCENA10.1.bin -o DUMP/$BIN/BINARY/SCENA10.1.bin.choose_parts.json --offset 0x7C74 --quantity 12 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/ETC/SISYOU/SISYOU.1.bin -o DUMP/$BIN/BINARY/SISYOU.1.bin.pwr_def_int.json --offset 0x3438 --quantity 4 --repeat 7 --trim"
)

BIN_DUMP_COMMANDS_USA=(
  "python bof3tool.py rawdump -i UNPACKED/$BIN/BATTLE/BATTLE/BATTLE.4.bin -o DUMP/$BIN/BINARY/BATTLE.4.bin.atk_abl_use.json --offset 0x1A2B0 --quantity 4 --skip 4 --repeat 7 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/BATTLE/BATTLE/BATTLE.4.bin -o DUMP/$BIN/BINARY/BATTLE.4.bin.attack.json --offset 0x1A400 --quantity 12 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/BATTLE/BATTLE/BATTLE.4.bin -o DUMP/$BIN/BINARY/BATTLE.4.bin.examine.json --offset 0x1A41A --quantity 12 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/BATTLE/BATTLE/BATTLE.4.bin -o DUMP/$BIN/BINARY/BATTLE.4.bin.defend_charge_reprisal.json --offset 0x1A434 --quantity 12 --skip 1 --repeat 8 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/BOSS/BOSS025/BOSS025.14.bin -o DUMP/$BIN/BINARY/BOSS025.14.bin.turns_left.json --offset 0x1AA8 --quantity 12 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/ETC/COMMU00/COMMU00.1.bin -o DUMP/$BIN/BINARY/COMMU00.1.bin.names.json --offset 0x3B00 --quantity 5 --skip 4 --repeat 60 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/ETC/COMMU01/COMMU01.8.bin -o DUMP/$BIN/BINARY/COMMU01.8.bin.common.json --offset 0x4134 --quantity 8 --repeat 20 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/ETC/COMMU05/COMMU05.8.bin -o DUMP/$BIN/BINARY/COMMU05.8.bin.faeries.json --offset 0xD5C --quantity 8 --repeat 4 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/ETC/GAME/GAME.1.bin -o DUMP/$BIN/BINARY/GAME.1.bin.menu.json --offset 0x32434 --quantity 8 --repeat 5 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/ETC/GAME/GAME.1.bin -o DUMP/$BIN/BINARY/GAME.1.bin.items.json --offset 0x33164 --quantity 12 --skip 6 --repeat 92 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/ETC/GAME/GAME.1.bin -o DUMP/$BIN/BINARY/GAME.1.bin.key_items.json --offset 0x337DC --quantity 12 --skip 4 --repeat 16 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/ETC/GAME/GAME.1.bin -o DUMP/$BIN/BINARY/GAME.1.bin.weapons.json --offset 0x338DC --quantity 12 --skip 12 --repeat 83 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/ETC/GAME/GAME.1.bin -o DUMP/$BIN/BINARY/GAME.1.bin.armors.json --offset 0x340A4 --quantity 12 --skip 10 --repeat 68 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/ETC/GAME/GAME.1.bin -o DUMP/$BIN/BINARY/GAME.1.bin.accessories.json --offset 0x3467C --quantity 12 --skip 8 --repeat 52 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/ETC/GAME/GAME.1.bin -o DUMP/$BIN/BINARY/GAME.1.bin.abilities.json --offset 0x34F20 --quantity 12 --skip 8 --repeat 227 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/BMAGIC/MAGIC060/MAGIC060.1.bin -o DUMP/$BIN/BINARY/MAGIC060.1.bin.weak_exp_item.json --offset 0x1F64 --quantity 8 --repeat 5 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/SCENARIO/SCENA10/SCENA10.1.bin -o DUMP/$BIN/BINARY/SCENA10.1.bin.choose_parts.json --offset 0x7C74 --quantity 12 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/ETC/SISYOU/SISYOU.1.bin -o DUMP/$BIN/BINARY/SISYOU.1.bin.pwr_def_int.json --offset 0x3438 --quantity 4 --repeat 7 --trim"
)

BIN_DUMP_COMMANDS_PSP=(
  "python bof3tool.py rawdump -i UNPACKED/$BIN/ETC/GAME/GAME.1.bin -o DUMP/$BIN/BINARY/GAME.1.bin.item_weapon_armor.json --offset 0x3242C --quantity 8 --repeat 4 --trim"
  "python bof3tool.py rawdump -i UNPACKED/$BIN/BMAGIC/MAGIC060/MAGIC060.1.bin -o DUMP/$BIN/BINARY/MAGIC060.1.bin.weak_exp_item.json --offset 0x1F00 --quantity 8 --repeat 5 --trim"
)

BIN_TO_EDIT="BATTLE/BATTLE/BATTLE.16.bin
BMAGIC/MAGIC003/MAGIC003.4.bin
ETC/BATE/BATE.1.bin
ETC/COMMU02/COMMU02.9.bin
ETC/COMMU03/COMMU03.7.bin
ETC/SHISU/SHISU.1.bin
ETC/SHOP/SHOP.1.bin
ETC/START/START.9.bin
SCENARIO/SCENA17/SCENA17.1.bin
WORLD00/AREA030/AREA030.5.bin"

ENEMIES_TO_DUMP="WORLD00/AREA002/AREA002.14.bin
WORLD00/AREA003/AREA003.11.bin
WORLD00/AREA005/AREA005.11.bin
WORLD00/AREA008/AREA008.11.bin
WORLD00/AREA009/AREA009.11.bin
WORLD00/AREA010/AREA010.11.bin
WORLD00/AREA011/AREA011.11.bin
WORLD00/AREA012/AREA012.11.bin
WORLD00/AREA015/AREA015.11.bin
WORLD00/AREA018/AREA018.11.bin
WORLD00/AREA019/AREA019.11.bin
WORLD00/AREA020/AREA020.11.bin
WORLD00/AREA022/AREA022.11.bin
WORLD00/AREA023/AREA023.11.bin
WORLD00/AREA026/AREA026.11.bin
WORLD00/AREA027/AREA027.11.bin
WORLD00/AREA028/AREA028.11.bin
WORLD00/AREA032/AREA032.11.bin
WORLD00/AREA035/AREA035.11.bin
WORLD01/AREA040/AREA040.11.bin
WORLD01/AREA041/AREA041.11.bin
WORLD01/AREA042/AREA042.11.bin
WORLD01/AREA043/AREA043.11.bin
WORLD01/AREA044/AREA044.11.bin
WORLD01/AREA048/AREA048.11.bin
WORLD01/AREA051/AREA051.11.bin
WORLD01/AREA052/AREA052.11.bin
WORLD01/AREA054/AREA054.11.bin
WORLD01/AREA056/AREA056.11.bin
WORLD01/AREA067/AREA067.11.bin
WORLD01/AREA069/AREA069.11.bin
WORLD01/AREA071/AREA071.11.bin
WORLD01/AREA075/AREA075.11.bin
WORLD02/AREA077/AREA077.11.bin
WORLD02/AREA079/AREA079.11.bin
WORLD02/AREA080/AREA080.11.bin
WORLD02/AREA081/AREA081.11.bin
WORLD02/AREA082/AREA082.11.bin
WORLD02/AREA083/AREA083.11.bin
WORLD02/AREA085/AREA085.11.bin
WORLD02/AREA086/AREA086.11.bin
WORLD02/AREA091/AREA091.11.bin
WORLD02/AREA092/AREA092.11.bin
WORLD02/AREA095/AREA095.11.bin
WORLD02/AREA096/AREA096.11.bin
WORLD02/AREA099/AREA099.11.bin
WORLD02/AREA103/AREA103.11.bin
WORLD02/AREA105/AREA105.11.bin
WORLD02/AREA107/AREA107.11.bin
WORLD02/AREA108/AREA108.11.bin
WORLD02/AREA111/AREA111.11.bin
WORLD02/AREA112/AREA112.11.bin
WORLD03/AREA117/AREA117.11.bin
WORLD03/AREA118/AREA118.11.bin
WORLD03/AREA119/AREA119.11.bin
WORLD03/AREA120/AREA120.11.bin
WORLD03/AREA134/AREA134.11.bin
WORLD03/AREA135/AREA135.11.bin
WORLD03/AREA136/AREA136.11.bin
WORLD03/AREA140/AREA140.11.bin
WORLD03/AREA141/AREA141.11.bin
WORLD03/AREA142/AREA142.11.bin
WORLD03/AREA144/AREA144.11.bin
WORLD03/AREA145/AREA145.11.bin
WORLD04/AREA164/AREA164.11.bin
WORLD04/AREA165/AREA165.11.bin
WORLD04/AREA166/AREA166.11.bin
WORLD04/AREA167/AREA167.11.bin
WORLD04/AREA168/AREA168.11.bin
WORLD04/AREA169/AREA169.11.bin
WORLD04/AREA170/AREA170.11.bin
WORLD04/AREA171/AREA171.11.bin
WORLD04/AREA172/AREA172.11.bin
WORLD04/AREA173/AREA173.11.bin
WORLD04/AREA175/AREA175.11.bin
WORLD04/AREA188/AREA188.11.bin
WORLD04/AREA196/AREA196.11.bin
WORLD04/AREA197/AREA197.11.bin
WORLD04/AREA198/AREA198.11.bin"

GFX_TO_REMOVE="AREA030.21.bin.4b.128w.128x32.256r.bmp
AREA089.21.bin.4b.128w.128x32.256r.bmp
AREA129.21.bin.4b.128w.128x32.256r.bmp
AREA152.6.bin.8b.64w.64x32.1024r.bmp
COMMU01.1.bin.4b.128w.128x32.256r.bmp
COMMU02B.1.bin.4b.128w.128x32.256r.bmp
COMMU05.1.bin.4b.128w.128x32.256r.bmp
MAGIC013.5.bin.4b.128w.128x32.256r.bmp
MAGIC038.8.bin.4b.128w.128x32.256r.bmp
MAGIC039.5.bin.4b.128w.128x32.256r.bmp
MAGIC040.5.bin.4b.128w.128x32.256r.bmp
MAGIC043.5.bin.4b.128w.128x32.256r.bmp
MAGIC062.5.bin.4b.128w.128x32.256r.bmp
MAGIC069.5.bin.4b.128w.128x32.256r.bmp
MAGIC082.5.bin.4b.128w.128x32.256r.bmp
MAGIC083.5.bin.4b.128w.128x32.256r.bmp
MAGIC088.5.bin.4b.128w.128x32.256r.bmp
MAGIC225.5.bin.4b.128w.128x32.256r.bmp
SHISU.2.bin.4b.128w.128x32.256r.bmp
SHOP.2.bin.4b.128w.128x32.256r.bmp
SISYOU.2.bin.4b.128w.128x32.256r.bmp
START.4.bin.4b.128w.128x32.256r.bmp
STATUS.2.bin.4b.128w.128x32.256r.bmp
TURIMODE.4.bin.4b.128w.128x32.256r.bmp
TURISHAR.2.bin.8b.64w.64x32.256r.bmp
TURISHAR.3.bin.8b.64w.64x32.256r.bmp"

# Removes folders that do not contain text/graphics to be translated
dirs_to_delete="BENEMY BGM BMAG_XA BPLCHAR PLCHAR SCE_XA MODULE PSMF"

for dir in $dirs_to_delete; do
  if [ -d "$BIN/$dir" ]; then
    echo "Removing unused folder $dir"...
    rm -rf "$BIN/$dir"
  fi
done

# Remove all unused files
files_to_delete="dummy.bin AREA006.EMI
AREA025.EMI
AREA029.EMI
AREA036.EMI
AREA063.EMI
AREA064.EMI
AREA070.EMI
AREA072.EMI
AREA073.EMI
AREA076.EMI
AREA084.EMI
AREA093.EMI
AREA102.EMI
AREA106.EMI
AREA109.EMI
AREA110.EMI
AREA124.EMI
AREA125.EMI
AREA127.EMI
AREA137.EMI
AREA138.EMI
AREA139.EMI
AREA146.EMI
AREA156.EMI
AREA158.EMI
AREA159.EMI
AREA160.EMI
AREA161.EMI
AREA162.EMI
AREA163.EMI
AREA190.EMI"

echo "Removing all unused files if exists..."
for file in $files_to_delete; do
  find $BIN -name "$file" -delete
done
echo "Done"

# Unpack all EMI files
echo "Unpacking all EMI files..."
for dir in $BIN/*/
do
    dir=${dir%*/}
    if [ -d "$dir" ] && [ -n "$(find "$dir" -name '*.EMI' -print -quit)" ]; then
        python bof3tool.py unpack -i $dir/*.EMI -o UNPACKED/$dir --dump-text --dump-graphic
    fi
done
echo "Done"

# Move all text dumps of WORLD in the DUMP/platform/WORLD folder
mkdir -p DUMP/$BIN/WORLD
echo "Moving all WORLD JSON files..."
for world in WORLD00 WORLD01 WORLD02 WORLD03 WORLD04; do
  find UNPACKED/$BIN/$world/ -name "*.bin.json" -execdir sh -c "mv -v \$1 ../../../../DUMP/$BIN/WORLD" sh {} \;
done
echo "Done"

# Move all text dumps of MENU in the DUMP/platform/MENU folder
mkdir -p DUMP/$BIN/MENU
echo "Moving all MENU JSON files..."
for menu in BATTLE BOSS ETC; do
  find UNPACKED/$BIN/$menu/ -name "*.bin.json" -execdir sh -c "mv -v \$1 ../../../../DUMP/$BIN/MENU" sh {} \;
done
echo "Done"

# Raw Dump and move all enemies names from binary files to DUMP/platform/ENEMIES folder
mkdir -p DUMP/$BIN/ENEMIES
echo "Dumping and moving all ENEMY JSON files..."
while read -r file; do
  if [ -f "UNPACKED/$BIN/$file" ]; then
    python bof3tool.py rawdump -i UNPACKED/$BIN/$file --offset 0x48 --quantity 8 --skip 128 --repeat 8 --trim
    mv -v UNPACKED/$BIN/$file.json DUMP/$BIN/ENEMIES
  fi
done <<< "$ENEMIES_TO_DUMP"
echo "Done"

# Raw Dump of all binary files to DUMP/platform/BINARY folder
echo "Raw Dumping all BINARY files ($PLATFORM)..."
if [ $PLATFORM == "PAL" ]; then
  for cmd in "${BIN_DUMP_COMMANDS_PAL[@]}"; do
    $cmd
  done
elif [ $PLATFORM == "USA" ]; then
  for cmd in "${BIN_DUMP_COMMANDS_USA[@]}"; do
    $cmd
  done
elif [ $PLATFORM == "PSP" ]; then
  for cmd in "${BIN_DUMP_COMMANDS_PSP[@]}"; do
    $cmd
  done
fi
echo "Done"

# Move all graphics files to GFX/platform folder
mkdir -p GFX/$BIN
echo "Moving all GFX files..."
find "UNPACKED/$BIN/" -name "*.bmp" -exec mv -v {} "GFX/$BIN" \;
echo "Done"

# Remove all duplicated graphics
echo "Removing all duplicated GFX files..."
while read -r file; do
  if [ -f "GFX/$BIN/$file" ]; then
    rm -v GFX/$BIN/$file
  fi
done <<< "$GFX_TO_REMOVE"
echo "Done"

# Copy binary files to be manual edited
mkdir -p BINARY/$BIN
echo "Copying all BINARY files..."
while read -r file; do
  if [ -f "UNPACKED/$BIN/$file" ]; then
    cp -v UNPACKED/$BIN/$file BINARY/$BIN
  fi
done <<< "$BIN_TO_EDIT"
echo "Done"

# Create the folders of files to be injected (before/after raw reinsert)
mkdir -p INJECT/$BIN/BEFORE_REINSERT
mkdir -p INJECT/$BIN/AFTER_REINSERT

echo "Indexing WORLD, MENU and ENEMIES dumps..."

# Index all dumps into DUMP/platform/WORLD and remove old duplicated files
python bof3tool.py index -i DUMP/$BIN/WORLD/*.json --output-strings DUMP/$BIN/dump_world.json --output-pointers DUMP/$BIN/pointers_world.json
rm -rf DUMP/$BIN/WORLD

# Index all dumps into DUMP/platform/MENU and remove old duplicated files
python bof3tool.py index -i DUMP/$BIN/MENU/*.json --output-strings DUMP/$BIN/dump_menu.json --output-pointers DUMP/$BIN/pointers_menu.json
rm -rf DUMP/$BIN/MENU

# Index all dumps into DUMP/platform/ENEMIES and remove old duplicated files
python bof3tool.py index -i DUMP/$BIN/ENEMIES/*.json --output-strings DUMP/$BIN/dump_enemies.json --output-pointers DUMP/$BIN/pointers_enemies.json
rm -rf DUMP/$BIN/ENEMIES

echo "Done"