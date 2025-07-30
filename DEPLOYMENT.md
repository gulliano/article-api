heroku config:set APP_NAME="Article API" --app mon-article-api
heroku config:set APP_ENV=production --app mon-article-api
heroku config:set APP_DEBUG=false --app mon-article-api
heroku config:set APP_KEY=$(php artisan key:generate --show) --app mon-article-api
heroku config:set APP_URL=https://mon-article-api.herokuapp.com --app mon-article-api

# Variables optionnelles
heroku config:set LOG_CHANNEL=errorlog --app mon-article-api
heroku config:set SESSION_DRIVER=database --app mon-article-api
heroku config:set CACHE_STORE=database --app mon-article-api
```

## 🔐 Étape 3: Configuration GitHub Secrets

Dans votre repository GitHub, allez dans **Settings > Secrets and variables > Actions** et ajoutez :

| Secret | Valeur | Description |
|--------|--------|-------------|
| `HEROKU_API_KEY` | Votre clé API Heroku | Trouvable dans Account Settings |
| `HEROKU_APP_NAME` | `mon-article-api` | Nom de votre app Heroku |
| `HEROKU_EMAIL` | votre.email@example.com | Email de votre compte Heroku |

### Comment obtenir la clé API Heroku:
```bash
heroku auth:token
```

## 🔄 Étape 4: Configuration du pipeline CI/CD

### 4.1 Workflow GitHub Actions
Le fichier `.github/workflows/deploy.yml` configure:

- ✅ **Tests automatiques** sur chaque push
- ✅ **Analyse statique** du code PHP
- ✅ **Déploiement automatique** sur la branche main
- ✅ **Health check** après déploiement
- ✅ **Rollback automatique** en cas d'échec

### 4.2 Branches et environnements
- `main/master` → Déploiement automatique en production
- Autres branches → Tests uniquement
- Pull requests → Tests + review

## 🚀 Étape 5: Premier déploiement

### 5.1 Pousser le code
```bash
git add .
git commit -m "🚀 Add Heroku deployment configuration"
git push origin main
```

### 5.2 Vérifier le déploiement
```bash
# Voir les logs en temps réel
heroku logs --tail --app mon-article-api

# Vérifier l'état de l'application
heroku ps --app mon-article-api

# Ouvrir l'application
heroku open --app mon-article-api
```

### 5.3 Tester l'API
```bash
# Health check
curl https://mon-article-api.herokuapp.com/api/health

# Lister les articles
curl https://mon-article-api.herokuapp.com/api/article

# Créer un article
curl -X POST https://mon-article-api.herokuapp.com/api/article \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Premier article sur Heroku",
    "content": "Félicitations ! Votre API est déployée.",
    "published": true
  }'
```

## 📊 Étape 6: Monitoring et observabilité

### 6.1 Logs Heroku
```bash
# Voir les logs
heroku logs --tail --app mon-article-api

# Logs des dernières 1000 lignes
heroku logs -n 1000 --app mon-article-api
```

### 6.2 Métriques application
```bash
# Voir l'utilisation des ressources
heroku ps:scale --app mon-article-api

# Voir les add-ons installés
heroku addons --app mon-article-api
```

### 6.3 Base de données
```bash
# Se connecter à PostgreSQL
heroku pg:psql --app mon-article-api

# Voir les informations de la DB
heroku pg:info --app mon-article-api
```

## 🔧 Étape 7: Commandes utiles

### 7.1 Gestion des migrations
```bash
# Exécuter les migrations
heroku run php artisan migrate --app mon-article-api

# Rollback des migrations
heroku run php artisan migrate:rollback --app mon-article-api

# Seeder la base de données
heroku run php artisan db:seed --app mon-article-api
```

### 7.2 Gestion du cache
```bash
# Vider les caches
heroku run php artisan cache:clear --app mon-article-api
heroku run php artisan config:clear --app mon-article-api

# Optimiser pour la production
heroku run php artisan config:cache --app mon-article-api
heroku run php artisan route:cache --app mon-article-api
```

### 7.3 Maintenance
```bash
# Activer le mode maintenance
heroku maintenance:on --app mon-article-api

# Désactiver le mode maintenance
heroku maintenance:off --app mon-article-api
```

## 🛡️ Étape 8: Sécurité et bonnes pratiques

### 8.1 Variables d'environnement sensibles
```bash
# Ne jamais commiter ces variables dans Git:
heroku config:set APP_KEY=votre-cle-secrete --app mon-article-api
heroku config:set SESSION_SECRET=autre-secret --app mon-article-api
```

### 8.2 HTTPS et domaine personnalisé
```bash
# Ajouter un domaine personnalisé
heroku domains:add www.votre-domaine.com --app mon-article-api

# Configurer SSL automatique
heroku certs:auto:enable --app mon-article-api
```

## 📈 Étape 9: Scaling et performance

### 9.1 Scaling horizontal
```bash
# Ajouter plus de dynos web
heroku ps:scale web=2 --app mon-article-api

# Ajouter des workers (si queues)
heroku ps:scale worker=1 --app mon-article-api
```

### 9.2 Add-ons recommandés
```bash
# Redis pour le cache
heroku addons:create heroku-redis:mini --app mon-article-api

# Monitoring avec New Relic
heroku addons:create newrelic:wayne --app mon-article-api

# Backup automatique de la DB
heroku addons:create heroku-postgresql:standard-0 --app mon-article-api
```

## 🔄 Workflow de développement recommandé

1. **Feature branch** → Créer une branche pour nouvelle fonctionnalité
2. **Tests locaux** → `php artisan test`
3. **Pull Request** → Tests automatiques via GitHub Actions
4. **Review** → Code review par l'équipe
5. **Merge** → Déploiement automatique en production
6. **Monitoring** → Surveillance des logs et métriques

## 🚨 Dépannage courant

### Erreur de clé APP_KEY
```bash
heroku config:set APP_KEY=$(php artisan key:generate --show) --app mon-article-api
```

### Problème de migration
```bash
heroku run php artisan migrate:fresh --force --app mon-article-api
```

### Logs détaillés
```bash
heroku config:set APP_DEBUG=true --app mon-article-api
# N'oubliez pas de remettre à false après debug
```

## 📚 Ressources utiles

- [Documentation Heroku PHP](https://devcenter.heroku.com/articles/php-support)
- [Laravel Deployment](https://laravel.com/docs/deployment)
- [GitHub Actions](https://docs.github.com/en/actions)
- [Heroku CLI Reference](https://devcenter.heroku.com/articles/heroku-cli)

---

🎉 **Félicitations !** Votre API est maintenant déployée avec un pipeline DevOps complet !