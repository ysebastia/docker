def hadolint(quality) {
  sh 'touch hadolint.json'
  sh '/usr/local/bin/hadolint.bash | tee -a hadolint.json'
  recordIssues enabledForFailure: true, qualityGates: [[threshold: quality, type: 'TOTAL', unstable: false]], tools: [hadoLint(pattern: 'hadolint.json')]
  archiveArtifacts artifacts: 'hadolint.json', followSymlinks: false
  sh 'rm hadolint.json'
}
pipeline {
    agent any
    environment {
    QUALITY_DOCKERFILE = "1"
    release_ansible = "ysebastia/ansible:2.15.3"
    release_ansiblelint = "ysebastia/ansible-lint:6.18.0"
    release_checkov = "ysebastia/checkov:2.4.27"
    release_cloc = "ysebastia/cloc:1.98"
    release_csslint = "ysebastia/csslint:1.0.5"
    release_dmarctsreportparser = "ysebastia/dmarcts-report-parser:master-debian11.6-slim"
    release_dmarctsreportviewer = "ysebastia/dmarcts-report-viewer:master-php8.1.20"
    release_doxygen = "ysebastia/doxygen:1.9.7"
    release_hadolint = "ysebastia/hadolint:2.12.0-1"
    release_helm = "ysebastia/helm:3.12.3"
    release_jest = "ysebastia/jest:29.6.1"
    release_jshint = "ysebastia/jshint:2.13.6"
    release_make = "ysebastia/make:4.4.1-r2"
    release_phpcpd = "ysebastia/phpcpd:6.0.3-php8.1.20"
    release_phpcs = "ysebastia/phpcs:3.7.2-php8.1.20"
    release_phpmd = "ysebastia/phpmd:2.13.0-php8.1.20"
    release_pylint = "ysebastia/pylint:2.17.5"
    release_shellcheck = "ysebastia/shellcheck:0.9.0-r3"
    release_tflint = "ysebastia/tflint:0.48.0"
    release_wget = "ysebastia/wget:1.21.4-r0"
    release_yamllint = "ysebastia/yamllint:1.32.0"
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
                      label 'docker'
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
                      label 'docker'
                        dir 'src/hadolint'
                        filename 'Dockerfile'
                     }
                  }
                steps {
                    hadolint(QUALITY_DOCKERFILE)
                }
            }
                stage ('shellcheck') {
                  agent {
                    dockerfile {
                      label 'docker'
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
                    agent {
                        label 'docker'
                    }
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
                stage('ansible') {
                    agent {
                        label 'docker'
                    }
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_ansible}", "src/ansible").push()
                            }
                        }
                    }
                }
                stage('ansible-lint') {
                    agent {
                        label 'docker'
                    }
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_ansiblelint}", "src/ansible-lint").push()
                            }
                        }
                    }
                }
                stage('checkov') {
                    agent {
                        label 'docker'
                    }
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_checkov}", "src/checkov").push()
                            }
                        }
                    }
                }
                stage('cloc') {
                    agent {
                        label 'docker'
                    }
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_cloc}", "src/cloc").push()
                            }
                        }
                    }
                }
                stage('csslint') {
                    agent {
                        label 'docker'
                    }
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_csslint}", "src/csslint").push()
                            }
                        }
                    }
                }
                stage('dmarcts-report-parser') {
                    agent {
                        label 'docker'
                    }
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_dmarctsreportparser}", "src/dmarcts-report-parser").push()
                            }
                        }
                    }
                }
                stage('dmarcts-report-viewer') {
                    agent {
                        label 'docker'
                    }
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_dmarctsreportviewer}", "src/dmarcts-report-viewer").push()
                            }
                        }
                    }
                }
                stage('doxygen') {
                    agent {
                        label 'docker'
                    }
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_doxygen}", "src/doxygen").push()
                            }
                        }
                    }
                }
                stage('hadolint') {
                    agent {
                        label 'docker'
                    }
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_hadolint}", "src/hadolint").push()
                            }
                        }
                    }
                }
                stage('helm') {
                    agent {
                        label 'docker'
                    }
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_helm}", "src/helm").push()
                            }
                        }
                    }
                }
                stage('jest') {
                    agent {
                        label 'docker'
                    }
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_jest}", "src/jest").push()
                            }
                        }
                    }
                }
                stage('jshint') {
                    agent {
                        label 'docker'
                    }
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_jshint}", "src/jshint").push()
                            }
                        }
                    }
                }
                stage('make') {
                    agent {
                        label 'docker'
                    }
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_make}", "src/make").push()
                            }
                        }
                    }
                }
                stage('phpcpd') {
                    agent {
                        label 'docker'
                    }
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_phpcpd}", "src/phpcpd").push()
                            }
                        }
                    }
                }
                stage('phpcs') {
                    agent {
                        label 'docker'
                    }
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_phpcs}", "src/phpcs").push()
                            }
                        }
                    }
                }
                stage('phpmd') {
                    agent {
                        label 'docker'
                    }
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_phpmd}", "src/phpmd").push()
                            }
                        }
                    }
                }
                stage('pylint') {
                    agent {
                        label 'docker'
                    }
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_pylint}", "src/pylint").push()
                            }
                        }
                    }
                }
                stage('shellcheck') {
                    agent {
                        label 'docker'
                    }
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_shellcheck}", "src/shellcheck").push()
                            }
                        }
                    }
                }
                stage('tflint') {
                    agent {
                        label 'docker'
                    }
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_tflint}", "src/tflint").push()
                            }
                        }
                    }
                }
                stage('yamllint') {
                    agent {
                        label 'docker'
                    }
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
