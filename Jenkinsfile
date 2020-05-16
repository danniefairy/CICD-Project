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
                    
                    bat "mkdir d:\\cygwin64\\home\\user\\ansible_dir"
                    bat "xcopy ansible d:\\cygwin64\\home\\user\\ansible_dir /i /o /y"
                    bat "D:\\cygwin64\\bin\\bash --login -c \"cd ansible_dir\"" 

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
    print "[INFO] ========== ${taskTitle} ${state} =========="
    if (state=="FAILURE") {
        script{
            bat "rmdir d:\\cygwin64\\home\\user\\ansible_dir /s /q"
        }
    }
    step([
        $class: "GitHubCommitStatusSetter",
        reposSource: [$class: "ManuallyEnteredRepositorySource", url: "https://github.com/danniefairy/CICD-Project"],
        contextSource: [$class: "ManuallyEnteredCommitContextSource", context: taskTitle],
        errorHandlers: [[$class: "ChangingBuildStatusErrorHandler", result: "UNSTABLE"]],
        statusResultSource: [ $class: "ConditionalStatusResultSource", results: [[$class: "AnyBuildResult", message: message, state: state]] ]
    ]);
}
