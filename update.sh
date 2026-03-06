#!/bin/bash

# Configuración
RAMA="main"
FECHA=$(date +"%Y-%m-%d %H:%M:%S")

echo "--- Iniciando Revisión de Sincronización ($FECHA) ---"

# 1. CONSULTAR ESTADO REMOTO SIN DESCARGAR
git fetch origin

# Comprobar si la rama local está por detrás de la remota
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse @{u})

if [ $LOCAL = $REMOTE ]; then
    echo "→ Tu PC ya está al día con GitHub."
elif [ $(git merge-base @ @{u}) = $LOCAL ]; then
    echo "→ Detectados cambios en GitHub. Descargando ahora..."
    git pull origin $RAMA --rebase
else
    echo "→ Tu copia local tiene cambios únicos o hay un conflicto."
fi

# 2. VERIFICAR Y SUBIR CAMBIOS LOCALES (Tu lógica original)
if [[ -n $(git status -s) ]]; then
    echo "→ Detectados cambios locales. Preparando actualización..."
    git add .
    git commit -m "Auto-update desde Linux: $FECHA"
    echo "→ Subiendo tus avances a GitHub..."
    git push origin $RAMA
else
    echo "→ No hay cambios locales que subir."
fi

echo "--- Sincronización completada ---"
