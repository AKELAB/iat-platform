"use client";

import Link from "next/link";
import { Button } from "@/components/ui/button";
import { useState } from "react";
import { Menu, X } from "lucide-react";

export function Header() {
  const [isMenuOpen, setIsMenuOpen] = useState(false);

  const navigation = [
    {
      name: "Prévisions",
      items: [
        { name: "Météo Détaillée", href: "/previsions/meteo" },
        { name: "Conditions de Vol", href: "/previsions/vol" },
        { name: "Carte Interactive", href: "/previsions/carte" },
      ],
    },
    {
      name: "Découvrir",
      items: [
        { name: "Sites de Vol", href: "/sites" },
        { name: "Écoles", href: "/ecoles" },
        { name: "Événements", href: "/evenements" },
      ],
    },
    {
      name: "Ressources",
      items: [
        { name: "Guides & Tutoriels", href: "/ressources/guides" },
        { name: "Sécurité", href: "/ressources/securite" },
        { name: "Réglementation", href: "/ressources/reglementation" },
      ],
    },
    {
      name: "Mon Espace",
      items: [
        { name: "Tableau de Bord", href: "/dashboard" },
        { name: "Mes Vols", href: "/mes-vols" },
        { name: "Mes Favoris", href: "/favoris" },
      ],
    },
  ];

  return (
    <header className="sticky top-0 z-50 w-full border-b bg-white/80 backdrop-blur-sm">
      <div className="container mx-auto px-4">
        <div className="flex h-16 items-center justify-between">
          {/* Logo */}
          <Link href="/" className="flex items-center space-x-2">
            <div className="h-8 w-8 rounded-full bg-gradient-to-br from-blue-500 to-cyan-400" />
            <span className="text-xl font-bold text-gray-900">IAT</span>
          </Link>

          {/* Desktop Navigation */}
          <nav className="hidden md:flex md:items-center md:space-x-8">
            {navigation.map((menu) => (
              <div key={menu.name} className="group relative">
                <button className="text-sm font-medium text-gray-700 hover:text-blue-600 transition-colors">
                  {menu.name}
                </button>
                <div className="absolute left-0 mt-2 w-48 rounded-md bg-white shadow-lg opacity-0 invisible group-hover:opacity-100 group-hover:visible transition-all duration-200">
                  <div className="py-2">
                    {menu.items.map((item) => (
                      <Link
                        key={item.href}
                        href={item.href}
                        className="block px-4 py-2 text-sm text-gray-700 hover:bg-blue-50 hover:text-blue-600 transition-colors"
                      >
                        {item.name}
                      </Link>
                    ))}
                  </div>
                </div>
              </div>
            ))}
          </nav>

          {/* CTA Buttons */}
          <div className="hidden md:flex md:items-center md:space-x-4">
            <Button variant="ghost" asChild>
              <Link href="/connexion">Connexion</Link>
            </Button>
            <Button asChild>
              <Link href="/reserver">Réserver un Vol</Link>
            </Button>
          </div>

          {/* Mobile menu button */}
          <button
            onClick={() => setIsMenuOpen(!isMenuOpen)}
            className="md:hidden p-2 text-gray-700"
          >
            {isMenuOpen ? <X size={24} /> : <Menu size={24} />}
          </button>
        </div>

        {/* Mobile Navigation */}
        {isMenuOpen && (
          <div className="md:hidden py-4 border-t">
            {navigation.map((menu) => (
              <div key={menu.name} className="mb-4">
                <p className="font-semibold text-gray-900 mb-2">{menu.name}</p>
                {menu.items.map((item) => (
                  <Link
                    key={item.href}
                    href={item.href}
                    className="block py-2 pl-4 text-sm text-gray-700 hover:text-blue-600"
                    onClick={() => setIsMenuOpen(false)}
                  >
                    {item.name}
                  </Link>
                ))}
              </div>
            ))}
            <div className="flex flex-col space-y-2 pt-4 border-t">
              <Button variant="ghost" asChild>
                <Link href="/connexion">Connexion</Link>
              </Button>
              <Button asChild>
                <Link href="/reserver">Réserver un Vol</Link>
              </Button>
            </div>
          </div>
        )}
      </div>
    </header>
  );
}
