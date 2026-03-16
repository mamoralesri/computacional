
#!/bin/zsh

# ============================
# Script: respaldo_pro.sh
# Objetivo: Sincronizar y respaldar cambios (Mac <-> Ubuntu)
# ============================

echo "=== Iniciando sincronización para: $(basename "$PWD") ==="
echo "Fecha: $(date)"

if [[ -d ".git" ]]; then
    # 1. Traer cambios de la nube por si trabajó en Ubuntu
    echo "→ Sincronizando con la nube (Pull)..."
    git pull origin main --no-rebase

    # 2. Preparar cambios locales
    echo "→ Verificando cambios locales..."
    git add .

    # 3. Solo si hay cambios, crear el commit y subir
    if git diff-index --quiet HEAD --; then
        echo "   No hay cambios locales nuevos. ¡Todo está al día!"
    else
        echo "→ Registrando cambios nuevos..."
        git commit -m "Respaldo automático: $(date +"%Y-%m-%d %H:%M")"
        
        echo "→ Subiendo a GitHub..."
        git push origin main
        echo "   ✔ ¡Misión cumplida! Todo está sincronizado."
    fi
else
    echo "   ⚠ ERROR: Esta carpeta no es un repositorio Git."
fi

echo "=== Fin del proceso ==="
