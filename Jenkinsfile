pipeline {
    agent {
                node{
                    label 'TestBkNode01'
                }

            }

    stages {
        stage('INSTALL') {

            steps {
                script {

                    if (action == 'prepare') {
                        echo "prepare START"
                        sh "sh ./run-bk_prepare.sh ${nodeIp01} ${nodeIp02} ${nodeIp03} ${node_pwd} ${domain} ${bk_pwd}"
                        echo "prepare END"
                    }
                    if (action == 'install') {
                        echo "install START"
                        sh "sh ./run-bk_install.sh ${nodeIp01} ${nodeIp02} ${nodeIp03} ${node_pwd} ${domain} ${bk_pwd}"
                        echo "install END"
                    }

                    if (action == 'install2') {
                        echo "install2 START"
                        sh "sh ./run-bk_install2.sh"
                        echo "install2 END"
                     }
                    if (action == 'remove') {
                        echo "remove START"
                        sh "sh ./run-bk_delete.sh "
                        echo "remove END"
                    }
                     echo "finished"
                }
            }
        }
    }
}