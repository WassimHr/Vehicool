<?php

namespace App\Controller;

use App\Entity\User;
use App\Form\UserType;
use App\Repository\UserRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;

class UserController extends AbstractController
{
    #[Route('/user', name: 'users')]
    public function index(UserRepository $repo): Response
    {
        $users=$repo->findAll();

        return $this->render('user/index.html.twig', [
            'users'=>$users
        ]);
    }

  
    
   
    #[Route('/user/add', name: 'userAdd')]
    public function register(Request $request, EntityManagerInterface $entityManager,UserPasswordHasherInterface $userPasswordHasher, User $user): Response
    {
        
         $user = new User();
        
        
        $form = $this->createForm(UserType::class, $user);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            // encode the plain password
            $user->setRoles(["ROLE_USER"]);
            $user->setPassword(
                $userPasswordHasher->hashPassword(
                    $user,
                    $form->get('plainPassword')->getData()
                )
            );
          
            $user->setDateEnregistrement(new \Datetime());
            $entityManager->persist($user);
            $entityManager->flush();
            // do anything else you need here, like send an email
            $this->addFlash('success', "Vous êtes inscrit !");
            return $this->redirectToRoute('home');
        }

        return $this->render('user/form.html.twig', [
            'formUser' => $form->createView(),
            
            
        ]);
    } 
    
    #[Route('/admin/editUser/{id}', name: "roleEdit")] 
    public function editRole(Request $request, User $user, EntityManagerInterface $entityManager){

        if (!empty([$_POST])) {
            if($request->request->get('role') == "admin"){
                $user->setRoles(['ROLE_ADMIN']);
            }
            else {$user->setRoles(['ROLE_USER']);}
            

            $entityManager->persist($user);
            $entityManager->flush();
        }

           
            // return $this->redirectToRoute('users');
        return $this->render('admin/userEdit.html.twig', [
            'user' => $user->getId()!=null       
        ]);
    }
    // 'editMode' => $user->getId()!=null, 
}





// #[Route('/user/edit/{id}', name: "userEdit")]
//     #[Route('/user/add', name: 'userAdd')]
//     public function register(Request $request, EntityManagerInterface $entityManager,UserPasswordHasherInterface $userPasswordHasher, User $user = null ): Response
//     {
//         if ($user == null) {
//          $user = new User();
//         }
        
//         $form = $this->createForm(UserType::class, $user);
//         $form->handleRequest($request);

//         if ($form->isSubmitted() && $form->isValid()) {
//             // encode the plain password
//             $user->setRoles(["ROLE_USER"]);
//             $user->setPassword(
//                 $userPasswordHasher->hashPassword(
//                     $user,
//                     $form->get('plainPassword')->getData()
//                 )
//             );
          
//             $user->setDateEnregistrement(new \Datetime());
//             $entityManager->persist($user);
//             $entityManager->flush();
//             // do anything else you need here, like send an email
//             $this->addFlash('success', "Vous êtes inscrit !");
//             return $this->redirectToRoute('home');
//         }

//         return $this->render('user/form.html.twig', [
//             'formUser' => $form->createView(),
//             'editMode' => $user->getId()!=null, 
            
//         ]);
//     }