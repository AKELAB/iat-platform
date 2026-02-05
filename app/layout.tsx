import type { Metadata } from "next";
import "./globals.css";
import { Header } from "@/components/layout/header";
import { Footer } from "@/components/layout/footer";

export const metadata: Metadata = {
  title: "IAT - Institut Aérien de Tunisie | Plateforme de Vol Libre",
  description:
    "Prévisions météo précises, découverte de sites de vol et réservation de vols en parapente et deltaplane en Tunisie. La plateforme complète pour les passionnés de vol libre.",
  keywords: [
    "parapente",
    "deltaplane",
    "vol libre",
    "Tunisie",
    "météo",
    "prévisions",
    "sites de vol",
    "écoles de parapente",
    "réservation vol",
    "IAT",
  ],
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="fr">
      <body className="min-h-screen flex flex-col">
        <Header />
        <main className="flex-1">{children}</main>
        <Footer />
      </body>
    </html>
  );
}
