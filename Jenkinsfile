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
                    print "[STAGE] ========== ${StepName} =========="
                    bat "D:\\cygwin64\\bin\\bash --login -c \"ansible --version\""
                    bat "D:\\cygwin64\\bin\\bash --login -c \"docker ps\""    
                }
            }
            post{
                success{
                    print "[INFO] ========== ${StepName} successed =========="
                    setBuildStatus("Build succeeded", "SUCCESS", "${StepName}");
                }
                failure{
                    print "[INFO] ========== ${StepName} failed =========="
                    setBuildStatus("Build failed", "FAILURE", "${StepName}");
                }
            }
        }
        stage('--run-test--') {
            steps {
                script{
                    StepName = "Run Test"
                    print "[STAGE] ========== ${StepName} =========="
                }
            }
            post{
                success{
                    print "[INFO] ========== ${StepName} successed =========="
                    setBuildStatus("Build succeeded", "SUCCESS", "${StepName}");
                }
                failure{
                    print "[INFO] ========== ${StepName} failed =========="
                    setBuildStatus("Build failed", "FAILURE", "${StepName}");
                }
            }
        }
    }
}

void setBuildStatus(String message, String state, String taskTitle) {
  step([
      $class: "GitHubCommitStatusSetter",
      reposSource: [$class: "ManuallyEnteredRepositorySource", url: "https://github.com/danniefairy/CICD-Project"],
      contextSource: [$class: "ManuallyEnteredCommitContextSource", context: taskTitle],
      errorHandlers: [[$class: "ChangingBuildStatusErrorHandler", result: "UNSTABLE"]],
      statusResultSource: [ $class: "ConditionalStatusResultSource", results: [[$class: "AnyBuildResult", message: message, state: state]] ]
  ]);
}
