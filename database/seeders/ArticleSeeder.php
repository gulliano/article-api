<?php

namespace Database\Seeders;

use App\Models\Article;
use Illuminate\Database\Seeder;

class ArticleSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Créer 20 articles de test
        Article::factory()->count(20)->create();
        
        // Créer quelques articles spécifiques
        Article::factory()->create([
            'title' => 'Bienvenue sur notre API Articles',
            'content' => 'Ceci est le premier article de démonstration de notre API. Elle permet de gérer vos articles facilement avec toutes les opérations CRUD nécessaires.',
            'published' => true
        ]);
        
        Article::factory()->create([
            'title' => 'Guide d\'utilisation de l\'API',
            'content' => 'Cette API vous permet de créer, lire, modifier et supprimer des articles. Consultez la documentation pour connaître tous les endpoints disponibles.',
            'published' => true
        ]);
        
        Article::factory()->create([
            'title' => 'Article en brouillon',
            'content' => 'Ceci est un exemple d\'article non publié, en mode brouillon.',
            'published' => false
        ]);
    }
}