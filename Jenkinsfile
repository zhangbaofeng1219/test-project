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
                        echo "开始执行环境准备 ..."
                        sh 'sh ./run-bk_prepare.sh 192.168.197.133 192.168.197.131 192.168.197.132 123456'
                    }
                    if (action == 'install') {
                        
                    }
                    if (action == 'remove') {
                       
                    }
                }
            }
        }
    }
}
