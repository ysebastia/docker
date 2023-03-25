pipeline {
    agent any
    environment {
    release_ansiblelint = "ysebastia/ansible-lint:6.14.3"
    release_cloc = "ysebastia/cloc:1.96"
    release_csslint = "ysebastia/csslint:1.0.5"
    release_dmarctsreportparser = "ysebastia/dmarcts-report-parser:master-debian11.1-slim-5"
    release_dmarctsreportviewer = "ysebastia/dmarcts-report-viewer:master-php8.1.17"
    release_doxygen = "ysebastia/doxygen:1.9.6"
    release_hadolint = "ysebastia/hadolint:2.12.0-1"
    release_jshint = "ysebastia/jshint:2.13.6"
    release_phpcpd = "ysebastia/phpcpd:6.0.3-php8.1.17"
    release_phpcs = "ysebastia/phpcs:3.7.2-php8.1.17"
    release_phpmd = "ysebastia/phpmd:2.13.0-php8.1.17"
    release_pylint = "ysebastia/pylint:2.17.1"
    release_shellcheck = "ysebastia/shellcheck:0.9.0-2"
    release_tflint = "ysebastia/tflint:0.45.0"
    release_wget = "ysebastia/wget:1.21.3-r3"
    release_yamllint = "ysebastia/yamllint:1.30.0"
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
                    dockerfile {
                        dir 'src/hadolint'
                        filename 'Dockerfile'
                     }
                  }
                steps {
                    sh 'touch hadolint.json'
                    sh '/usr/local/bin/hadolint.bash | tee -a hadolint.json'
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
                      sh '/usr/local/bin/shellcheck.bash | tee -a shellcheck.xml'
                  recordIssues(tools: [
                      checkStyle(pattern: 'shellcheck.xml')
                  ])
                  archiveArtifacts artifacts: 'shellcheck.xml', followSymlinks: false
                      sh 'rm shellcheck.xml'
                  }
                }
        }
        }
        stage('Build #0') {
            parallel {
                stage('wget') {
                    agent any
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_wget}", "src/wget").push()
                            }
                        }
                    }
                }
            }
        }
        stage('Build #1') {
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
                stage('hadolint') {
                    agent any
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_hadolint}", "src/hadolint").push()
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
                stage('tflint') {
                    agent any
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_tflint}", "src/tflint").push()
                            }
                        }
                    }
                }
                stage('yamllint') {
                    agent any
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_yamllint}", "src/yamllint").push()
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
