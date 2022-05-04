pipeline {

    agent any
    
    environment {
	DOCKERHUB_CREDENTIALS=credentials('dockerhub')
	}
	
    stages {
        stage('Build') { 
            steps {                
              sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
	      sh 'docker build -t minha-imagem-nginx-bill .'  
              sh 'docker tag minha-imagem-nginx-bill guilhermeauras/minha-imagem-nginx-bill:latest'
              sh 'docker push guilhermeauras/minha-imagem-nginx-bill:latest'
            }
        }
        stage('Test') { 
            steps {
	      sh 'docker run -it guilhermeauras/minha-imagem-nginx-bill:latest /bin/bash -c "nginx -t" | grep ok | if [ $? -eq 0 ]; then echo sucesso; else exit 1; fi'
            }
        }
        stage('Package') { 
            steps {
              sh 'tar cfz arquivos.tgz *'
	      sh 'mv arquivos.tgz /tmp/'
	      sh 'ls -l /tmp/arquivos.tgz | grep arquivos.tgz | if [ $? -eq 0 ]; then echo sucesso; else exit 1; fi'	    
            }
        }
        stage('Deploy') { 
            steps {
	      sh 'sshpass -p jenkins scp /tmp/arquivos.tgz jenkins@192.168.0.100:/home/jenkins/DevOps/deploy/'	   
	      sh 'sshpass -p "jenkins" ssh jenkins@192.168.0.100 tar xfz /home/jenkins/DevOps/deploy/arquivos.tgz -C /home/jenkins/DevOps/deploy/'		    
            }
        }    		
        stage('Checkout') { 
            steps {
              sh 'echo checkout' 
            }
        }
        stage('Notificationt') { 
            steps {
              sh 'echo notification futuro via slack'		    
            }
        }  
        stage('Clean') { 
            steps {
              sh 'rm /tmp/arquivos.tgz'
	      sh 'docker image rm minha-imagem-nginx-bill'
	      sh 'docker image rm nginx'	    
            }
        } 	    
    }
}
