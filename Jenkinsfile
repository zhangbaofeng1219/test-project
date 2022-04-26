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
                        echo "start prepare ..."
                        sh "sh ./run-bk_prepare.sh ${nodeIp01} ${nodeIp02} ${nodeIp03} ${node_pwd}"
                        echo "start install ..."
                        sh "sh ./run-bk_install.sh ${domain} ${bk_psd}"
                        sh "finished"
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
