#!/bin/bash

server='https://papermc.io/api/v1/paper/1.16.5/latest/download'
plugins=(
    'https://github.com/monun/kotlin-plugin/releases/latest/download/Kotlin-1.5.10.jar'
    'https://github.com/monun/auto-update/releases/latest/download/AutoUpdate.jar'
    'https://media.forgecdn.net/files/3237/689/worldedit-bukkit-7.2.4.jar'
)

script=$(basename "$0")
server_folder=".${script%.*}"
mkdir -p "$server_folder"

server_script="server"
server_config="server.conf.json"

if [ ! -f "$server_folder/$server_script" ]; then
  if [ -f ".server/$server_script" ]; then
    cp ".server/$server_script" "$server_folder/$server_script"
  else
    wget -qc -P "$server_folder" -N 'https://github.com/aroxu/server-script/releases/latest/download/server_linux_x64.zip'
    unzip "${server_folder}/server_linux_x64.zip" -d "$server_folder"
  fi
fi

cd "$server_folder"

if [ ! -f "$server_config" ]; then
    cat << EOF > $server_config
{
  "server": "$server",
  "debug": true,
  "debug_port": 5005,
  "backup": true,
  "restart": true,
  "memory": 2,
  "plugins": [
EOF
    for plugin in "${plugins[@]}"
    do
        echo "    \"$plugin\"," >> $server_config
    done
    # shellcheck disable=SC2129
    echo "    \"https://github.com/dmulloy2/ProtocolLib/releases/latest/download/ProtocolLib.jar\"" >> $server_config
    echo "  ]" >> $server_config
    echo "}" >> $server_config
fi

chmod +x ./$server_script
./$server_script
