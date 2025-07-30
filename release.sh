#!/bin/bash

echo "🚀 Starting deployment process..."

# Clear caches
echo "📦 Clearing caches..."
php artisan cache:clear
php artisan config:clear
php artisan route:clear
php artisan view:clear

# Optimize for production
echo "⚡ Optimizing for production..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Run migrations
echo "📊 Running database migrations..."
php artisan migrate --force

# Seed database if needed (optional)
# php artisan db:seed --force

echo "✅ Deployment completed successfully!"