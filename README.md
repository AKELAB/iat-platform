# IAT - Intelligence Artificielle Thérapeutique

Application web de suivi thérapeutique avec IA, gestion de patients et système de paiement.

## Stack Technique

- **Framework**: Next.js 14 (App Router)
- **Language**: TypeScript
- **Styling**: Tailwind CSS + shadcn/ui
- **Database**: Supabase (PostgreSQL)
- **Auth**: Supabase Auth
- **Payments**: Stripe
- **Deployment**: Vercel

## Prérequis

- Node.js 18+ et npm
- Compte Supabase
- Compte Stripe
- Git

## Installation

### 1. Cloner le projet

```bash
git clone <repository-url>
cd IAT/webapp
```

### 2. Installer les dépendances

```bash
npm install
```

### 3. Configuration de l'environnement

Copier le fichier d'exemple et configurer les variables:

```bash
cp .env.example .env.local
```

Éditer `.env.local` avec vos clés:

```env
# Supabase
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key

# Stripe
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=your_stripe_publishable_key
STRIPE_SECRET_KEY=your_stripe_secret_key
STRIPE_WEBHOOK_SECRET=your_stripe_webhook_secret
```

### 4. Configuration de la base de données

Exécuter les migrations SQL dans votre projet Supabase (voir `supabase/migrations/`).

### 5. Lancer le serveur de développement

```bash
npm run dev
```

L'application sera accessible sur `http://localhost:3000`

## Scripts Disponibles

```bash
# Développement
npm run dev          # Lancer le serveur de développement
npm run build        # Build de production
npm run start        # Lancer en production
npm run lint         # Linter le code

# Tests
npm run typecheck    # Vérification TypeScript
```

## Structure du Projet

```
webapp/
├── app/                      # App Router Next.js
│   ├── (auth)/              # Routes d'authentification
│   │   ├── login/
│   │   └── register/
│   ├── (dashboard)/         # Routes protégées
│   │   ├── dashboard/       # Dashboard principal
│   │   ├── patients/        # Gestion patients
│   │   ├── sessions/        # Gestion sessions
│   │   └── settings/        # Paramètres
│   ├── api/                 # API Routes
│   │   ├── stripe/          # Webhooks Stripe
│   │   └── subscriptions/   # Gestion abonnements
│   ├── layout.tsx           # Layout racine
│   └── page.tsx             # Page d'accueil
├── components/              # Composants React
│   ├── ui/                  # Composants shadcn/ui
│   ├── auth/                # Composants auth
│   ├── dashboard/           # Composants dashboard
│   ├── patients/            # Composants patients
│   ├── sessions/            # Composants sessions
│   └── settings/            # Composants settings
├── lib/                     # Utilitaires
│   ├── supabase/           # Client Supabase
│   ├── stripe/             # Client Stripe
│   └── utils.ts            # Helpers
├── hooks/                   # Custom hooks
│   ├── use-auth.ts
│   ├── use-patients.ts
│   └── use-sessions.ts
├── types/                   # Types TypeScript
│   ├── database.ts         # Types Supabase
│   └── index.ts            # Types généraux
└── public/                  # Assets statiques
```

## Fonctionnalités

### Authentification

- Inscription/Connexion avec email/password
- Protection des routes
- Gestion de session

### Gestion des Patients

- Liste des patients
- Création/Édition/Suppression
- Détails patient avec historique

### Gestion des Sessions

- Planning des sessions
- Création avec génération de liens
- Statuts: planifiée, complétée, annulée
- Notes et enregistrements

### Abonnements

- Plans: Essai, Starter, Pro
- Intégration Stripe Checkout
- Gestion des webhooks
- Portail client Stripe

### Dashboard

- Statistiques temps réel
- Graphiques (patients, sessions, revenus)
- Notifications

## Déploiement

### Vercel (Recommandé)

1. Pusher le code sur GitHub

2. Connecter le repository à Vercel

3. Configurer les variables d'environnement dans Vercel:
   - `NEXT_PUBLIC_SUPABASE_URL`
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`
   - `NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY`
   - `STRIPE_SECRET_KEY`
   - `STRIPE_WEBHOOK_SECRET`

4. Déployer

5. Configurer le webhook Stripe:
   - URL: `https://your-domain.vercel.app/api/stripe/webhook`
   - Events: `checkout.session.completed`, `customer.subscription.updated`, `customer.subscription.deleted`

### Variables d'Environnement de Production

Assurez-vous que toutes les variables sont configurées:

- URLs de production Supabase
- Clés Stripe de production
- Webhook secret de production

## Configuration Supabase

### Row Level Security (RLS)

Le projet utilise RLS pour la sécurité. Les policies sont définies dans les migrations.

### Storage

Configuration du bucket `session-recordings`:

- Public: false
- Taille max: 100MB par fichier
- Types autorisés: audio/_, video/_

## Configuration Stripe

### Produits et Prix

Créer les produits suivants dans Stripe:

1. **Essai** (Free)
   - Prix: €0
   - Limite: 5 patients

2. **Starter**
   - Prix: €29/mois
   - Limite: 20 patients

3. **Pro**
   - Prix: €79/mois
   - Patients illimités

### Webhooks

Configurer un endpoint webhook:

- URL: `https://your-domain.com/api/stripe/webhook`
- Events:
  - `checkout.session.completed`
  - `customer.subscription.updated`
  - `customer.subscription.deleted`

## Troubleshooting

### Problèmes de connexion Supabase

- Vérifier les URLs et clés dans `.env.local`
- Vérifier que les migrations sont appliquées
- Vérifier les policies RLS

### Problèmes Stripe

- Vérifier les clés (dev vs production)
- Vérifier le webhook secret
- Consulter les logs Stripe Dashboard

### Build errors

```bash
# Nettoyer et rebuild
rm -rf .next node_modules
npm install
npm run build
```

## Support

Pour toute question ou problème:

- Consulter la documentation Next.js: https://nextjs.org/docs
- Consulter la documentation Supabase: https://supabase.com/docs
- Consulter la documentation Stripe: https://stripe.com/docs

## Licence

Propriétaire - Tous droits réservés
