# IAT - International Ambassador Testimonial

Application web de gestion de témoignages et d'affiliations.

## Stack Technique

- **Framework**: Next.js 14 (App Router)
- **Langage**: TypeScript
- **Styling**: Tailwind CSS + shadcn/ui
- **Base de données**: Supabase (PostgreSQL)
- **Authentification**: Supabase Auth
- **Paiements**: Stripe
- **Hébergement**: Vercel

## Prérequis

- Node.js 18+
- npm ou yarn
- Compte Supabase
- Compte Stripe

## Installation

```bash
# Cloner le repository
git clone <repository-url>
cd webapp

# Installer les dépendances
npm install

# Configurer les variables d'environnement
cp .env.example .env.local
# Éditer .env.local avec vos clés

# Initialiser la base de données
npm run db:migrate

# Lancer le serveur de développement
npm run dev
```

## Scripts Disponibles

```bash
npm run dev          # Serveur de développement
npm run build        # Build de production
npm run start        # Serveur de production
npm run lint         # Linter ESLint
npm run typecheck    # Vérification TypeScript
npm run db:migrate   # Migrations Supabase
npm run db:types     # Génération types TypeScript
```

## Structure du Projet

```
webapp/
├── app/                    # Next.js App Router
│   ├── (admin)/           # Routes admin protégées
│   ├── (auth)/            # Routes authentification
│   ├── (public)/          # Routes publiques
│   └── api/               # API Routes
├── components/            # Composants React
│   ├── ui/               # shadcn/ui components
│   ├── auth/             # Composants auth
│   └── admin/            # Composants admin
├── lib/                   # Utilitaires
│   ├── supabase/         # Client Supabase
│   └── stripe/           # Client Stripe
├── types/                 # Types TypeScript
└── supabase/             # Configuration Supabase
    ├── migrations/       # Migrations SQL
    └── seed.sql          # Données de test
```

## Configuration Supabase

1. Créer un projet sur [supabase.com](https://supabase.com)
2. Récupérer l'URL et la clé anon dans Project Settings > API
3. Exécuter les migrations:
   ```bash
   npm run db:migrate
   ```

## Configuration Stripe

1. Créer un compte sur [stripe.com](https://stripe.com)
2. Récupérer les clés API dans Developers > API keys
3. Configurer les webhooks (optionnel pour dev)

## Déploiement

### Vercel (Recommandé)

```bash
# Installer Vercel CLI
npm i -g vercel

# Déployer
vercel

# Configurer les variables d'environnement dans le dashboard Vercel
```

### Variables d'environnement requises

- `NEXT_PUBLIC_SUPABASE_URL`
- `NEXT_PUBLIC_SUPABASE_ANON_KEY`
- `SUPABASE_SERVICE_ROLE_KEY`
- `NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY`
- `STRIPE_SECRET_KEY`

## Contribution

1. Fork le projet
2. Créer une branche feature (`git checkout -b feat/amazing-feature`)
3. Commit (`git commit -m 'feat: add amazing feature'`)
4. Push (`git push origin feat/amazing-feature`)
5. Ouvrir une Pull Request

## License

MIT
