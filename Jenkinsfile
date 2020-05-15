pipeline {
    agent any
    stages {
        stage('--install-package--') {
            steps {
                script{
                    print "[STAGE] ========== install package =========="
                }
            }
            post{
                success{
                    print "[INFO] ========== pass install package stage =========="
                    setBuildStatus("Build succeeded", "SUCCESS", "Install Package");
                }
                failure{
                    print "[INFO] ========== fail to pass install package stage =========="
                    setBuildStatus("Build failed", "FAILURE", "Install Package");
                }
            }
        }
        stage('--run-test--') {
            steps {
                script{
                    print "[STAGE] ========== run test =========="
                }
            }
            post{
                success{
                    print "[INFO] ========== pass run test stage =========="
                    setBuildStatus("Build succeeded", "SUCCESS", "Run Test");
                }
                failure{
                    print "[INFO] ========== fail to pass run test stage =========="
                    setBuildStatus("Build failed", "FAILURE", "Run Test");
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
