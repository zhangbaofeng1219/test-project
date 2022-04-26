pipeline {
    agent {
                node{
                    label 'TestBkNode01'
                } 
                 
            }

    stages {
        stage('Prepare...') {
            
            steps {
                script {
                   
                    if (action == 'prepare') {
                        echo "test ..."
                        sh 'hostname'
                    }
                    if (action == 'install2') {
                        
                    }
                    if (action == 'delete') {
                       
                    }
                }
            }
        }
    }
}
