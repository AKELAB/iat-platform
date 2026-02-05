-- ================================================
-- SCHEMA IAT: Isolation complète des données IAT
-- ================================================

-- Créer le schema IAT si il n'existe pas
CREATE SCHEMA IF NOT EXISTS iat;

-- Enable necessary extensions (dans public, utilisable par tous les schemas)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp" SCHEMA public;
CREATE EXTENSION IF NOT EXISTS "pgcrypto" SCHEMA public;

-- ================================================
-- TABLES: Contenu Culturel
-- ================================================

-- Table: auteur
CREATE TABLE iat.auteur (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  nom TEXT NOT NULL,
  prenom TEXT,
  biographie TEXT,
  photo_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table: livre
CREATE TABLE iat.livre (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  titre TEXT NOT NULL,
  auteur_id UUID REFERENCES iat.auteur(id) ON DELETE SET NULL,
  description TEXT,
  couverture_url TEXT,
  annee_publication INTEGER,
  editeur TEXT,
  isbn TEXT UNIQUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table: album
CREATE TABLE iat.album (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  titre TEXT NOT NULL,
  artiste TEXT NOT NULL,
  couverture_url TEXT,
  annee_sortie INTEGER,
  genre TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table: musique
CREATE TABLE iat.musique (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  titre TEXT NOT NULL,
  album_id UUID REFERENCES iat.album(id) ON DELETE CASCADE,
  duree_secondes INTEGER,
  fichier_audio_url TEXT,
  numero_piste INTEGER,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table: video
CREATE TABLE iat.video (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  titre TEXT NOT NULL,
  description TEXT,
  url_video TEXT NOT NULL,
  miniature_url TEXT,
  duree_secondes INTEGER,
  type_video TEXT CHECK (type_video IN ('documentaire', 'interview', 'cours', 'autre')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ================================================
-- TABLES: Prévisions et Événements
-- ================================================

-- Table: prevision
CREATE TABLE iat.prevision (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  titre TEXT NOT NULL,
  description TEXT,
  date_prevue DATE,
  probabilite NUMERIC(5,2) CHECK (probabilite >= 0 AND probabilite <= 100),
  source TEXT,
  statut TEXT CHECK (statut IN ('en_attente', 'realise', 'non_realise', 'en_cours')) DEFAULT 'en_attente',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table: evenement_global
CREATE TABLE iat.evenement_global (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  titre TEXT NOT NULL,
  description TEXT,
  date_debut DATE,
  date_fin DATE,
  localisation TEXT,
  type_evenement TEXT,
  importance TEXT CHECK (importance IN ('faible', 'moyenne', 'haute', 'critique')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ================================================
-- TABLES: Géographie et Périodes
-- ================================================

-- Table: pays
CREATE TABLE iat.pays (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  nom TEXT NOT NULL UNIQUE,
  code_iso TEXT UNIQUE,
  continent TEXT,
  population BIGINT,
  capitale TEXT,
  drapeau_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table: periode
CREATE TABLE iat.periode (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  nom TEXT NOT NULL,
  date_debut DATE,
  date_fin DATE,
  description TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table: recommandation_survie
CREATE TABLE iat.recommandation_survie (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  titre TEXT NOT NULL,
  description TEXT,
  categorie TEXT CHECK (categorie IN ('eau', 'nourriture', 'abri', 'sante', 'securite', 'autre')),
  niveau_difficulte TEXT CHECK (niveau_difficulte IN ('facile', 'moyen', 'difficile')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ================================================
-- TABLES: Utilisateurs et Consultations
-- ================================================

-- Table: utilisateur
CREATE TABLE iat.utilisateur (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  email TEXT UNIQUE NOT NULL,
  nom TEXT,
  prenom TEXT,
  photo_url TEXT,
  role TEXT CHECK (role IN ('utilisateur', 'admin')) DEFAULT 'utilisateur',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table: consultation
CREATE TABLE iat.consultation (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  utilisateur_id UUID REFERENCES iat.utilisateur(id) ON DELETE CASCADE,
  contenu_type TEXT CHECK (contenu_type IN ('livre', 'musique', 'video', 'prevision', 'evenement', 'pays', 'recommandation')),
  contenu_id UUID NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ================================================
-- TABLES: FAQ et Événements
-- ================================================

-- Table: question_faq
CREATE TABLE iat.question_faq (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  question TEXT NOT NULL,
  reponse TEXT NOT NULL,
  categorie TEXT,
  ordre INTEGER,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table: evenement
CREATE TABLE iat.evenement (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  titre TEXT NOT NULL,
  description TEXT,
  date_evenement DATE,
  localisation TEXT,
  type_evenement TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ================================================
-- TABLE: Métriques
-- ================================================

-- Table: metrique
CREATE TABLE iat.metrique (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  nom_metrique TEXT NOT NULL,
  valeur NUMERIC,
  unite TEXT,
  date_mesure TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ================================================
-- ROW LEVEL SECURITY (RLS) POLICIES
-- ================================================

-- Enable RLS on all tables
ALTER TABLE iat.auteur ENABLE ROW LEVEL SECURITY;
ALTER TABLE iat.livre ENABLE ROW LEVEL SECURITY;
ALTER TABLE iat.album ENABLE ROW LEVEL SECURITY;
ALTER TABLE iat.musique ENABLE ROW LEVEL SECURITY;
ALTER TABLE iat.video ENABLE ROW LEVEL SECURITY;
ALTER TABLE iat.prevision ENABLE ROW LEVEL SECURITY;
ALTER TABLE iat.evenement_global ENABLE ROW LEVEL SECURITY;
ALTER TABLE iat.pays ENABLE ROW LEVEL SECURITY;
ALTER TABLE iat.periode ENABLE ROW LEVEL SECURITY;
ALTER TABLE iat.recommandation_survie ENABLE ROW LEVEL SECURITY;
ALTER TABLE iat.utilisateur ENABLE ROW LEVEL SECURITY;
ALTER TABLE iat.consultation ENABLE ROW LEVEL SECURITY;
ALTER TABLE iat.question_faq ENABLE ROW LEVEL SECURITY;
ALTER TABLE iat.evenement ENABLE ROW LEVEL SECURITY;
ALTER TABLE iat.metrique ENABLE ROW LEVEL SECURITY;

-- Policies: Public read access for content tables
CREATE POLICY "Public read access" ON iat.auteur FOR SELECT USING (true);
CREATE POLICY "Public read access" ON iat.livre FOR SELECT USING (true);
CREATE POLICY "Public read access" ON iat.album FOR SELECT USING (true);
CREATE POLICY "Public read access" ON iat.musique FOR SELECT USING (true);
CREATE POLICY "Public read access" ON iat.video FOR SELECT USING (true);
CREATE POLICY "Public read access" ON iat.prevision FOR SELECT USING (true);
CREATE POLICY "Public read access" ON iat.evenement_global FOR SELECT USING (true);
CREATE POLICY "Public read access" ON iat.pays FOR SELECT USING (true);
CREATE POLICY "Public read access" ON iat.periode FOR SELECT USING (true);
CREATE POLICY "Public read access" ON iat.recommandation_survie FOR SELECT USING (true);
CREATE POLICY "Public read access" ON iat.question_faq FOR SELECT USING (true);
CREATE POLICY "Public read access" ON iat.evenement FOR SELECT USING (true);

-- Policies: Admin full access for content tables
CREATE POLICY "Admin full access" ON iat.auteur FOR ALL USING (auth.jwt() ->> 'role' = 'admin');
CREATE POLICY "Admin full access" ON iat.livre FOR ALL USING (auth.jwt() ->> 'role' = 'admin');
CREATE POLICY "Admin full access" ON iat.album FOR ALL USING (auth.jwt() ->> 'role' = 'admin');
CREATE POLICY "Admin full access" ON iat.musique FOR ALL USING (auth.jwt() ->> 'role' = 'admin');
CREATE POLICY "Admin full access" ON iat.video FOR ALL USING (auth.jwt() ->> 'role' = 'admin');
CREATE POLICY "Admin full access" ON iat.prevision FOR ALL USING (auth.jwt() ->> 'role' = 'admin');
CREATE POLICY "Admin full access" ON iat.evenement_global FOR ALL USING (auth.jwt() ->> 'role' = 'admin');
CREATE POLICY "Admin full access" ON iat.pays FOR ALL USING (auth.jwt() ->> 'role' = 'admin');
CREATE POLICY "Admin full access" ON iat.periode FOR ALL USING (auth.jwt() ->> 'role' = 'admin');
CREATE POLICY "Admin full access" ON iat.recommandation_survie FOR ALL USING (auth.jwt() ->> 'role' = 'admin');
CREATE POLICY "Admin full access" ON iat.question_faq FOR ALL USING (auth.jwt() ->> 'role' = 'admin');
CREATE POLICY "Admin full access" ON iat.evenement FOR ALL USING (auth.jwt() ->> 'role' = 'admin');

-- Policies: Utilisateur table
CREATE POLICY "Users can view their own data" ON iat.utilisateur FOR SELECT USING (auth.uid() = id);
CREATE POLICY "Users can update their own data" ON iat.utilisateur FOR UPDATE USING (auth.uid() = id);
CREATE POLICY "Admin full access on users" ON iat.utilisateur FOR ALL USING (auth.jwt() ->> 'role' = 'admin');

-- Policies: Consultation table
CREATE POLICY "Users can view their own consultations" ON iat.consultation FOR SELECT USING (auth.uid() = utilisateur_id);
CREATE POLICY "Users can insert their own consultations" ON iat.consultation FOR INSERT WITH CHECK (auth.uid() = utilisateur_id);
CREATE POLICY "Admin full access on consultations" ON iat.consultation FOR ALL USING (auth.jwt() ->> 'role' = 'admin');

-- Policies: Metrique table
CREATE POLICY "Public read access" ON iat.metrique FOR SELECT USING (true);
CREATE POLICY "Admin full access" ON iat.metrique FOR ALL USING (auth.jwt() ->> 'role' = 'admin');

-- ================================================
-- INDEXES for Performance
-- ================================================

CREATE INDEX idx_livre_auteur ON iat.livre(auteur_id);
CREATE INDEX idx_musique_album ON iat.musique(album_id);
CREATE INDEX idx_consultation_utilisateur ON iat.consultation(utilisateur_id);
CREATE INDEX idx_consultation_contenu ON iat.consultation(contenu_type, contenu_id);
CREATE INDEX idx_prevision_date ON iat.prevision(date_prevue);
CREATE INDEX idx_evenement_global_date ON iat.evenement_global(date_debut, date_fin);
CREATE INDEX idx_pays_nom ON iat.pays(nom);
CREATE INDEX idx_utilisateur_email ON iat.utilisateur(email);

-- ================================================
-- TRIGGERS for updated_at
-- ================================================

CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_auteur_updated_at BEFORE UPDATE ON iat.auteur FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_livre_updated_at BEFORE UPDATE ON iat.livre FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_album_updated_at BEFORE UPDATE ON iat.album FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_musique_updated_at BEFORE UPDATE ON iat.musique FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_video_updated_at BEFORE UPDATE ON iat.video FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_prevision_updated_at BEFORE UPDATE ON iat.prevision FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_evenement_global_updated_at BEFORE UPDATE ON iat.evenement_global FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_pays_updated_at BEFORE UPDATE ON iat.pays FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_periode_updated_at BEFORE UPDATE ON iat.periode FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_recommandation_survie_updated_at BEFORE UPDATE ON iat.recommandation_survie FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_utilisateur_updated_at BEFORE UPDATE ON iat.utilisateur FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_question_faq_updated_at BEFORE UPDATE ON iat.question_faq FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_evenement_updated_at BEFORE UPDATE ON iat.evenement FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
