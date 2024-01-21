
Company Profile :

Staret Foods is specialized for the elderly based on their dietary needs. Staret Foods mainly serves Singapore. Their main target group is people who are over 60 and have special dietary needs. Even though there are many food delivery services in the market, Staret Foods is the monopoly in the elder’s food business. Since its focus group is the elderly, Staret Foods wants to maintain their website as easily accessible and more secure from vulnerabilities. I have been approached with the above requirement from Staret Foods, and my suggestion is to use ECS with Terraform infrastructure using the Far Gate (serverless) platform. As a cloud infrastructure engineer, I extended my support to make their application more secure and reliable based on the cloud DevSecOps approach in an automated CI/CD pipeline. Technical recommendations are as follows in detail:

Cloud infrastructure dependencies:

AWS ECS with Far gate is a serverless computing platform that makes running containerized services on AWS easier than ever before. With Far gate, a user simply defines the compute resources, such as CPU and memory, that a service will need to run, and Far gate will manage where to run the container behind the scenes. There is no point where setting up an EC2 instance is required. Terraform is an infrastructure-as-code tool created by Hashicorp to make handling infrastructure more straightforward and manageable.  

Technical dependencies :


Project Name: Starets-Foods

Repository: https://github.com/Pritanu07/staret-foods

1.Create a new repository on GitHub and give public access and correct access to the group members as collaborators.

2.Docker containerized application is used in serverless Far gate environment. The docker images are created and stored in Elastic Container Registry then pushed for git action.

3.Once images are pushed into ECR then integrate the code pipeline.

CICD script should be written for each affected branch to automate the build, test, and deployment process. The Docker images can be built, tests can be run, and the application can be deployed to the staging environment using the CICD script. Once it passes all tests, it can be promoted to the production environment. Proper authentication and authorization are to be ensured in each stage of CI and CD

Proper handling of Security in each stage of CI/CD pipeline:

•	By default, ECR is encrypted in transit and pushed to git action. implement IAM role to access git repository. Also ensure bucket policies for IAM users.
•	Protect repositories using access keys and secret keys from public access.
•	Create branches for teams (development Team, Staging team, Production Team)
•	Provide access credentials for each team and get authenticated whenever commit changes.
•	Differentiate the main from the branches and it should be protected from unauthorized team member access.
•	Run unit testing and Integrated Testing in production environment, changes can be updated in development environment. If passed, then pull to main and commit change in it.



                              ECR-ECS- CI/CD pipeline workflow diagram

<img width="488" alt="image" src="https://github.com/Pritanu07/staret-foods/assets/127757033/e6869df0-317b-40d5-8bbd-94462a9eb319">



 


                                                   
