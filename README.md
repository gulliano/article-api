# 📝 API Articles - Documentation

Une API REST simple et efficace pour gérer des articles avec Laravel 12.

## 🚀 Fonctionnalités

- ✅ CRUD complet des articles
- ✅ Gestion des statuts de publication
- ✅ Validation des données
- ✅ Réponses JSON structurées
- ✅ Base de données SQLite intégrée

## 📋 Prérequis

- PHP 8.2+
- Composer
- SQLite

## ⚡ Installation

```bash
# Cloner le projet
git clone <votre-repo>
cd article-api

# Installer les dépendances
composer install

# Copier le fichier d'environnement
cp .env.example .env

# Générer la clé d'application
php artisan key:generate

# Créer la base de données
touch database/database.sqlite

# Exécuter les migrations
php artisan migrate

# (Optionnel) Peupler avec des données de test
php artisan db:seed

# Démarrer le serveur
php artisan serve
```

L'API sera accessible sur `http://localhost:8000`

## 📚 Structure de données

### Article
```json
{
  "id": 1,
  "title": "Titre de l'article",
  "content": "Contenu complet de l'article...",
  "published": true,
  "created_at": "2025-07-29T15:30:00.000000Z",
  "updated_at": "2025-07-29T15:30:00.000000Z"
}
```

## 🔗 Endpoints

### Base URL
```
http://localhost:8000/api
```

### 📖 Lister tous les articles
```http
GET /api/article
```

**Réponse :**
```json
{
  "success": true,
  "articles": [
    {
      "id": 1,
      "title": "Mon premier article",
      "content": "Contenu de l'article...",
      "published": true,
      "created_at": "2025-07-29T15:30:00.000000Z",
      "updated_at": "2025-07-29T15:30:00.000000Z"
    }
  ]
}
```

### 👁️ Afficher un article spécifique
```http
GET /api/article/{id}
```

**Paramètres :**
- `id` (integer, required) : ID de l'article

**Exemple :**
```bash
curl -X GET http://localhost:8000/api/article/1
```

**Réponse :**
```json
{
  "success": true,
  "article": {
    "id": 1,
    "title": "Mon premier article",
    "content": "Contenu de l'article...",
    "published": true,
    "created_at": "2025-07-29T15:30:00.000000Z",
    "updated_at": "2025-07-29T15:30:00.000000Z"
  }
}
```

### ➕ Créer un nouvel article
```http
POST /api/article
```

**Corps de la requête :**
```json
{
  "title": "Titre de l'article",
  "content": "Contenu de l'article",
  "published": false
}
```

**Exemple avec curl :**
```bash
curl -X POST http://localhost:8000/api/article \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Mon nouvel article",
    "content": "Voici le contenu de mon article...",
    "published": true
  }'
```

**Réponse (201) :**
```json
{
  "success": true,
  "message": "Article créé avec succès",
  "article": {
    "id": 2,
    "title": "Mon nouvel article",
    "content": "Voici le contenu de mon article...",
    "published": true,
    "created_at": "2025-07-29T16:00:00.000000Z",
    "updated_at": "2025-07-29T16:00:00.000000Z"
  }
}
```

### ✏️ Modifier un article
```http
PUT /api/article/{id}
```

**Paramètres :**
- `id` (integer, required) : ID de l'article à modifier

**Corps de la requête :**
```json
{
  "title": "Nouveau titre",
  "content": "Nouveau contenu",
  "published": true
}
```

**Exemple avec curl :**
```bash
curl -X PUT http://localhost:8000/api/article/1 \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Titre modifié",
    "content": "Contenu modifié...",
    "published": false
  }'
```

**Réponse :**
```json
{
  "success": true,
  "message": "Article modifié avec succès",
  "article": {
    "id": 1,
    "title": "Titre modifié",
    "content": "Contenu modifié...",
    "published": false,
    "created_at": "2025-07-29T15:30:00.000000Z",
    "updated_at": "2025-07-29T16:15:00.000000Z"
  }
}
```

### 🗑️ Supprimer un article
```http
DELETE /api/article/{id}
```

**Paramètres :**
- `id` (integer, required) : ID de l'article à supprimer

**Exemple avec curl :**
```bash
curl -X DELETE http://localhost:8000/api/article/1
```

**Réponse :**
```json
{
  "success": true,
  "message": "Article supprimé avec succès"
}
```

## ✅ Validation des données

### Règles de validation pour la création/modification

| Champ | Type | Requis | Règles |
|-------|------|---------|--------|
| `title` | string | ✅ | Max 255 caractères |
| `content` | string | ✅ | Aucune limite |
| `published` | boolean | ❌ | true/false (défaut: false) |

### Exemples d'erreurs de validation

**Titre manquant (422) :**
```json
{
  "message": "The title field is required.",
  "errors": {
    "title": ["The title field is required."]
  }
}
```

**Titre trop long (422) :**
```json
{
  "message": "The title field must not be greater than 255 characters.",
  "errors": {
    "title": ["The title field must not be greater than 255 characters."]
  }
}
```

## 📱 Codes de statut HTTP

| Code | Description |
|------|-------------|
| 200 | Succès |
| 201 | Créé avec succès |
| 422 | Erreur de validation |
| 404 | Ressource non trouvée |
| 500 | Erreur serveur |

## 🧪 Tests

```bash
# Exécuter tous les tests
php artisan test

# Tests avec couverture
php artisan test --coverage

# Tests spécifiques
php artisan test --filter ArticleTest
```

## 🛠️ Exemples d'utilisation

### JavaScript (Fetch API)

```javascript
// Récupérer tous les articles
async function getArticles() {
  const response = await fetch('http://localhost:8000/api/article');
  const data = await response.json();
  return data.articles;
}

// Créer un article
async function createArticle(article) {
  const response = await fetch('http://localhost:8000/api/article', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(article)
  });
  return await response.json();
}

// Utilisation
const newArticle = {
  title: "Mon article depuis JS",
  content: "Contenu de l'article...",
  published: true
};

createArticle(newArticle).then(result => {
  console.log('Article créé:', result);
});
```

### Python (requests)

```python
import requests

base_url = "http://localhost:8000/api"

# Récupérer tous les articles
response = requests.get(f"{base_url}/article")
articles = response.json()

# Créer un article
new_article = {
    "title": "Article depuis Python",
    "content": "Contenu de l'article...",
    "published": True
}

response = requests.post(f"{base_url}/article", json=new_article)
result = response.json()
print(f"Article créé: {result}")
```

## 🔧 Configuration

### Variables d'environnement (.env)

```env
APP_NAME="Article API"
APP_URL=http://localhost:8000
DB_CONNECTION=sqlite
DB_DATABASE=/chemin/vers/database/database.sqlite
```

### Base de données

La base de données SQLite est automatiquement créée dans `database/database.sqlite`

Pour réinitialiser :
```bash
php artisan migrate:fresh --seed
```

## 📈 Améliorations futures

- [ ] Authentification avec Sanctum
- [ ] Pagination des résultats
- [ ] Filtres et recherche
- [ ] Upload d'images
- [ ] Système de tags
- [ ] API versioning
- [ ] Documentation Swagger/OpenAPI
- [ ] Cache Redis
- [ ] Rate limiting

## 🐛 Problèmes connus

1. **Erreur dans le modèle** : `$cast` devrait être `$casts`
2. **Message de suppression incomplet** dans la méthode `destroy()`

## 🤝 Contribution

1. Fork le projet
2. Créer une branche feature (`git checkout -b feature/nouvelle-fonctionnalite`)
3. Commit les changements (`git commit -am 'Ajout nouvelle fonctionnalité'`)
4. Push sur la branche (`git push origin feature/nouvelle-fonctionnalite`)
5. Créer une Pull Request

## 📄 Licence

Ce projet est sous licence MIT.

---

**Développé avec ❤️ en utilisant Laravel 12**