import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "IAT - Intelligence Astro-Temporelle",
  description: "Plateforme d'analyse astrologique et temporelle",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="fr">
      <body>{children}</body>
    </html>
  );
}
