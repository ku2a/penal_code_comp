Para poder editar el contenido de github:
```shell
cd /carpeta_vuestra
git clone https://github.com/ku2a/penal_code_comp
cd penal_code_comp
```

Cuando alguien cambia algo podeis actualizar vuestra carpeta local con
```shell
git pull
```
cuando termineis comprobais los cambios que habeis hecho con
```shell
git status
```
y para enviarlo haceis
```shell
git add .
git commit -m "comentario de lo que he hecho y qn soy"
git push
```
Dentro de las dependencias aparece el modulo tidyverse,rvest encontré problemas
a la hora de la instalacion. Si aparece error del tipo:
failed to find one of freetype2 libpng libtiff-4 libjpeg. Try installing:
 * deb: libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev (Debian, Ubuntu, etc)
 * rpm: freetype-devel libpng-devel libtiff-devel libjpeg-devel (Fedora, CentOS, RHEL)
 * csw: libfreetype_dev libpng16_dev libtiff_dev libjpeg_dev (Solaris)
If freetype2 libpng libtiff-4 libjpeg is already installed, check that 'pkg-config' is in your
PATH and PKG_CONFIG_PATH contains a freetype2 libpng libtiff-4 libjpeg.pc file.

Podeis buscar cual de ellos falta:
```shell
find / -name "nombre del modulo" 2>/dev/null
```
donde sustituís el nombre con cada uno de los mencionados en el error. Si no
os aparece nada es que ese modulo no esta instalado, podeis instalarlo con
```shell
sudo apt-get install (nombre del modulo)
```
