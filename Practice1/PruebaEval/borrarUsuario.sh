#!/bin/bash
#########################################AUTORES#############################################
# - Raúl Jiménez de la Cruz
# - Pablo Blázquez Sánchez
#############################################################################################
shopt -s dotglob
backup_dir="/usr/backup"
backup_file="${backup_dir}/id"
# Check if the script received exactly one argument
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 nombreUsuario"
    exit 1
fi
home_dir="/home/$1"
uid=$(id -u "$1" 2>/dev/null)
if [ -z "$uid" ]; then
    echo "$1 no existe en el sistema"
    exit 1
fi
gid=$(id -g "$1" 2>/dev/null)
pair="${uid},${gid}"
# Check if the backup resurces exists, if not, create it
if [ ! -d "$backup_dir" ]; then
    echo "Creando $backup_dir..."
    sudo mkdir -p "$backup_dir"
fi
if [ ! -f "$backup_file" ]; then
    echo "Predefiniendo $backup_dir..."
    # tee creates the file if doesn't exist
    echo 0 | sudo tee "$backup_file" > /dev/null
fi
current_idbackup=$(cat $backup_file)
current_backup_dir="${backup_dir}/${current_idbackup}"
if [ ! -d "$current_backup_dir" ]; then
    sudo mkdir -p "${current_backup_dir}"
fi
echo "$pair" | sudo tee "${current_backup_dir}/info" > /dev/null
sudo mkdir -p ${current_backup_dir}/$1/
if [ -d "/mnt/c" ]; then
    # If WSL, avoid /mnt. External drives are assumed to be already secure
    echo "Estás ejecutando en un subsistema de Linux (WSL). Se excluyen por seguridad /mnt/..."   
    sudo find / -path "/mnt/*" -prune -o -type f -uid $uid -exec cp {} ${current_backup_dir}/$1/ \;
else
    # Assuming the hierarchy doesn't matter, so --parents is omitted
    sudo find / -uid $uid -type f -exec cp {} ${current_backup_dir}/$1/ \;
fi
sudo chown -R 9999:9999 "${current_backup_dir}/$1"
echo $((current_idbackup + 1)) | sudo tee "$backup_file" > /dev/null
sudo userdel $1
if [ -d "$home_dir" ]; then
    sudo rm -rf "$home_dir"
fi
