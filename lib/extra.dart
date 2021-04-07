import 'package:flutter/material.dart';

import 'constante/colors.dart';

class Policity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[900],
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.close, color: Colors.white),
      ),
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [
              title('Poltique de confidentialité'),
              desc(
                  "Tchadia est une application gratuite. Ce SERVICE est fourni par Naim Abdelkerim sans frais et est destiné à être utilisé tel quel.Cette page est utilisée pour informer les visiteurs de mes politiques concernant la collecte, l’utilisation et la divulgation de renseignements personnels si quelqu’un a décidé d’utiliser ce service.Si vous choisissez d’utiliser le Service, alors vous acceptez la collecte et l’utilisation de l’information relative à cette politique. Les renseignements personnels que je recueille sont utilisés pour fournir et améliorer le Service. Je n’utilisera ni ne partagerons vos informations avec qui que ce soit, sauf comme décrit dans cette politique de confidentialité.Les termes utilisés dans la cette politique de confidentialité ont les mêmes significations que dans nos conditions générales, qui sont accessibles à Tchadia à moins d’être définis autrement dans cette politique de confidentialité."),
              title('Collecte et utilisation de l’information'),
              desc(
                  "Pour une meilleure expérience, tout en utilisant notre Service, je peux vous demander de nous fournir certaines informations personnellement identifiables, y compris, mais sans s’y limiter, Naim Abdelkerim. Les informations que je demande seront conservées sur votre appareil et ne sont pas collectées par moi en aucune façon.L’application utilise des services tiers qui peuvent recueillir des informations utilisées pour vous identifier."),
              title("Fournisseurs"),
              desc("Je peux employer des entreprises ou des particuliers tiers pour les raisons suivantes :\n" +
                  "\nPour faciliter notre service;\n" +
                  "Fournir le Service en notre nom;\n" +
                  "Effectuer des services liés au service;\n" +
                  "Pour nous aider à analyser la façon dont notre service est utilisé.\n" +
                  "Je tiens à informer les utilisateurs de ce service que ces tiers ont accès à vos renseignements personnels. La raison en est d’accomplir les tâches qui leur sont assignées en notre nom. Toutefois, ils sont tenus de ne pas divulguer ou utiliser les renseignements à d’autres fins."),
              title("Sécurité"),
              desc(
                  "J’apprécie votre confiance en nous fournissant vos renseignements personnels, c’est pourquoi nous nous efforçons d’utiliser des moyens commercialement acceptables de les protéger. Mais n’oubliez pas qu’aucune méthode de transmission sur Internet, ou méthode de stockage électronique n’est 100% sécurisée et fiable, et je ne peux pas garantir sa sécurité absolue."),
              title("Vie privée des enfants"),
              desc(
                  "Ces services ne s’adressent à personne de moins de 13 ans. Je ne recueille pas sciemment de renseignements personnels identifiables auprès d’enfants de moins de 13 ans. Dans le cas où je découvre qu’un enfant de moins de 13 ans m’a fourni des informations personnelles, je supprime immédiatement cela de nos serveurs. Si vous êtes un parent ou un tuteur et que vous savez que votre enfant nous a fourni des renseignements personnels, veuillez communiquer avec moi afin que je puisse prendre les mesures nécessaires.\n\nJe peux mettre à jour notre politique de confidentialité de temps à autre. Ainsi, il vous est conseillé d’examiner cette page périodiquement pour toute modification. Je vous informera de tout changement en affichant la nouvelle politique de confidentialité sur cette page.Cette politique est efficace à compter de 2021-01-02"),
              title("Contactez-nous"),
              desc(
                  "Si vous avez des questions ou des suggestions au sujet de ma politique de confidentialité, n’hésitez pas à me contacter naim.developer@outlook.com.")
            ],
          ),
        ),
      ),
    );
  }
}

title(String tet) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Text(tet,
        style: TextStyle(fontFamily: unna, color: Colors.amber, fontSize: 23)),
  );
}

desc(String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(text,
        style: TextStyle(
          fontSize: 16,
        )),
  );
}

class Termes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[900],
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.close, color: Colors.white),
      ),
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [
              title('Conditions générales'),
              desc(
                  "En téléchargeant ou en utilisant l’application, ces termes s’appliqueront automatiquement à vous – vous devez donc vous assurer que vous les lisez attentivement avant d’utiliser l’application. Vous n’avez pas le droit de copier ou de modifier l’application, aucune partie de l’application ou nos marques de commerce de quelque manière que ce soit. Vous n’êtes pas autorisé à essayer d’extraire le code source de l’application, et vous ne devriez pas non plus essayer de traduire l’application dans d’autres langues, ou de faire des versions dérivées. L’application elle-même, ainsi que toutes les marques de commerce, le droit d’auteur, les droits de base de données et autres droits de propriété intellectuelle qui y sont liés, appartiennent toujours à Naim Abdelkerim."),
              desc(
                  "Naim Abdelkerim s’engage à faire en sorte que l’application soit aussi utile et efficace que possible. Pour cette raison, nous nous réservons le droit d’apporter des modifications à l’application ou de facturer ses services, à tout moment et pour quelque raison que ce soit. Nous ne vous facturerons jamais pour l’application ou ses services sans vous dire très clairement ce que vous payez."),
              desc(
                  "L’application Tchadia stocke et traite les données personnelles que vous nous avez fournies, afin de fournir mon Service. Il est de votre responsabilité de garder votre téléphone et l’accès à l’application sécurisés. Nous vous recommandons donc de ne pas jailbreak ou racine de votre téléphone, qui est le processus de suppression des restrictions logicielles et des limitations imposées par le système d’exploitation officiel de votre appareil. Il pourrait rendre votre téléphone vulnérable aux logiciels malveillants / virus / programmes malveillants, compromettre les fonctionnalités de sécurité de votre téléphone et cela pourrait signifier que l’application Tchadia ne fonctionnera pas correctement ou du tout."),
              desc(
                  "En ce qui concerne la responsabilité de Naim Abdelkerim pour votre utilisation de l’application, lorsque vous utilisez l’application, il est important de garder à l’esprit que, bien que nous nous efforçons de nous assurer qu’elle est mise à jour et correcte en tout temps, nous comptons sur des tiers pour nous fournir des informations afin que nous puissions les mettre à votre disposition. Naim Abdelkerim n’accepte aucune responsabilité pour toute perte, directe ou indirecte, que vous éprouvez en vous appuyant entièrement sur cette fonctionnalité de l’application."),
              desc(
                  "À un moment donné, nous pouvons souhaiter mettre à jour l’application. L’application est actuellement disponible sur Android – les exigences pour le système (et pour tous les systèmes supplémentaires que nous décidons d’étendre la disponibilité de l’application à) peuvent changer, et vous aurez besoin de télécharger les mises à jour si vous voulez continuer à utiliser l’application. Naim Abdelkerim ne promet pas qu’il sera toujours mettre à jour l’application afin qu’il soit pertinent pour vous et / ou fonctionne avec la version Android que vous avez installé sur votre appareil. Toutefois, vous promettez d’accepter toujours les mises à jour de l’application lorsqu’elle vous est offerte, Nous pouvons également vouloir cesser de fournir l’application, et peut mettre fin à son utilisation à tout moment sans vous donner d’avis de résiliation. Sauf si nous vous disons le contraire, à toute résiliation, a) les droits et licences qui vous sont accordés en ces termes se termineront; b) vous devez cesser d’utiliser l’application et (si nécessaire) la supprimer de votre appareil."),
            ],
          ),
        ),
      ),
    );
  }
}
