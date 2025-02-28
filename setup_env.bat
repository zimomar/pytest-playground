@echo off
:: Vérifie si Python est installé
where python >nul 2>nul
if %errorlevel% neq 0 (
    echo Python n'est pas installé. Veuillez l'installer avant de continuer.
    exit /b 1
)

:: Création de l'environnement virtuel
python -m venv venv

:: Activation de l'environnement virtuel
call venv\Scripts\activate.bat

:: Installation des dépendances
pip install --upgrade pip
pip install -r requirements.txt

echo.
echo Environnement de test pret !
echo Utilisez "venv\Scripts\activate.bat" pour activer l'environnement.
echo Utilisez "deactivate" pour quitter l'environnement.
echo.
exit /b 0
