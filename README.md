# 🛠️ Kali Tweaks ES

`kali-tweaks-es.sh` es un script en Bash diseñado para configurar rápida y cómodamente una máquina virtual de **Kali Linux** recién descargada desde [kali.org](https://www.kali.org/get-kali/#kali-virtual-machines). Ofrece una interfaz visual en consola (usando `dialog`) para aplicar varias mejoras útiles pensadas para entornos en español y sistemas virtualizados.

---

## 🚀 ¿Qué hace?

El script permite aplicar las siguientes configuraciones de forma sencilla:

- 🌍 Cambia la distribución del teclado a **español latinoamericano**
- 🗣️ Cambia el idioma del sistema a **español**
- 🔐 Activa el **inicio de sesión automático** (autologin)
- ⚙️ Elimina la necesidad de contraseña al usar `sudo`
- 🛑 (Opcional) Elimina la contraseña de root para permitir `sudo su` sin contraseña
- 🖥️ Todo desde un menú interactivo tipo GUI en consola

> ✅ Ideal para máquinas virtuales de laboratorio, entornos educativos o pentesting rápido.

---

## 📦 Instalación rápida

Ejecutá esta línea en tu terminal para clonar, ingresar al directorio, dar permisos y ejecutar el script:

```bash
git clone https://github.com/MrGuillote/kali-tweaks-es.git && cd kali-tweaks-es && chmod +x kali-tweaks-es.sh && sudo ./kali-tweaks-es.sh
```

---

## 🧰 Requisitos

- ✅ Kali Linux (se recomienda usar imágenes oficiales para VMware o VirtualBox)
- ✅ Acceso a una terminal con permisos `sudo`
- ✅ Conexión a internet (solo para instalar `dialog` si no está presente)

---

## 📷 Captura de pantalla

Así se ve el menú principal del script:

![image](https://github.com/MrGuillote/Teclado_Espanol_Kali_Linux/assets/89352244/60022b39-c6b8-443c-9872-4bb6d6434bf0)

---

## ⚠️ Importante

Este script está pensado para funcionar correctamente en imágenes **oficiales** de Kali descargadas desde:

🔗 https://www.kali.org/get-kali/#kali-virtual-machines

> No se recomienda su uso en instalaciones personalizadas, sistemas en producción o entornos sensibles.

---

## 📖 Licencia

_No tiene licencia porque básicamente es un script en Bash._  
Podés usarlo, modificarlo y compartirlo libremente. 🙌

---

## 🤝 Agradecimientos

Gracias por usar `kali-tweaks-es.sh`.  
Si tenés sugerencias, encontrás errores o querés mejorar el script, no dudes en abrir un **issue** o **pull request** en este repositorio. 🧑‍💻
