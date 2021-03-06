pipeline {
    agent any
    options {
        timeout(time: 1, unit: 'HOURS') 
    }
    stages {
        stage('[Prepare component]') {
            steps {
                script{
                    StepName = "${env.STAGE_NAME}"

                    // Prepare the ansible files.
                    bat "./scripts/prepare_ansible_files.bat"

                    // Prepare the binary file and _build directory.
                    bat "./scripts/prepare_binary.bat"
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

                    // Prepare the config file
                    // Deploy stage container
                    // Run test
                    bat "./scripts/prepare_config_file.bat stage"
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

                    // Deploy production container
                    // Deploy load balancer
                    bat "./scripts/prepare_config_file.bat production"
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
