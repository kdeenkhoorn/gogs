    pipeline {

        agent {
            label 'armhf'
        }

        environment {
            GOGSVER=0.11.91
            GOVER=1.12.9
        }

        options {
            buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '5')
        }

        triggers {
           GenericTrigger (
               causeString: 'Push by: $ACTOR on Ref: $REF',
               genericVariables: [
    	            [defaultValue: '', key: 'ACTOR', regexpFilter: '', value: '$.pusher.username'],
    	            [defaultValue: '', key: 'REF', regexpFilter: '', value: '$.ref'],
               ],
               regexpFilterExpression: '',
               regexpFilterText: '',
               token: '1612d51aab91ad61b7345e56f4f5a8b4dae70b06' )
        }

        stages {
            stage ('Build gogs docker image') {
                steps {
                    /* Build gogs image */
                    sh "cd ./build-context \
                        && docker build --build-arg GOGSVER=${GOGSVER} --build-arg GOVER=${GOVER} -t kdedesign/gogs:${GOGSVER} . \
                        && docker tag kdedesign/gogs:${GOGSVER} kdedesign/gogs:latest"
                }
            }
            stage ('Publish gogs docker image to Docker Hub') {
                steps {
                    /* Docker push buildresult to Docker Hub*/
                    withDockerRegistry(credentialsId: 'dockerhubaccount', url: '') {
                        sh "docker push kdedesign/gogs:latest \
                            && docker push kdedesign/gogs:${GOGSVER}"
                    }
                }
            }
        }
    }

