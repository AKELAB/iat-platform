-- Enable necessary extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ================================================
-- TABLES: Contenu Culturel
-- ================================================

-- Table: auteur
CREATE TABLE auteur (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  nom TEXT NOT NULL,
  prenom TEXT,
  biographie TEXT,
  photo_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table: livre
CREATE TABLE livre (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  titre TEXT NOT NULL,
  auteur_id UUID REFERENCES auteur(id) ON DELETE SET NULL,
  description TEXT,
  couverture_url TEXT,
  annee_publication INTEGER,
  editeur TEXT,
  isbn TEXT UNIQUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table: album
CREATE TABLE album (
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
CREATE TABLE musique (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  titre TEXT NOT NULL,
  album_id UUID REFERENCES album(id) ON DELETE CASCADE,
  duree_secondes INTEGER,
  fichier_audio_url TEXT,
  numero_piste INTEGER,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table: video
CREATE TABLE video (
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
CREATE TABLE prevision (
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
CREATE TABLE evenement_global (
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
CREATE TABLE pays (
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
CREATE TABLE periode (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  nom TEXT NOT NULL,
  date_debut DATE,
  date_fin DATE,
  description TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table: recommandation_survie
CREATE TABLE recommandation_survie (
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
CREATE TABLE utilisateur (
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
CREATE TABLE consultation (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  utilisateur_id UUID REFERENCES utilisateur(id) ON DELETE CASCADE,
  contenu_type TEXT CHECK (contenu_type IN ('livre', 'musique', 'video', 'prevision', 'evenement', 'pays', 'recommandation')),
  contenu_id UUID NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ================================================
-- TABLES: FAQ et Événements
-- ================================================

-- Table: question_faq
CREATE TABLE question_faq (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  question TEXT NOT NULL,
  reponse TEXT NOT NULL,
  categorie TEXT,
  ordre INTEGER,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Table: evenement
CREATE TABLE evenement (
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
CREATE TABLE metrique (
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
ALTER TABLE auteur ENABLE ROW LEVEL SECURITY;
ALTER TABLE livre ENABLE ROW LEVEL SECURITY;
ALTER TABLE album ENABLE ROW LEVEL SECURITY;
ALTER TABLE musique ENABLE ROW LEVEL SECURITY;
ALTER TABLE video ENABLE ROW LEVEL SECURITY;
ALTER TABLE prevision ENABLE ROW LEVEL SECURITY;
ALTER TABLE evenement_global ENABLE ROW LEVEL SECURITY;
ALTER TABLE pays ENABLE ROW LEVEL SECURITY;
ALTER TABLE periode ENABLE ROW LEVEL SECURITY;
ALTER TABLE recommandation_survie ENABLE ROW LEVEL SECURITY;
ALTER TABLE utilisateur ENABLE ROW LEVEL SECURITY;
ALTER TABLE consultation ENABLE ROW LEVEL SECURITY;
ALTER TABLE question_faq ENABLE ROW LEVEL SECURITY;
ALTER TABLE evenement ENABLE ROW LEVEL SECURITY;
ALTER TABLE metrique ENABLE ROW LEVEL SECURITY;

-- Policies: Public read access for content tables
CREATE POLICY "Public read access" ON auteur FOR SELECT USING (true);
CREATE POLICY "Public read access" ON livre FOR SELECT USING (true);
CREATE POLICY "Public read access" ON album FOR SELECT USING (true);
CREATE POLICY "Public read access" ON musique FOR SELECT USING (true);
CREATE POLICY "Public read access" ON video FOR SELECT USING (true);
CREATE POLICY "Public read access" ON prevision FOR SELECT USING (true);
CREATE POLICY "Public read access" ON evenement_global FOR SELECT USING (true);
CREATE POLICY "Public read access" ON pays FOR SELECT USING (true);
CREATE POLICY "Public read access" ON periode FOR SELECT USING (true);
CREATE POLICY "Public read access" ON recommandation_survie FOR SELECT USING (true);
CREATE POLICY "Public read access" ON question_faq FOR SELECT USING (true);
CREATE POLICY "Public read access" ON evenement FOR SELECT USING (true);

-- Policies: Admin full access for content tables
CREATE POLICY "Admin full access" ON auteur FOR ALL USING (auth.jwt() ->> 'role' = 'admin');
CREATE POLICY "Admin full access" ON livre FOR ALL USING (auth.jwt() ->> 'role' = 'admin');
CREATE POLICY "Admin full access" ON album FOR ALL USING (auth.jwt() ->> 'role' = 'admin');
CREATE POLICY "Admin full access" ON musique FOR ALL USING (auth.jwt() ->> 'role' = 'admin');
CREATE POLICY "Admin full access" ON video FOR ALL USING (auth.jwt() ->> 'role' = 'admin');
CREATE POLICY "Admin full access" ON prevision FOR ALL USING (auth.jwt() ->> 'role' = 'admin');
CREATE POLICY "Admin full access" ON evenement_global FOR ALL USING (auth.jwt() ->> 'role' = 'admin');
CREATE POLICY "Admin full access" ON pays FOR ALL USING (auth.jwt() ->> 'role' = 'admin');
CREATE POLICY "Admin full access" ON periode FOR ALL USING (auth.jwt() ->> 'role' = 'admin');
CREATE POLICY "Admin full access" ON recommandation_survie FOR ALL USING (auth.jwt() ->> 'role' = 'admin');
CREATE POLICY "Admin full access" ON question_faq FOR ALL USING (auth.jwt() ->> 'role' = 'admin');
CREATE POLICY "Admin full access" ON evenement FOR ALL USING (auth.jwt() ->> 'role' = 'admin');

-- Policies: Utilisateur table
CREATE POLICY "Users can view their own data" ON utilisateur FOR SELECT USING (auth.uid() = id);
CREATE POLICY "Users can update their own data" ON utilisateur FOR UPDATE USING (auth.uid() = id);
CREATE POLICY "Admin full access on users" ON utilisateur FOR ALL USING (auth.jwt() ->> 'role' = 'admin');

-- Policies: Consultation table
CREATE POLICY "Users can view their own consultations" ON consultation FOR SELECT USING (auth.uid() = utilisateur_id);
CREATE POLICY "Users can insert their own consultations" ON consultation FOR INSERT WITH CHECK (auth.uid() = utilisateur_id);
CREATE POLICY "Admin full access on consultations" ON consultation FOR ALL USING (auth.jwt() ->> 'role' = 'admin');

-- Policies: Metrique table
CREATE POLICY "Public read access" ON metrique FOR SELECT USING (true);
CREATE POLICY "Admin full access" ON metrique FOR ALL USING (auth.jwt() ->> 'role' = 'admin');

-- ================================================
-- INDEXES for Performance
-- ================================================

CREATE INDEX idx_livre_auteur ON livre(auteur_id);
CREATE INDEX idx_musique_album ON musique(album_id);
CREATE INDEX idx_consultation_utilisateur ON consultation(utilisateur_id);
CREATE INDEX idx_consultation_contenu ON consultation(contenu_type, contenu_id);
CREATE INDEX idx_prevision_date ON prevision(date_prevue);
CREATE INDEX idx_evenement_global_date ON evenement_global(date_debut, date_fin);
CREATE INDEX idx_pays_nom ON pays(nom);
CREATE INDEX idx_utilisateur_email ON utilisateur(email);

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

CREATE TRIGGER update_auteur_updated_at BEFORE UPDATE ON auteur FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_livre_updated_at BEFORE UPDATE ON livre FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_album_updated_at BEFORE UPDATE ON album FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_musique_updated_at BEFORE UPDATE ON musique FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_video_updated_at BEFORE UPDATE ON video FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_prevision_updated_at BEFORE UPDATE ON prevision FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_evenement_global_updated_at BEFORE UPDATE ON evenement_global FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_pays_updated_at BEFORE UPDATE ON pays FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_periode_updated_at BEFORE UPDATE ON periode FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_recommandation_survie_updated_at BEFORE UPDATE ON recommandation_survie FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_utilisateur_updated_at BEFORE UPDATE ON utilisateur FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_question_faq_updated_at BEFORE UPDATE ON question_faq FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_evenement_updated_at BEFORE UPDATE ON evenement FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
