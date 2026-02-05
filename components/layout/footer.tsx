import Link from "next/link";

export function Footer() {
  const footerSections = [
    {
      title: "IAT",
      links: [
        { name: "À propos", href: "/a-propos" },
        { name: "Notre Mission", href: "/mission" },
        { name: "Contact", href: "/contact" },
        { name: "Carrières", href: "/carrieres" },
      ],
    },
    {
      title: "Navigation",
      links: [
        { name: "Prévisions Météo", href: "/previsions/meteo" },
        { name: "Sites de Vol", href: "/sites" },
        { name: "Écoles", href: "/ecoles" },
        { name: "Événements", href: "/evenements" },
      ],
    },
    {
      title: "Services",
      links: [
        { name: "Réserver un Vol", href: "/reserver" },
        { name: "Formation", href: "/formation" },
        { name: "Communauté", href: "/communaute" },
        { name: "Blog", href: "/blog" },
      ],
    },
    {
      title: "Légal",
      links: [
        { name: "Conditions d'Utilisation", href: "/legal/conditions" },
        {
          name: "Politique de Confidentialité",
          href: "/legal/confidentialite",
        },
        { name: "Mentions Légales", href: "/legal/mentions" },
        { name: "Cookies", href: "/legal/cookies" },
      ],
    },
  ];

  return (
    <footer className="bg-gray-50 border-t">
      <div className="container mx-auto px-4 py-12">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
          {footerSections.map((section) => (
            <div key={section.title}>
              <h3 className="font-semibold text-gray-900 mb-4">
                {section.title}
              </h3>
              <ul className="space-y-2">
                {section.links.map((link) => (
                  <li key={link.href}>
                    <Link
                      href={link.href}
                      className="text-sm text-gray-600 hover:text-blue-600 transition-colors"
                    >
                      {link.name}
                    </Link>
                  </li>
                ))}
              </ul>
            </div>
          ))}
        </div>
        <div className="mt-8 pt-8 border-t text-center text-sm text-gray-600">
          <p>
            &copy; {new Date().getFullYear()} IAT - Institut Aérien de Tunisie.
            Tous droits réservés.
          </p>
        </div>
      </div>
    </footer>
  );
}
