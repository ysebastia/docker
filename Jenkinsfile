pipeline {
    agent any
    environment {
		release_ansiblelint = "ysebastia/ansible-lint:4.3.7"
		release_cloc = "ysebastia/cloc:1.90"
		release_csslint = "ysebastia/csslint:1.0.5"
		release_dmarctsreportparser = "ysebastia/dmarcts-report-parser:master-debian11.1-slim-4"
		release_dmarctsreportviewer = "ysebastia/dmarcts-report-viewer:master-php8.1.2-4"
		release_doxygen = "ysebastia/doxygen:1.9.2"
		release_jshint = "ysebastia/jshint:2.13.2"
		release_phpcpd = "ysebastia/phpcpd:6.0.3-php7.4.27-1"
		release_phpcs = "ysebastia/phpcs:3.6.2-php7.4.27-1"
		release_phpmd = "ysebastia/phpmd:2.11.1-php7.4.27-4"
		release_pylint = "ysebastia/pylint:2.10.2-r1-1"
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
                stage('ansible-lint') {
                    agent any
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_ansiblelint}", "src/ansible-lint").push()
                            }
                        }
                    }
                }
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
                stage('dmarcts-report-parser') {
                    agent any
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_dmarctsreportparser}", "src/dmarcts-report-parser").push()
                            }
                        }
                    }
                }
                stage('dmarcts-report-viewer') {
                    agent any
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_dmarctsreportviewer}", "src/dmarcts-report-viewer").push()
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
                stage('phpcpd') {
                    agent any
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_phpcpd}", "src/phpcpd").push()
                            }
                        }
                    }
                }
                stage('phpcs') {
                    agent any
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_phpcs}", "src/phpcs").push()
                            }
                        }
                    }
                }
                stage('phpmd') {
                    agent any
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_phpmd}", "src/phpmd").push()
                            }
                        }
                    }
                }
                stage('pylint') {
                    agent any
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_pylint}", "src/pylint").push()
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