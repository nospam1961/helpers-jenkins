pipeline {
    agent {
        node {
            // Cloud node with this label should be setup under:
            //   "Manage Jenkins" | Clouds | docker | "Docker Agent Template"
            label 'docker-agent-python'
        }
    }
    triggers {
        pollSCM 'H/5 * * * *'
    }
    stages {
        stage('Build') {
            steps {
                echo "Building.."
                sh '''
                cd myapp
                python -m venv ./.venv
                . .venv/bin/activate
                pip install -r requirements.txt
                deactivate
                '''
            }
        }
        stage('Test') {
            steps {
                echo "Testing.."
                sh '''
                cd myapp
                . .venv/bin/activate
                python3 hello.py
                python3 hello.py --name=Donald
                deactivate
                '''
            }
        }
        stage('Deliver') {
            steps {
                echo 'Deliver....'
                sh '''
                echo "doing delivery stuff.."
                '''
            }
        }
    }
}