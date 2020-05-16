pipeline {
    agent any
    options {
        timeout(time: 1, unit: 'HOURS') 
    }
    stages {
        stage('--install-package--') {
            steps {
                script{
                    StepName = "Install Package"
                    
                    bat "mkdir d:\\cygwin64\\home\\user\\Ansible"
                    bat "xcopy ansible d:\\cygwin64\\home\\user\\Ansible /i /o /y"
                    bat "D:\\cygwin64\\bin\\bash --login -c \"cd Ansible && ansible-playbook  playbook.yml\"" 

                    bat "rmdir d:\\cygwin64\\home\\user\\Ansible /s /q"
                }
            }
            post{
                success{
                    setBuildStatus("Build succeeded", "SUCCESS", "${StepName}");
                }
                failure{
                    setBuildStatus("Build failed", "FAILURE", "${StepName}");
                }
            }
        }
        stage('--run-test--') {
            steps {
                script{
                    StepName = "Run Test"
                }
            }
            post{
                success{
                    setBuildStatus("Build succeeded", "SUCCESS", "${StepName}");
                }
                failure{
                    setBuildStatus("Build failed", "FAILURE", "${StepName}");
                }
            }
        }
    }
}

void setBuildStatus(String message, String state, String taskTitle) {
    print "[INFO] ========== ${taskTitle} ${state} =========="
    step([
        $class: "GitHubCommitStatusSetter",
        reposSource: [$class: "ManuallyEnteredRepositorySource", url: "https://github.com/danniefairy/CICD-Project"],
        contextSource: [$class: "ManuallyEnteredCommitContextSource", context: taskTitle],
        errorHandlers: [[$class: "ChangingBuildStatusErrorHandler", result: "UNSTABLE"]],
        statusResultSource: [ $class: "ConditionalStatusResultSource", results: [[$class: "AnyBuildResult", message: message, state: state]] ]
    ]);
}
