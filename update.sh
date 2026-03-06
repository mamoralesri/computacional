
#!/bin/bash

# Configuración
RAMA="main"
FECHA=$(date +"%Y-%m-%d %H:%M:%S")

echo "--- Iniciando Sincronización Inteligente ($FECHA) ---"

# 1. GUARDAR CAMBIOS LOCALES PRIMERO
# Esto asegura tus avances en el libro o simulaciones antes de intentar bajar nada
if [[ -n $(git status -s) ]]; then
    echo "→ Guardando tus avances locales..."
    git add .
    git commit -m "Auto-update desde Linux: $FECHA"
else
    echo "→ Sin cambios locales nuevos para guardar."
fi

# 2. TRAER CAMBIOS REMOTOS (GitHub -> Linux)
# Con el commit local hecho, el rebase ahora será fluido
echo "→ Sincronizando con GitHub..."
git pull origin $RAMA --rebase --quiet

# 3. SUBIR TODO A LA NUBE (Linux -> GitHub)
echo "→ Asegurando que todo esté en GitHub..."
git push origin $RAMA

echo "--- Sincronización completada con éxito ---"