<?php

namespace App\Controller;

use App\Entity\Vehicule;
use App\Form\VehiculeFormType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class AdminController extends AbstractController
{
    #[Route('/admin', name: 'app_admin')]
    public function index(): Response
    {
        return $this->render('admin/accueil.html.twig', [
           
        ]);
    }

    #[Route('/voiture', name:'voiture')]
    public function voitureAll(): Response
    {

        

        return $this->render('admin/index.html.twig');
    }

    #[Route('/admin/edit/{id}', name: "adminEdit")]
    #[Route('/admin/add', name: 'adminAdd')]
    public function register(Request $request, EntityManagerInterface $entityManager, Vehicule $vehicule = null ): Response
    {
        if ($vehicule == null) {
         $vehicule = new Vehicule();
        }
        
        $form = $this->createForm(VehiculeFormType::class, $vehicule);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            // encode the plain password
            
            $vehicule->setDateEnregistrement(new \Datetime());
            $entityManager->persist($vehicule);
            $entityManager->flush();
            // do anything else you need here, like send an email
            $this->addFlash('success', "Vehicule enregistré !");
            return $this->redirectToRoute('home');
        }

        return $this->render('admin/formVehicule.html.twig', [
            'formVehicule' => $form->createView(),
            'editMode' => $vehicule->getId()!=null
        ]);
    }

    #[Route('/admin/vehicule/delete/{id}', name: 'admin_article_delete')]
    public function deleteArticle(Vehicule $vehicule, EntityManagerInterface $manager){
        $manager->remove($vehicule);
        $manager->flush();
        $this->addFlash('success', "Le vehicule à bien été supprimé !");
        return $this->redirectToRoute('admin_article');
    }

    

}

