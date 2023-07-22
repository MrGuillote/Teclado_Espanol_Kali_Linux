# Teclado_Espanol_Kali_Linux

Este es un script con interfaz hecho específicamente para configurar el teclado LATAM y la zona horaria en Kali Linux. Proporciona una selección de idiomas y zonas horarias para adaptar el sistema al país correspondiente. + un plus para usar en maquinas virtuales "opcional"

## Instrucciones de uso

Clona el repositorio usando el siguiente comando:

 `git clone https://github.com/MrGuillote/Teclado_Espanol_Kali_Linux.git`

Da permisos de ejecución al script "de ser necesario": 

`chmod +x Teclado_Espanol_Kali_Linux/teclado-kali-es.sh`

Ejecuta el script con privilegios de administrador: 

`sudo ./Teclado_Espanol_Kali_Linux/teclado-kali-es.sh`

## Requisitos

- Kali Linux instalado en tu sistema.
- [whiptail](https://linux.die.net/man/1/whiptail) debe estar instalado para la interfaz gráfica del script que por lo general ya viene instalado en las imagenes de Kali.

## Funcionamiento

El script te mostrará una interfaz de menú donde podrás seleccionar el idioma y la zona horaria correspondientes a tu país (en AMERICA LATAM). Una vez que hagas las seleccion, el script configurará el idioma y la zona horaria en tu sistema automáticamente, Tambien añadi la opcion que no se bloquee mas Kali cada un cierto tiempo (opcional) ya que es habitual el bloqueo constante en las maquinas virtuales

## Captura de pantalla

_![image](https://github.com/MrGuillote/Teclado_Espanol_Kali_Linux/assets/89352244/e9596569-875e-401f-8fbe-d589767f247d)_
![image](https://github.com/MrGuillote/Teclado_Espanol_Kali_Linux/assets/89352244/3c2531f8-aee0-44d6-9712-78540c56837e)
![image](https://github.com/MrGuillote/Teclado_Espanol_Kali_Linux/assets/89352244/473a7d5c-df86-4850-a892-6c3441ec4b67)
![image](https://github.com/MrGuillote/Teclado_Espanol_Kali_Linux/assets/89352244/6b3f1b9e-09f5-46b0-afbf-d130ac3449d1)



## Idiomas y Zonas Horarias Disponibles

El script ofrece la posibilidad de seleccionar entre varios idiomas y zonas horarias de América Latina:

- Español (Argentina)
- Español (Bolivia)
- Portugués (Brasil)
- Español (Chile)
- Español (Colombia)
- Español (Costa Rica)
- Español (Cuba)
- Español (Ecuador)
- Español (El Salvador)
- Español (Guatemala)
- Español (Honduras)
- Español (México)
- Español (Nicaragua)
- Español (Panamá)
- Español (Paraguay)
- Español (Perú)
- Español (Puerto Rico)
- Español (República Dominicana)
- Español (Uruguay)
- Español (Venezuela)

## Licencia

_no tiene lincencia porque basicamente es un script en bash._

## Final

_ _

---

¡Gracias por usar Teclado_Espanol_Kali_Linux! Si tienes alguna pregunta o encuentras algún problema, no dudes en abrir un issue en el repositorio.
