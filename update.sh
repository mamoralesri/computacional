#!/bin/bash

# Configuración
RAMA="main"
FECHA=$(date +"%Y-%m-%d %H:%M:%S")

echo "--- Iniciando Revisión de Sincronización ($FECHA) ---"

# 1. ACTUALIZAR INFORMACIÓN REMOTA
git fetch origin

# 2. INTENTAR SINCRONIZAR (Solo descarga si es necesario)
# --quiet para que no llene la pantalla si no hay nada nuevo
echo "→ Sincronizando con GitHub..."
git pull origin $RAMA --rebase --quiet

# 3. VERIFICAR SI HAY CAMBIOS LOCALES PARA SUBIR
if [[ -n $(git status -s) ]]; then
    echo "→ Detectados nuevos cambios locales. Preparando actualización..."
    
    git add .
    git commit -m "Auto-update desde Linux: $FECHA"
    
    echo "→ Subiendo tus avances a GitHub..."
    git push origin $RAMA
else
    echo "→ Todo está al día. No hay nada nuevo que subir."
fi

echo "--- Sincronización completada con éxito ---"
