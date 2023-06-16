<?php

namespace App\Controller;

use App\Entity\Vehicule;
use App\Repository\VehiculeRepository;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class AppController extends AbstractController
{
    #[Route('/', name: 'home')]
    public function index(): Response
    {
        return $this->render('app/index.html.twig', [
            'controller_name' => 'AppController',
        ]);
    }

    #[Route('/vehicule', 'voiture')]
    public function voitureView(VehiculeRepository $repo): Response
    {

        $voitures=$repo->findAll();

        return $this->render('app/voitures.html.twig', [
            'voitures'=>$voitures
        ]);

       
    }

    #[Route('/vehicule/show/{id}', 'voitureShow')]
    public function voitureShow(Vehicule $vehicule): Response
    {

        return $this->render('app/showVehicule.html.twig', [
            'vehicule'=>$vehicule
        ]);

       
    }

}
