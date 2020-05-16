pipeline {
    agent any
    options {
        timeout(time: 1, unit: 'HOURS') 
    }
    stages {
        stage('[Prepare]') {
            steps {
                script{
                    StepName = "Install Package"
                    
                    bat "mkdir d:\\cygwin64\\home\\user\\ansible_dir"
                    bat "xcopy ansible d:\\cygwin64\\home\\user\\ansible_dir /i /o /y"
                    bat "D:\\cygwin64\\bin\\bash --login -c \"cd ansible_dir && ansible-playbook  playbook.yml\"" 

                    bat "rmdir d:\\cygwin64\\home\\user\\ansible_dir /s /q"

                    print " stage name: ${env.STAGE_NAME}"
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
                    print " stage name: ${env.STAGE_NAME}"
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
