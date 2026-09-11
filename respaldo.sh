
#!/bin/zsh

# ============================
# Script: respaldo_pro.sh
# Objetivo: Sincronizar y respaldar cambios de manera segura
# ============================

echo "=== Iniciando sincronización para: $(basename "$PWD") ==="
echo "Fecha: $(date)"

if [[ -d ".git" ]]; then
    # 1. Traer cambios de la nube
    echo "→ Sincronizando con la nube (Pull)..."
    if ! git pull origin main --no-rebase; then
        echo "   ❌ ERROR FATAL: Conflicto o problema al descargar (Pull)."
        echo "   El script se ha detenido para proteger sus archivos."
        echo "   Solucione el conflicto manualmente antes de continuar."
        echo "=== Fin del proceso con errores ==="
        exit 1
    fi

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
        if ! git push origin main; then
            echo "   ❌ ERROR: No se pudo subir a GitHub (Push)."
            echo "   Revise su conexión a internet o los permisos de la cuenta."
            echo "=== Fin del proceso con errores ==="
            exit 1
        fi
        echo "   ✔ ¡Misión cumplida! Todo está sincronizado."
    fi
else
    echo "   ⚠ ERROR: Esta carpeta no es un repositorio Git."
fi

echo "=== Fin del proceso ==="