#!/bin/bash

echo ""
echo "   _____ _                    __  __         _______                   "
echo "  / ____| |                  |  \/  |       |__   __|                  "
echo " | |    | | ___  __ _ _ __   | \  / |_   _     | | ___ _ __ ___  _ __  "
echo " | |    | |/ _ \/ _\` | '_ \\  | |\/| | | | |    | |/ _ \\ '_ \` _ \\| '_ \\ "
echo " | |____| |  __/ (_| | | | | | |  | | |_| |    | |  __/ | | | | | |_) |"
echo "  \\_____|_|\\___|\\__,_|_| |_| |_|  |_|\\__, |    |_|\___|_| |_| |_| .__/ "
echo "                                      __/ |                     | | v1.0.0   "
echo "                                     |___/                      |_|    "
echo ""

# Rutas de carpetas temporales
TEMP_SYS="/c/Windows/Temp"
TEMP_USER="/c/Users/$(whoami)/AppData/Local/Temp"
ARCHIVO_SYS="ultima_limpieza.txt"
ARCHIVO_USER="ultima_limpieza.txt"

# Función para contar y eliminar archivos y carpetas temporales, excluyendo el archivo de registro
eliminar_archivos_temp() {
    # Contar archivos y carpetas temporales, excluyendo el archivo de registro
    local count_sys=$(find "${TEMP_SYS}" -mindepth 1 ! -name "${ARCHIVO_SYS}" 2>/dev/null | wc -l)
    local count_user=$(find "${TEMP_USER}" -mindepth 1 ! -name "${ARCHIVO_USER}" 2>/dev/null | wc -l)

    # Eliminar archivos y carpetas temporales del sistema
    echo "Eliminando archivos y carpetas temporales del sistema..."
    find "${TEMP_SYS}" -mindepth 1 ! -name "${ARCHIVO_SYS}" -exec rm -rf {} + 2>/dev/null
    echo "Archivos y carpetas temporales del sistema eliminados."

    # Eliminar archivos y carpetas temporales del usuario, forzando eliminación
    echo "Eliminando archivos y carpetas temporales del usuario..."
    find "${TEMP_USER}" -mindepth 1 ! -name "${ARCHIVO_USER}" -exec rm -rf {} + -exec rmdir --ignore-fail-on-non-empty {} + 2>/dev/null
    echo "Archivos y carpetas temporales del usuario eliminados."

    # Crear o actualizar archivos de registro con el número de archivos y carpetas eliminados
    echo "Archivos y carpetas eliminados: $count_sys" > "${TEMP_SYS}/${ARCHIVO_SYS}"
    echo "Archivos y carpetas eliminados: $count_user" > "${TEMP_USER}/${ARCHIVO_USER}"
    
    echo "Registro de limpieza actualizado en ambas carpetas temporales."
}

# Función para contar archivos y carpetas temporales
contar_archivos_temp() {
    local total_sys=$(find "${TEMP_SYS}" -mindepth 1 ! -name "${ARCHIVO_SYS}" 2>/dev/null | wc -l)
    local total_user=$(find "${TEMP_USER}" -mindepth 1 ! -name "${ARCHIVO_USER}" 2>/dev/null | wc -l)
    echo "Archivos y carpetas temporales en el sistema: $total_sys"
    echo "Archivos y carpetas temporales en el usuario: $total_user"
}

# Confirmación del usuario antes de proceder con la eliminación
confirmar_eliminacion() {
    read -p "¿Deseas eliminar todos los archivos y carpetas temporales? (s/n): " respuesta
    case $respuesta in
        [Ss]* ) eliminar_archivos_temp;;
        [Nn]* ) echo "Operación cancelada."; exit;;
        * ) echo "Por favor responde con 's' o 'n'."; confirmar_eliminacion;;
    esac
}

# Mostrar conteo de archivos y carpetas temporales antes de eliminar
echo "Buscando archivos y carpetas temporales..."
contar_archivos_temp

# Confirmación del usuario para proceder
confirmar_eliminacion

# Git repository: https://github.com/im-not-a-d3v/Clean-My-Temp.git