#!/bin/bash

# Función para verificar e instalar dialog si no está presente
check_and_install_dialog() {
    if ! dpkg -s dialog &> /dev/null; then
        echo "Instalando 'dialog'..."
        sudo apt update && sudo apt install -y dialog
    fi
}

# Cambiar idioma y teclado al español
set_language_and_keyboard() {
    echo "🌍 Configurando idioma y teclado a Español..."

    # Idioma del sistema
    sudo sed -i 's/^LANG=.*/LANG=es_ES.UTF-8/' /etc/default/locale
    sudo locale-gen es_ES.UTF-8

    # Teclado
    setxkbmap -layout latam

    echo -e "\n✅ Idioma y teclado configurados a español (Latinoamérica)"
}

# Activar inicio de sesión automático (autologin)
enable_autologin() {
    local LIGHTDM_CONF="/etc/lightdm/lightdm.conf"
    local USER_NAME=$(whoami)

    echo "🔐 Activando autologin para $USER_NAME..."

    if [ "$EUID" -ne 0 ]; then
        echo "⚠️  Este paso requiere permisos de root. Usá: sudo ./kali-tweaks-es.sh"
        return
    fi

    if grep -q "\[Seat:\*\]" "$LIGHTDM_CONF"; then
        sed -i "/^\[Seat:\*\]/a autologin-user=$USER_NAME\nautologin-user-timeout=0" "$LIGHTDM_CONF"
    else
        echo -e "\n[Seat:*]\nautologin-user=$USER_NAME\nautologin-user-timeout=0" | sudo tee -a "$LIGHTDM_CONF" > /dev/null
    fi

    echo "✅ Autologin activado"
}

# Permitir sudo sin contraseña
disable_sudo_password() {
    local USER_NAME=$(whoami)
    local SUDOERS_FILE="/etc/sudoers.d/$USER_NAME-nopasswd"

    echo "⚙️  Quitando contraseña para 'sudo'..."
    echo "$USER_NAME ALL=(ALL) NOPASSWD: ALL" | sudo tee "$SUDOERS_FILE" > /dev/null
    sudo chmod 0440 "$SUDOERS_FILE"
    echo "✅ Ya podés usar 'sudo' sin escribir la contraseña"
}

# Quitar contraseña de root
disable_root_password() {
    echo "🛑 Eliminando contraseña de root (¡cuidado!)"
    sudo passwd -d root
    echo "✅ Ahora podés hacer 'sudo su' sin contraseña"
}

# Mostrar menú principal con estilo
main_menu() {
    dialog --backtitle "🎛️  Kali Linux Post-Instalación" \
    --title "🔥 Asistente de configuración express - Kali VM 🔥" \
    --checklist "Seleccioná lo que querés configurar:\n\n(✔️ Recomendado en VMs descargadas desde kali.org)\n" 20 70 6 \
    1 "🌍 Cambiar idioma y teclado a español" on \
    2 "🔐 Activar autologin (inicio sin contraseña)" on \
    3 "⚙️  Quitar contraseña al usar sudo" on \
    4 "🛑 Quitar contraseña para sudo su (root)" off \
    5 "❌ Salir sin hacer cambios" off 2> opciones.txt

    # Cancelado o cerrado con Esc
    if [ $? -ne 0 ]; then
        echo -e "\n❌ Operación cancelada por el usuario."
        rm -f opciones.txt
        exit 1
    fi

    choices=$(<opciones.txt)
    rm -f opciones.txt

    clear
    echo -e "\n🛠️  Aplicando configuración seleccionada...\n"

    for opcion in $choices; do
        case $opcion in
            1) set_language_and_keyboard ;;
            2) enable_autologin ;;
            3) disable_sudo_password ;;
            4) disable_root_password ;;
            5) echo "🚪 Saliendo sin hacer cambios"; exit 0 ;;
        esac
    done

    echo -e "\n💡 Estos cambios funcionan bien en imágenes oficiales de Kali:"
    echo "   👉 https://www.kali.org/get-kali/#kali-virtual-machines"
    echo -e "\n🔁 Reiniciá tu VM para aplicar los cambios completamente.\n"
}

# Ejecutar
check_and_install_dialog
main_menu
