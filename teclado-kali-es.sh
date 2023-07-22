#!/bin/bash

# Función para mostrar el menú de selección de idioma
function select_language() {
    # El código de selección de idioma se mantiene igual
    # ...
}

# Función para configurar el idioma
function set_language() {
    # El código para configurar el idioma se mantiene igual
    # ...
}

# Función para mostrar el menú de selección de zona horaria
function select_timezone() {
    # El código de selección de zona horaria se mantiene igual
    # ...
}

# Función para configurar la zona horaria
function set_timezone() {
    # El código para configurar la zona horaria se mantiene igual
    # ...
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
