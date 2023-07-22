#!/bin/bash

# Función para mostrar el menú de selección de idioma
function select_language() {
    lang_choice=$(whiptail --title "Selecciona el idioma" --menu "Elige el idioma:" 15 60 7 \
        1 "Español (Argentina)" \
        2 "Español (Bolivia)" \
        3 "Español (Brasil)" \
        4 "Español (Chile)" \
        5 "Español (Colombia)" \
        6 "Español (Costa Rica)" \
        7 "Español (Cuba)" \
        8 "Español (Ecuador)" \
        9 "Español (El Salvador)" \
        10 "Español (Guatemala)" \
        11 "Español (Honduras)" \
        12 "Español (México)" \
        13 "Español (Nicaragua)" \
        14 "Español (Panamá)" \
        15 "Español (Paraguay)" \
        16 "Español (Perú)" \
        17 "Español (Puerto Rico)" \
        18 "Español (República Dominicana)" \
        19 "Español (Uruguay)" \
        20 "Español (Venezuela)" 3>&1 1>&2 2>&3)
    
    case $lang_choice in
        1) set_language "es_AR.UTF-8";;
        2) set_language "es_BO.UTF-8";;
        3) set_language "pt_BR.UTF-8";;
        4) set_language "es_CL.UTF-8";;
        5) set_language "es_CO.UTF-8";;
        6) set_language "es_CR.UTF-8";;
        7) set_language "es_CU.UTF-8";;
        8) set_language "es_EC.UTF-8";;
        9) set_language "es_SV.UTF-8";;
        10) set_language "es_GT.UTF-8";;
        11) set_language "es_HN.UTF-8";;
        12) set_language "es_MX.UTF-8";;
        13) set_language "es_NI.UTF-8";;
        14) set_language "es_PA.UTF-8";;
        15) set_language "es_PY.UTF-8";;
        16) set_language "es_PE.UTF-8";;
        17) set_language "es_PR.UTF-8";;
        18) set_language "es_DO.UTF-8";;
        19) set_language "es_UY.UTF-8";;
        20) set_language "es_VE.UTF-8";;
        *) echo "Opción inválida. Selecciona una opción válida.";;
    esac
}

# Función para configurar el idioma
function set_language() {
    echo "LANG=$1
LC_NUMERIC=$1
LC_TIME=$1
LC_MONETARY=$1
LC_PAPER=$1
LC_NAME=$1
LC_ADDRESS=$1
LC_TELEPHONE=$1
LC_MEASUREMENT=$1
LC_IDENTIFICATION=$1" | sudo tee /etc/default/locale

    echo "La configuración del idioma se ha aplicado."
}

# Función para mostrar el menú de selección de zona horaria
function select_timezone() {
    tz_choice=$(whiptail --title "Selecciona la zona horaria" --menu "Elige la zona horaria:" 20 60 7 \
        1 "Buenos Aires, Argentina" \
        2 "La Paz, Bolivia" \
        3 "São Paulo, Brasil" \
        4 "Santiago, Chile" \
        5 "Bogotá, Colombia" \
        6 "San José, Costa Rica" \
        7 "La Habana, Cuba" \
        8 "Quito, Ecuador" \
        9 "San Salvador, El Salvador" \
        10 "Ciudad de Guatemala, Guatemala" \
        11 "Tegucigalpa, Honduras" \
        12 "Ciudad de México, México" \
        13 "Managua, Nicaragua" \
        14 "Ciudad de Panamá, Panamá" \
        15 "Asunción, Paraguay" \
        16 "Lima, Perú" \
        17 "San Juan, Puerto Rico" \
        18 "Santo Domingo, República Dominicana" \
        19 "Montevideo, Uruguay" \
        20 "Caracas, Venezuela" 3>&1 1>&2 2>&3)
    
    case $tz_choice in
        1) set_timezone "America/Argentina/Buenos_Aires";;
        2) set_timezone "America/La_Paz";;
        3) set_timezone "America/Sao_Paulo";;
        4) set_timezone "America/Santiago";;
        5) set_timezone "America/Bogota";;
        6) set_timezone "America/Costa_Rica";;
        7) set_timezone "America/Havana";;
        8) set_timezone "America/Guayaquil";;
        9) set_timezone "America/El_Salvador";;
        10) set_timezone "America/Guatemala";;
        11) set_timezone "America/Tegucigalpa";;
        12) set_timezone "America/Mexico_City";;
        13) set_timezone "America/Managua";;
        14) set_timezone "America/Panama";;
        15) set_timezone "America/Asuncion";;
        16) set_timezone "America/Lima";;
        17) set_timezone "America/Puerto_Rico";;
        18) set_timezone "America/Santo_Domingo";;
        19) set_timezone "America/Montevideo";;
        20) set_timezone "America/Caracas";;
        *) echo "Opción inválida. Selecciona una opción válida.";;
    esac
}

# Función para configurar la zona horaria
function set_timezone() {
    sudo timedatectl set-timezone $1
    echo "La configuración de la zona horaria se ha aplicado."
}

# Función para deshabilitar el bloqueo de pantalla y suspensión automática
function disable_screen_lock() {
    # Deshabilitar el salvapantallas
    gsettings set org.gnome.desktop.screensaver lock-enabled false

    # Deshabilitar la suspensión automática
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'

    echo "El bloqueo de pantalla y suspensión automática se han deshabilitado."
}

# Ejecutar las funciones
select_language
select_timezone
disable_screen_lock

# Actualizar el sistema
sudo apt update && sudo apt upgrade

echo "La configuración del idioma, zona horaria y bloqueo de pantalla se ha completado."
