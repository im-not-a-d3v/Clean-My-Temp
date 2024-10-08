# Script de Limpieza de Archivos Temporales en Windows

[![version](https://img.shields.io/badge/version-1.0.0-orange?style=for-the-badge&logo=white&labelColor=1c1c1c)](#)
[![license](https://img.shields.io/badge/license-mit-orange?style=for-the-badge&logo=white&labelColor=1c1c1c)](#)

Este repositorio contiene dos scripts en Bash para eliminar automáticamente archivos y carpetas temporales en las carpetas del sistema y del usuario en Windows. 

- **CleanMyTemp**: Script interactivo que requiere confirmación del usuario antes de proceder con la limpieza.
- **CleanMyTemp-AUTO**: Script automático que elimina archivos y carpetas temporales sin requerir intervención del usuario.

## Requisitos

- **Git Bash** en Windows (o cualquier otra consola de Bash compatible con Windows).
- **Permisos de administrador** (opcional, para asegurar la eliminación de archivos temporales del sistema).

## Instrucciones

### 1. CleanMyTemp

1. **Descarga el script** `CleanMyTemp.sh` y guárdalo en tu sistema.
2. **Abre Git Bash** (o tu consola de Bash preferida) y navega hasta el directorio donde guardaste el script.
3. Ejecuta el script con el siguiente comando:

   ```bash
   ./CleanMyTemp.sh
   ```

   El script buscará archivos temporales y te pedirá confirmación antes de eliminarlos.

### 2. CleanMyTemp-AUTO

1. **Descarga el script** `CleanMyTemp-AUTO.sh` y guárdalo en tu sistema.
2. **Abre Git Bash** (o tu consola de Bash preferida) y navega hasta el directorio donde guardaste el script.
3. Ejecuta el script con el siguiente comando:

   ```bash
   ./CleanMyTemp-AUTO.sh
   ```

   Este script eliminará automáticamente los archivos y carpetas temporales sin solicitar confirmación.

## Funcionalidades

- **Eliminación de archivos y carpetas temporales** en:
  - Carpeta temporal del sistema: `/c/Windows/Temp`
  - Carpeta temporal del usuario: `/c/Users/[nombre_de_usuario]/AppData/Local/Temp`
  
- **Generación de archivos de registro**:
  - Ambos scripts crean un archivo `ultima_limpieza.txt` en cada carpeta temporal, documentando la cantidad de elementos eliminados.
  
- **Exclusión de archivos de registro**: El archivo `ultima_limpieza.txt` no se eliminará en ejecuciones posteriores para preservar el registro de limpiezas.

## Detalles Técnicos

Ambos scripts utilizan el comando `find` para buscar y eliminar archivos y carpetas temporales. Se excluye específicamente el archivo `ultima_limpieza.txt` para que permanezca como registro. Las eliminaciones se realizan con `rm -rf` para forzar la eliminación de archivos y carpetas.

## Ejecución Automática

Para programar la ejecución periódica de `CleanMyTemp-AUTO`:
1. **Abre el Programador de Tareas de Windows**.
2. **Crea una nueva tarea** con permisos de administrador.
3. **Configura la tarea** para ejecutar Git Bash y cargar este script, ajustando el intervalo de ejecución a tu preferencia (diario, semanal, etc.).

## Advertencias

- **Archivos en uso**: Algunos archivos o carpetas pueden no eliminarse si están en uso por el sistema u otras aplicaciones.
- **Ejecutar con cuidado**: Asegúrate de que no hay archivos necesarios en las carpetas temporales, ya que serán eliminados sin confirmación (en el caso de `CleanMyTemp-AUTO`).

---

¡Espero que estos scripts te sean útiles para mantener tu sistema limpio!