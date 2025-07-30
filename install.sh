#!/bin/bash

echo "🚀 Installation Article API Laravel"
echo "=================================="

# Vérifier si composer est installé
if ! command -v composer &> /dev/null; then
    echo "❌ Composer n'est pas installé. Installez-le d'abord."
    exit 1
fi

# Vérifier si PHP est installé
if ! command -v php &> /dev/null; then
    echo "❌ PHP n'est pas installé. Installez PHP 8.2+ d'abord."
    exit 1
fi

echo "📦 Installation des dépendances Composer..."
composer install

echo "📋 Configuration de l'environnement..."
if [ ! -f .env ]; then
    cp .env.example .env
    echo "✅ Fichier .env créé"
else
    echo "ℹ️ Fichier .env existe déjà"
fi

echo "🔑 Génération de la clé d'application..."
php artisan key:generate

echo "🗄️ Création de la base de données SQLite..."
if [ ! -f database/database.sqlite ]; then
    touch database/database.sqlite
    echo "✅ Base de données SQLite créée"
else
    echo "ℹ️ Base de données SQLite existe déjà"
fi

echo "📊 Exécution des migrations..."
php artisan migrate

echo "🌱 Peuplement de la base de données..."
php artisan db:seed

echo "🧪 Exécution des tests..."
php artisan test

echo ""
echo "🎉 Installation terminée avec succès !"
echo ""
echo "📋 Commandes utiles :"
echo "  - Démarrer le serveur : php artisan serve"
echo "  - Voir les routes      : php artisan route:list"
echo "  - Exécuter les tests   : php artisan test"
echo "  - Vider les caches     : php artisan cache:clear"
echo ""
echo "🌐 L'API sera accessible sur : http://localhost:8000/api"
echo "❤️ Documentation complète dans README.md"