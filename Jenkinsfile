pipeline {
    agent any
    environment {
	    release_cloc = "ysebastia/cloc:1.90"
	    release_csslint = "ysebastia/csslint:1.0.5"
    }
    stages {
        stage ('Checkout') {
            agent any
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [[$class: 'CleanBeforeCheckout', deleteUntrackedNestedRepositories: true]], userRemoteConfigs: [[url: 'https://github.com/ysebastia/docker.git']]])
            }
        }
        stage('QA') {
		    parallel {
                stage ('cloc') {
      		        agent {
        		        dockerfile {
            		        dir 'cloc'
            		        filename 'Dockerfile'
         		        }
      		        }
      		        steps {
      		            sh 'cloc --by-file --xml --fullpath --not-match-d="(build|vendor)" --out=build/cloc.xml ./'
            	        sloccountPublish encoding: '', pattern: 'build/cloc.xml'
            	        archiveArtifacts artifacts: 'build/cloc.xml', followSymlinks: false
            	        sh 'rm build/cloc.xml'
      		        }
                }
	        	stage ('Hadolint') {
	            	agent {
	              		docker {
                        	image 'docker.io/hadolint/hadolint:v2.8.0-alpine'
                    	}
	        		}
	            	steps {
	                	sh 'touch hadolint.json'
	                	sh 'hadolint -f json */Dockerfile | tee -a hadolint.json'
	            		recordIssues( healthy: 1, unhealthy: 2, tools: [
	                  		hadoLint(pattern: 'hadolint.json')
	                	])
	              		archiveArtifacts artifacts: 'hadolint.json', followSymlinks: false
	              		sh 'rm hadolint.json'
	            	}
	        	}
		    }
        }
        stage('Build') {
            parallel {
                stage('cloc') {
                    agent any
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_cloc}", "cloc").push()
                            }
                        }
                    }
                }
                stage('csslint') {
                    agent any
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_csslint}", "csslint").push()
                            }
                        }
                    }
                }
            }
        }
    }
    post {
       always {
         cleanWs()
       }
    }
}