pipeline {
    agent any
    environment {
	    release_cloc = "ysebastia/cloc:1.90"
	    release_csslint = "ysebastia/csslint:1.0.5"
	    release_doxygen = "ysebastia/doxygen:1.9.2"
	    release_jshint = "ysebastia/jshint:2.13.2"
	    release_shellcheck = "ysebastia/shellcheck:0.7.2"
    }
    stages {
        stage ('Checkout') {
            agent any
            steps {
                checkout([
                	$class: 'GitSCM',
                	branches: [[name: '*/main']],
                	extensions: [[$class: 'CleanBeforeCheckout', deleteUntrackedNestedRepositories: true]],
                	userRemoteConfigs: [[url: 'https://github.com/ysebastia/docker.git']]
            	])
            }
        }
        stage('QA') {
		    parallel {
                stage ('cloc') {
      		        agent {
        		        dockerfile {
            		        dir 'src/cloc'
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
	        	stage ('hadolint') {
	            	agent {
	              		docker {
                        	image 'docker.io/hadolint/hadolint:v2.8.0-alpine'
                    	}
	        		}
	            	steps {
	                	sh 'touch hadolint.json'
	                	sh 'hadolint -f json src/*/Dockerfile | tee -a hadolint.json'
	            		recordIssues( healthy: 1, unhealthy: 2, tools: [
	                  		hadoLint(pattern: 'hadolint.json')
	                	])
	              		archiveArtifacts artifacts: 'hadolint.json', followSymlinks: false
	              		sh 'rm hadolint.json'
	            	}
	        	}
                stage ('shellcheck') {
      		        agent {
        		        dockerfile {
            		        dir 'src/shellcheck'
            		        filename 'Dockerfile'
         		        }
      		        }
      		        steps {
      		        	sh 'touch shellcheck.xml'
      		            sh '/usr/local/bin/shellcheck.bash ./src/ | tee -a shellcheck.xml'
            			recordIssues(tools: [
              				checkStyle(pattern: 'shellcheck.xml')
            			])
            			archiveArtifacts artifacts: 'shellcheck.xml', followSymlinks: false
            	        sh 'rm shellcheck.xml'
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
                                docker.build("${env.release_cloc}", "src/cloc").push()
                            }
                        }
                    }
                }
                stage('csslint') {
                    agent any
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_csslint}", "src/csslint").push()
                            }
                        }
                    }
                }
                stage('doxygen') {
                    agent any
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_doxygen}", "src/doxygen").push()
                            }
                        }
                    }
                }
                stage('jshint') {
                    agent any
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_jshint}", "src/jshint").push()
                            }
                        }
                    }
                }
                stage('shellcheck') {
                    agent any
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_shellcheck}", "src/shellcheck").push()
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