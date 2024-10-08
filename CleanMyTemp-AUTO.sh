#!/bin/bash

#    _____ _                    __  __         _______                   
#   / ____| |                  |  \/  |       |__   __|                  
#  | |    | | ___  __ _ _ __   | \  / |_   _     | | ___ _ __ ___  _ __  
#  | |    | |/ _ \/ _` | '_ \  | |\/| | | | |    | |/ _ \ '_ ` _ \| '_ \ 
#  | |____| |  __/ (_| | | | | | |  | | |_| |    | |  __/ | | | | | |_) |
#   \_____|_|\___|\__,_|_| |_| |_|  |_|\__, |    |_|\___|_| |_| |_| .__/ 
#                                       __/ |                     | | v1.0.0   
#                                      |___/                      |_|    

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

# Mostrar conteo de archivos y carpetas temporales antes de eliminar
echo "Buscando archivos y carpetas temporales..."
echo "Archivos y carpetas temporales en el sistema: $(find "${TEMP_SYS}" -mindepth 1 ! -name "${ARCHIVO_SYS}" 2>/dev/null | wc -l)"
echo "Archivos y carpetas temporales en el usuario: $(find "${TEMP_USER}" -mindepth 1 ! -name "${ARCHIVO_USER}" 2>/dev/null | wc -l)"

# Ejecutar la limpieza automáticamente
eliminar_archivos_temp

# Git repository: https://github.com/im-not-a-d3v/Clean-My-Temp.git