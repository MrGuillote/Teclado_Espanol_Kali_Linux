#!/bin/bash

# Función para verificar conectividad antes de usar apt
check_connectivity() {
    echo "🌐 Verificando conectividad a internet..."
    if ! ping -c 1 1.1.1.1 &> /dev/null; then
        echo "❌ No hay conexión a internet. Algunas funciones podrían fallar."
        return 1
    fi
    echo "✅ Conexión OK"
    return 0
}

# Función para verificar e instalar dialog si no está presente
check_and_install_dialog() {
    if ! dpkg -s dialog &> /dev/null; then
        echo "📦 'dialog' no está instalado. Intentando instalar..."
        if check_connectivity; then
            sudo apt update && sudo apt install -y dialog
        else
            echo "⚠️ No se puede instalar 'dialog' sin conexión. Abortando."
            exit 1
        fi
    fi
}

# Cambiar idioma y teclado a español (permanente y condicional)
set_language_and_keyboard() {
    echo "🌍 Configurando idioma y teclado a Español..."

    # Teclado actual
    current_layout=$(grep XKBLAYOUT /etc/default/keyboard | cut -d= -f2 | tr -d '"')
    if [[ "$current_layout" != "latam" ]]; then
        echo "🧠 Aplicando teclado 'latam'..."
        sudo sed -i 's/^XKBLAYOUT=.*/XKBLAYOUT="latam"/' /etc/default/keyboard || echo 'XKBLAYOUT="latam"' | sudo tee -a /etc/default/keyboard
        sudo dpkg-reconfigure -f noninteractive keyboard-configuration
        setxkbmap -layout latam
    else
        echo "✅ El teclado ya está configurado como 'latam'"
    fi

    # Idioma actual
    current_lang=$(grep LANG /etc/default/locale | cut -d= -f2)
    if [[ "$current_lang" != "es_ES.UTF-8" ]]; then
        echo "🧠 Aplicando idioma 'es_ES.UTF-8'..."
        sudo sed -i 's/^LANG=.*/LANG=es_ES.UTF-8/' /etc/default/locale
        echo 'LANG=es_ES.UTF-8' | sudo tee /etc/locale.conf
        sudo locale-gen es_ES.UTF-8
        sudo update-locale LANG=es_ES.UTF-8
    else
        echo "✅ El idioma ya está configurado como 'es_ES.UTF-8'"
    fi

    echo -e "\n✅ Idioma y teclado listos en español (Latinoamérica)"
}

# Activar inicio de sesión automático (autologin)
enable_autologin() {
    local LIGHTDM_CONF="/etc/lightdm/lightdm.conf"
    local BACKUP="/etc/lightdm/lightdm.conf.bak"
    local USER_NAME=$(whoami)

    echo "🔐 Configurando autologin para '$USER_NAME'..."

    if [ "$EUID" -ne 0 ]; then
        echo "⚠️ Este paso requiere permisos de root."
        return
    fi

    # Backup
    if [ ! -f "$BACKUP" ]; then
        sudo cp "$LIGHTDM_CONF" "$BACKUP"
        echo "🗂️ Backup de lightdm.conf guardado en $BACKUP"
    fi

    # Crear bloque si no existe
    if ! grep -q "^\[Seat:\*\]" "$LIGHTDM_CONF"; then
        echo -e "\n[Seat:*]" | sudo tee -a "$LIGHTDM_CONF" > /dev/null
    fi

    # Limpiar autologin anterior
    sudo sed -i '/^autologin-user=/d' "$LIGHTDM_CONF"
    sudo sed -i '/^autologin-user-timeout=/d' "$LIGHTDM_CONF"

    # Agregar config
    sudo sed -i "/^\[Seat:\*\]/a autologin-user=$USER_NAME\nautologin-user-timeout=0" "$LIGHTDM_CONF"

    echo "✅ Autologin configurado"
}

# Permitir sudo sin contraseña
disable_sudo_password() {
    local USER_NAME=$(whoami)
    local SUDOERS_FILE="/etc/sudoers.d/$USER_NAME-nopasswd"

    echo "⚙️ Configurando 'sudo' sin contraseña para '$USER_NAME'..."
    echo "$USER_NAME ALL=(ALL) NOPASSWD: ALL" | sudo tee "$SUDOERS_FILE" > /dev/null
    sudo chmod 0440 "$SUDOERS_FILE"
    echo "✅ sudo ahora no requiere contraseña"
}

# Quitar contraseña de root
disable_root_password() {
    echo "🛑 Eliminando contraseña de root..."
    sudo passwd -d root
    echo "✅ Ahora podés usar 'sudo su' sin contraseña"
}

# Detectar entorno virtual
detect_vm_env() {
    echo "💻 Entorno detectado:"
    if command -v dmidecode &>/dev/null; then
        sudo dmidecode -s system-product-name
    else
        echo "(Opcional) Instalá 'dmidecode' para detectar entorno"
    fi
}

# Mostrar menú principal
main_menu() {
    dialog --backtitle "🎛️ Kali Linux Post-Instalación" \
    --title "🔥 Asistente de configuración express - Kali VM 🔥" \
    --checklist "Seleccioná lo que querés configurar:\n(✔️ Recomendado en imágenes oficiales de kali.org)\n" 20 70 6 \
    1 "🌍 Cambiar idioma y teclado a español" on \
    2 "🔐 Activar autologin (inicio sin contraseña)" on \
    3 "⚙️ Quitar contraseña al usar sudo" on \
    4 "🛑 Quitar contraseña para sudo su (root)" off \
    5 "❌ Salir sin hacer cambios" off 2> opciones.txt

    if [ $? -ne 0 ]; then
        echo -e "\n❌ Operación cancelada por el usuario."
        rm -f opciones.txt
        exit 1
    fi

    choices=$(<opciones.txt)
    rm -f opciones.txt

    clear
    detect_vm_env
    echo -e "\n🛠️ Aplicando configuraciones...\n"

    for opcion in $choices; do
        case $opcion in
            1) set_language_and_keyboard ;;
            2) enable_autologin ;;
            3) disable_sudo_password ;;
            4) disable_root_password ;;
            5) echo "🚪 Saliendo sin hacer cambios"; exit 0 ;;
        esac
    done

    echo -e "\n✅ Configuración completada."
    echo -e "🔁 Reiniciá la VM para que todos los cambios tomen efecto.\n"
}

# Ejecutar
check_and_install_dialog
main_menu
