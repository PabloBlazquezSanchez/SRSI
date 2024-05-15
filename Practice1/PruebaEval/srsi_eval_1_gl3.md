## Prueba del script
### Prueba para `user01`
Crear usuario <code>user01</code>, con el home en <code>/home/user01</code> de forma que se cree automáticamente el directorio y se copie el contenido del directorio esqueleto

 - Establecer su contraseña de usuario
 - Como <code>user01</code> crear un archivo vacío llamado <code>user01</code> en su carpeta de usuario

```bash
$ sudo useradd -m user01 -d /home/user01 -p $(openssl passwd user01)
$ sudo login user01
$ touch user01
```
---
Ejecutar el script `borrarUsuario` `user01` y mostrar el contenido del directorio `/home` y el contenido de forma recursiva del directorio `/usr/backup`, así como el contenido de los ficheros `/usr/backup/id` e `/usr/backup/idbackup/info` del usuario borrado
#### Contenido `/home/` antes de la ejecución del script
```bash
$ ls /home/
raul  user01
```
#### Ejecución
```bash
$ ./borrarUsuario.sh user01
Creando /usr/backup...
Predefiniendo /usr/backup...
Estás ejecutando en un subsistema de Linux (WSL). Se excluyen por seguridad /mnt/...
find: File system loop detected; ‘/sys/kernel/debug/device_component’ is part of the same file system loop as ‘/sys/kernel/debug’.
find: ‘/proc/90340/task/90340/fdinfo/5’: No such file or directory
find: ‘/proc/90340/fdinfo/6’: No such file or directory
```
#### Contenido `/home/` después de la ejecución del script
```bash
$ ls /home/
raul
```
#### Listado recursivo de `/usr/backup` 
```bash
$ ls -R /usr/backup/
/usr/backup/:
0  id

/usr/backup/0:
info  user01

/usr/backup/0/user01:
user01
$ cat /usr/backup/id
1
$ cat /usr/backup/0/info
1001,1001
```
---
Crear de nuevo usuario `user01`, con el home en `/home/user01` de forma que se cree automáticamente el directorio y se copie el contenido del directorio esqueleto

 - Establecer su contraseña de usuario
 - Como `user01` crear un archivo vacío llamado `nuevoUser01` en su carpeta de usuario

```bash
$ sudo useradd -m user01 -d /home/user01 -p $(openssl passwd user01)
$ sudo login user01
$ touch nuevoUser01
```
---
 Ejecutar el script `borrarUsuario` `user01` y mostrar el contenido del directorio `/home` y el contenido de forma recursiva del directorio `/usr/backup`, así como el contenido de los ficheros `/usr/backup/id` e `/usr/backup/idbackup/info` del usuario borrado

```bash
$ ./borrarUsuario.sh user01
Estás ejecutando en un subsistema de Linux (WSL). Se excluyen por seguridad /mnt/...
find: File system loop detected; ‘/sys/kernel/debug/device_component’ is part of the same file system loop as ‘/sys/kernel/debug’.
find: ‘/proc/97298/task/97298/fdinfo/5’: No such file or directory
find: ‘/proc/97298/fdinfo/6’: No such file or directory
$ ls /home/
raul
ls -R /usr/backup/
/usr/backup/:
0  1  id

/usr/backup/0:
info  user01

/usr/backup/0/user01:
user01

/usr/backup/1:
info  user01

/usr/backup/1/user01:
nuevoUser01
cat /usr/backup/id
2
cat /usr/backup/1/info
1001,1001
```
> El uid sale 1001 porque es el siguiente a raul y no existían otros usuarios antes
### Prueba para `user02`
Crear usuario <code>user02</code>, con el home en <code>/home/user02</code> de forma que se cree automáticamente el directorio y se copie el contenido del directorio esqueleto

 - Establecer su contraseña de usuario
 - Como <code>user02</code> crear un archivo vacío llamado <code>user02</code> en su carpeta de usuario

```bash
useradd -m user02 -d /home/user01 -p $(openssl passwd user02)
sudo login user02
touch user02
```
---
> :warning: **La prueba del script para `user02` es exactamente igual para `user01`**