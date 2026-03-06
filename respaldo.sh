
#!/bin/zsh

# ============================
# Script: respaldo_clase.sh
# Objetivo: Respaldar SOLO esta carpeta de clase
# ============================

echo "=== Iniciando respaldo único para: $(basename "$PWD") ==="
echo "Fecha: $(date)"

# Verificamos que sea un repositorio Git
if [[ -d ".git" ]]; then
    echo "→ Ejecutando git add..."
    git add .

    # Verificamos si hay cambios reales para no subir basura
    if git diff-index --quiet HEAD --; then
        echo "   No hay cambios nuevos que respaldar."
    else
        echo "→ Creando commit..."
        # Usamos el formato de fecha que usted ya prefiere
        git commit -m "Respaldo independiente: $(date +"%Y-%m-%d %H:%M")"
        
        echo "→ Subiendo a GitHub..."
        git push
        echo "   ✔ ¡Misión cumplida! Todo está en la nube."
    fi
else
    echo "   ⚠ ERROR: Esta carpeta no ha sido inicializada con Git."
    echo "   Use 'git init' y vincúlela a un repo de GitHub primero."
fi

echo "=== Fin del proceso ==="

