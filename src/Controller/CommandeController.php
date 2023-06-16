<?php

namespace App\Controller;

use Datetime;
use App\Entity\Commande;
use App\Entity\Vehicule;
use App\Form\CommandeType;
use App\Repository\CommandeRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Core\User\UserInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class CommandeController extends AbstractController
{

    #[Route('/commande', 'commandes')]
    public function commandeView(CommandeRepository $repo): Response
    {
        $commande = $repo->findAll();

        return $this->render('commande/index.html.twig', [
            'commandes' => $commande
        ]);
    }

    // #[Route('/commande/add/{idVehicule}', name: 'commandeAdd')]
    // public function commandeAdd(Request $request, EntityManagerInterface $entityManager, UserInterface $user, int $idVehicule): Response
    // {

    //     $vehicule = $entityManager->getRepository(Vehicule::class)->find($idVehicule);
    // if (!$vehicule) {
    //     throw $this->createNotFoundException('Véhicule non trouvé');
    // }

    // $commande = new Commande();
    // $commande->setUser($user);
    // $commande->setVehicule($vehicule);

    //     $commande = new Commande();


    //     $form = $this->createForm(CommandeType::class, $commande);
    //     $form->handleRequest($request);

    //     if ($form->isSubmitted() && $form->isValid()) {


    //         // $vehicule = $commande->getVehicule();
    //         $commande->setDateEnregistrement(new Datetime());

    //         $dateHeureDepart = $commande->getDateHeureDepart();
    //         $dateHeureFin = $commande->getDateHeureFin();

    //         // Calculer la durée en jours
    //         $diff = $dateHeureFin->diff($dateHeureDepart);
    //         $nombreJours = $diff->days;

    //         // Récupérer le prix unitaire (vous devez l'adapter en fonction de votre logique)
    //         $prixUnitaire = $commande->getVehicule()->getPrixJournalier(); // Supposons que vous ayez une relation "produit" dans votre entité Commande

    //         // Calculer le prix total
    //         $prixTotal = $prixUnitaire * $nombreJours;
    //         $commande->setPrixTotal($prixTotal);

    //         $entityManager->persist($commande);
    //         $entityManager->flush();
    //         // do anything else you need here, like send an email
    //         $this->addFlash('success', "Nickel");
    //         return $this->redirectToRoute('voitures');
    //     }

    //     return $this->render('commande/commande.html.twig', [
    //         'formCommande' => $form->createView(),
    //         'idVehicule' => $idVehicule


    //     ]);





    //     return $this->render('commande/add.html.twig', []);
    // }




    #[Route('/commande/add/{id}', name: 'commandeAdd')]
    public function commandeAdd(Request $request, EntityManagerInterface $entityManager, UserInterface $user, Vehicule $vehicule = null): Response
    {
        if ($vehicule == null) {
            return $this->redirectToRoute('app');
        }
        $commande = new Commande();
        $commande->setUser($user);
        $commande->setVehicule($vehicule);

        $form = $this->createForm(CommandeType::class, $commande);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $commande->setDateEnregistrement(new DateTime());

            $dateHeureDepart = $commande->getDateHeureDepart();
            $dateHeureFin = $commande->getDateHeureFin();

            // Calculer la durée en jours
            $diff = $dateHeureFin->diff($dateHeureDepart);
            $nombreJours = $diff->days;

            // Récupérer le prix unitaire (vous devez l'adapter en fonction de votre logique)
            $prixUnitaire = $commande->getVehicule()->getPrixJournalier();

            // Calculer le prix total
            $prixTotal = $prixUnitaire * $nombreJours;
            $commande->setPrixTotal($prixTotal);

            $entityManager->persist($commande);
            $entityManager->flush();

            $this->addFlash('success', "Commande passée avec succès !");
            return $this->redirectToRoute('voiture');
        }

        return $this->render('commande/commande.html.twig', [
            'formCommande' => $form->createView(),
            'vehicule' => $vehicule
        ]);
    }
}
