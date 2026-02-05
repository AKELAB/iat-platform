import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import {
  Calendar,
  Shield,
  Users,
  BookOpen,
  Bot,
  CalendarDays,
} from "lucide-react";

const features = [
  {
    title: "Prévisions personnalisées",
    description:
      "Analyse astrologique quotidienne basée sur votre thème natal et les transits planétaires.",
    icon: Calendar,
  },
  {
    title: "Conseils de survie",
    description:
      "Recommandations pratiques pour naviguer les périodes difficiles identifiées.",
    icon: Shield,
  },
  {
    title: "Consultations",
    description:
      "Réservez des sessions avec des praticiens certifiés pour un accompagnement personnalisé.",
    icon: Users,
  },
  {
    title: "Bibliothèque",
    description:
      "Accédez à une base de connaissances complète sur l'astrologie et les cycles temporels.",
    icon: BookOpen,
  },
  {
    title: "Assistant IA",
    description:
      "Posez vos questions et recevez des réponses contextuelles basées sur votre profil.",
    icon: Bot,
  },
  {
    title: "Événements",
    description:
      "Découvrez les événements astrologiques importants et leurs impacts potentiels.",
    icon: CalendarDays,
  },
];

export function FeaturesSection() {
  return (
    <section className="w-full py-12 md:py-24 lg:py-32 bg-gray-50 dark:bg-gray-900">
      <div className="container px-4 md:px-6">
        <div className="flex flex-col items-center justify-center space-y-4 text-center">
          <div className="space-y-2">
            <h2 className="text-3xl font-bold tracking-tighter sm:text-4xl md:text-5xl">
              Fonctionnalités
            </h2>
            <p className="max-w-[900px] text-gray-500 md:text-xl/relaxed lg:text-base/relaxed xl:text-xl/relaxed dark:text-gray-400">
              Une plateforme complète pour comprendre et naviguer les influences
              cosmiques
            </p>
          </div>
        </div>
        <div className="mx-auto grid max-w-5xl grid-cols-1 gap-6 md:grid-cols-2 lg:grid-cols-3 lg:gap-12 mt-12">
          {features.map((feature) => {
            const Icon = feature.icon;
            return (
              <Card key={feature.title}>
                <CardHeader>
                  <div className="mb-2">
                    <Icon className="h-10 w-10 text-primary" />
                  </div>
                  <CardTitle>{feature.title}</CardTitle>
                </CardHeader>
                <CardContent>
                  <CardDescription>{feature.description}</CardDescription>
                </CardContent>
              </Card>
            );
          })}
        </div>
      </div>
    </section>
  );
}
