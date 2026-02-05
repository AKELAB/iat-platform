export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[];

export interface Database {
  iat: {
    Tables: {
      auteur: {
        Row: {
          id: string;
          nom: string;
          prenom: string | null;
          biographie: string | null;
          photo_url: string | null;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id?: string;
          nom: string;
          prenom?: string | null;
          biographie?: string | null;
          photo_url?: string | null;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          nom?: string;
          prenom?: string | null;
          biographie?: string | null;
          photo_url?: string | null;
          created_at?: string;
          updated_at?: string;
        };
      };
      livre: {
        Row: {
          id: string;
          titre: string;
          auteur_id: string | null;
          description: string | null;
          couverture_url: string | null;
          annee_publication: number | null;
          editeur: string | null;
          isbn: string | null;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id?: string;
          titre: string;
          auteur_id?: string | null;
          description?: string | null;
          couverture_url?: string | null;
          annee_publication?: number | null;
          editeur?: string | null;
          isbn?: string | null;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          titre?: string;
          auteur_id?: string | null;
          description?: string | null;
          couverture_url?: string | null;
          annee_publication?: number | null;
          editeur?: string | null;
          isbn?: string | null;
          created_at?: string;
          updated_at?: string;
        };
      };
      video: {
        Row: {
          id: string;
          titre: string;
          description: string | null;
          url_video: string;
          miniature_url: string | null;
          duree_secondes: number | null;
          type_video: "documentaire" | "interview" | "cours" | "autre" | null;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id?: string;
          titre: string;
          description?: string | null;
          url_video: string;
          miniature_url?: string | null;
          duree_secondes?: number | null;
          type_video?: "documentaire" | "interview" | "cours" | "autre" | null;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          titre?: string;
          description?: string | null;
          url_video?: string;
          miniature_url?: string | null;
          duree_secondes?: number | null;
          type_video?: "documentaire" | "interview" | "cours" | "autre" | null;
          created_at?: string;
          updated_at?: string;
        };
      };
      prevision: {
        Row: {
          id: string;
          titre: string;
          description: string | null;
          date_prevue: string | null;
          probabilite: number | null;
          source: string | null;
          statut: "en_attente" | "realise" | "non_realise" | "en_cours";
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id?: string;
          titre: string;
          description?: string | null;
          date_prevue?: string | null;
          probabilite?: number | null;
          source?: string | null;
          statut?: "en_attente" | "realise" | "non_realise" | "en_cours";
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          titre?: string;
          description?: string | null;
          date_prevue?: string | null;
          probabilite?: number | null;
          source?: string | null;
          statut?: "en_attente" | "realise" | "non_realise" | "en_cours";
          created_at?: string;
          updated_at?: string;
        };
      };
      evenement_global: {
        Row: {
          id: string;
          titre: string;
          description: string | null;
          date_debut: string | null;
          date_fin: string | null;
          localisation: string | null;
          type_evenement: string | null;
          importance: "faible" | "moyenne" | "haute" | "critique" | null;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id?: string;
          titre: string;
          description?: string | null;
          date_debut?: string | null;
          date_fin?: string | null;
          localisation?: string | null;
          type_evenement?: string | null;
          importance?: "faible" | "moyenne" | "haute" | "critique" | null;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          titre?: string;
          description?: string | null;
          date_debut?: string | null;
          date_fin?: string | null;
          localisation?: string | null;
          type_evenement?: string | null;
          importance?: "faible" | "moyenne" | "haute" | "critique" | null;
          created_at?: string;
          updated_at?: string;
        };
      };
      pays: {
        Row: {
          id: string;
          nom: string;
          code_iso: string | null;
          continent: string | null;
          population: number | null;
          capitale: string | null;
          drapeau_url: string | null;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id?: string;
          nom: string;
          code_iso?: string | null;
          continent?: string | null;
          population?: number | null;
          capitale?: string | null;
          drapeau_url?: string | null;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          nom?: string;
          code_iso?: string | null;
          continent?: string | null;
          population?: number | null;
          capitale?: string | null;
          drapeau_url?: string | null;
          created_at?: string;
          updated_at?: string;
        };
      };
      recommandation_survie: {
        Row: {
          id: string;
          titre: string;
          description: string | null;
          categorie:
            | "eau"
            | "nourriture"
            | "abri"
            | "sante"
            | "securite"
            | "autre"
            | null;
          niveau_difficulte: "facile" | "moyen" | "difficile" | null;
          created_at: string;
          updated_at: string;
        };
        Insert: {
          id?: string;
          titre: string;
          description?: string | null;
          categorie?:
            | "eau"
            | "nourriture"
            | "abri"
            | "sante"
            | "securite"
            | "autre"
            | null;
          niveau_difficulte?: "facile" | "moyen" | "difficile" | null;
          created_at?: string;
          updated_at?: string;
        };
        Update: {
          id?: string;
          titre?: string;
          description?: string | null;
          categorie?:
            | "eau"
            | "nourriture"
            | "abri"
            | "sante"
            | "securite"
            | "autre"
            | null;
          niveau_difficulte?: "facile" | "moyen" | "difficile" | null;
          created_at?: string;
          updated_at?: string;
        };
      };
    };
  };
}
