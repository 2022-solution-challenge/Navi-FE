> GDSC Gwangju Institute of Science and Technology


> Team Member : Choi Eungi, Kwon Hyojae, Bae Seolyeong


> Development Duration : 2022.02.15 ~ 2022.03.31



1. Project Introduction
    
     Navi is an application for help children from going into dangerous locations.
    
     We felt the seriousness of **children's traffic accidents** and carried out the project to strengthen the **social safety** net through this.
    
2. Goal
    
     Globally, road traffic injuries are the leading cause of death in 10–19 year olds, according to the WHO report “Children and road traffic injury” in 2018. Also, it is predicted that they will be the fifth leading cause of death worldwide in High-income country. Especially, Rates of road traffic death among children are 3 times higher in low- and middle-income countries than in high-income countries
    
    Through this, we know that children's traffic accidents are a global problem, and we want to solve it technically. We address No Poverty, Sustainable Cities and Communities in SDGs.
    
    
    <img width="1000" alt="goal" src="https://user-images.githubusercontent.com/80435616/161185226-2a20ca15-d74b-4567-9cc9-518ae7846e03.png">
    
3. Project Architecture

     The front-end part developed the app using Flutter, a framework of Dart. We chose Flutter because it supports cross platform. One of the important elements of a solution that addresses the SDGs is that it must be usable by everyone. 
    
     Backend implemented API server using Java-based Spring boot framework, and database used MySQL. The reason we used this was because I thought that Spring Boot was the best way to consider the scalability of the service and write the code in a consistent structure, so I implemented it as follows. I used MySQL because I wanted to keep data consistent and stable. 
     
     To deploy the API server, we deployed Google Cloud's Cloud Run. Because Cloud Run is a fully managed container service, it was easy to proceed with the deployment. Not only that, the database was also coded using Cloud SQL. 
     
     <p align = "center">
  <img width = 500px  src="https://user-images.githubusercontent.com/70755947/160151643-ae8a6f48-d1f0-485a-b888-f8c024006420.png">
</p>
    


4. Solution
    
    We received the US Car Accident Data and provided the accident-prone section on the child's route as a Google Map. This allows us to define accident-prone areas and provide users with information about them. In addition to simply providing information through accident area data, users can add accident-prone area information and empathize with it. This provides a community function and provides a means to complement child safety.
    
    
      Parents can check the real-time movement path of their child. Provides information about your child's real-time location. This allows parents to check the status of their child's return home. This can help parents control their children.
      
      
      If you enter a destination, it provides a function that recommends a route to the child with the fewest accident-prone areas. By providing the path with the least amount of accidents, we help your child go on a safer path. 
 <img width="1920" alt="readme1" src="https://user-images.githubusercontent.com/80435616/161185248-f548c809-36eb-4d29-aa0a-0acd1cd42d6d.png">
<img width="1920" alt="readme2" src="https://user-images.githubusercontent.com/80435616/161185255-cd4f56a3-f351-433f-a68a-a6b0f9ff287f.png">
<img width="1920" alt="readme3" src="https://user-images.githubusercontent.com/80435616/161185260-c36a7d54-40c8-42a5-92aa-5e1db5a6f747.png">

    
5. Demo Video
6. Getting Started 
    1. Download Navi.apk via [link](https://drive.google.com/file/d/1UdEyV9IVIIPfSo4ZGRFxg46VksZaEzpx/view?usp=sharing)(for Andriod OS)
    2. Run App on Emulator(need .env and main/AndriodManifest file for API KEY)
    
    ```jsx
    #Clone Repository
    git clone https://github.com/2022-solution-challenge/Navi-FE.git
    
    #Move to the folder
    cd Navi-FE
    
    #run flutter(your emulator should be turnd on)
    flutter run
    ```
    
7. Contributors

| Name | Choi Eungi(Back-End) | Kwon Hyojae(Front-End) | Bae Seolyeong(Front-End) |
| --- | --- | --- | --- |
| Contacts |  |  |  |
