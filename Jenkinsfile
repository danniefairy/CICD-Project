pipeline {
    agent any
    stages {
        stage('--install-package--') {
            steps {
                script{
                    print "[STAGE] ========== install package =========="
                    env.StepName = "Install Package"
                }
            }
            post{
                success{
                    print "[INFO] ========== pass install package stage =========="
                    setBuildStatus("Build succeeded", "SUCCESS", "${env.StepName}");
                }
                failure{
                    print "[INFO] ========== fail to pass install package stage =========="
                    setBuildStatus("Build failed", "FAILURE", "${env.StepName}");
                }
            }
        }
        stage('--run-test--') {
            steps {
                script{
                    print "[STAGE] ========== run test =========="
                    env.StepName = "Run Test"
                }
            }
            post{
                success{
                    print "[INFO] ========== pass run test stage =========="
                    setBuildStatus("Build failed", "FAILURE", "${env.StepName}");
                }
                failure{
                    print "[INFO] ========== fail to pass run test stage =========="
                    setBuildStatus("Build failed", "FAILURE", "${env.StepName}");
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
