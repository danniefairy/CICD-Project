pipeline {
    agent any
    options {
        timeout(time: 1, unit: 'HOURS') 
    }
    stages {
        stage('[Prepare ansible files]') {
            steps {
                script{
                    StepName = "${env.STAGE_NAME}"
                    bat "./scripts/prepare_ansible_files.bat"
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
        stage('[Deploy and test on stage]') {
            steps {
                script{
                    StepName = "${env.STAGE_NAME}"
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
        stage('[Deploy on production]') {
            steps {
                script{
                    StepName = "${env.STAGE_NAME}"
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
    // Clean up the ansible dir and containers if the pipeline fails.
    if (state=="FAILURE") {
        script{
            bat "./scripts/cleanup.bat"
        }
    }

    // Send the commit status to github.
    step([
        $class: "GitHubCommitStatusSetter",
        reposSource: [$class: "ManuallyEnteredRepositorySource", url: "https://github.com/danniefairy/CICD-Project"],
        contextSource: [$class: "ManuallyEnteredCommitContextSource", context: taskTitle],
        errorHandlers: [[$class: "ChangingBuildStatusErrorHandler", result: "UNSTABLE"]],
        statusResultSource: [ $class: "ConditionalStatusResultSource", results: [[$class: "AnyBuildResult", message: message, state: state]] ]
    ]);
}
