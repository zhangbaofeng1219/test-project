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
                        sh "sh ./run-bk_prepare.sh ${nodeIp01} ${nodeIp02} ${nodeIp03} ${node_pwd}"
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
