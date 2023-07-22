#!/bin/bash

# Función para verificar e instalar el paquete dialog si es necesario
check_and_install_dialog() {
    if ! dpkg -s dialog &> /dev/null; then
        echo "El paquete dialog no está instalado. Instalándolo..."
        sudo apt-get update
        sudo apt-get install -y dialog
    fi
}

# Función para cambiar la distribución del teclado al español (Latinoamérica)
change_keyboard_layout() {
    setxkbmap -layout latam
    clear
    echo -e ""
    echo -e "\e[48;5;128m\e[97mLa distribución del teclado se ha cambiado al español (Latinoamérica).\e[0m"
    echo -e ""
}

# Llamar a la función para verificar e instalar el paquete dialog
check_and_install_dialog

# Mostrar el menú con dialog
dialog --backtitle "Cambiar la distribución del teclado al español" \
--title "Configuración del teclado" \
--yesno "¿Deseas cambiar la distribución del teclado al español (Latinoamérica)?" 8 60

# Capturar el código de salida de dialog
response=$?

# Analizar la respuesta del usuario
case $response in
    0)  # Si el usuario elige "Sí"
        change_keyboard_layout
        ;;
    1)  # Si el usuario elige "No" o presiona 'Esc'
        echo "No se realizaron cambios en la distribución del teclado."
        ;;
    255) # Si el usuario presiona 'Ctrl + C' o cierra la ventana de dialog
        echo "Operación cancelada por el usuario."
        ;;
esac
