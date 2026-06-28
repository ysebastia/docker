def hadolint(quality) {
  sh 'touch hadolint.json'
  sh '/usr/local/bin/hadolint.bash | tee -a hadolint.json'
  recordIssues enabledForFailure: true, qualityGates: [[threshold: quality, type: 'TOTAL', unstable: false]], tools: [hadoLint(pattern: 'hadolint.json')]
  archiveArtifacts artifacts: 'hadolint.json', followSymlinks: false
  sh 'rm hadolint.json'
}
pipeline {
    agent {label 'docker'}
    environment {
        DH_CREDS=credentials('docker')
        QUALITY_DOCKERFILE = "1"
        release_ansible = "ysebastia/ansible:2.21.1"
        release_ansiblebuilder = "ysebastia/ansible-builder:3.1.1"
        release_ansiblelint = "ysebastia/ansible-lint:26.4.0"
        release_checkov = "ysebastia/checkov:3.2.495"
        release_cloc = "ysebastia/cloc:2.06"
        release_csslint = "ysebastia/csslint:1.0.5-1"
        release_hadolint = "ysebastia/hadolint:2.14.0"
        release_helm = "ysebastia/helm:3.19.1"
        release_jscpd = "ysebastia/jscpd:3.5.10-1"
        release_make = "ysebastia/make:4.4.1-r3"
        release_molecule = "ysebastia/molecule:26.4.0"
        release_molecule_debian = "ysebastia/molecule:debian-13.2"
        release_molecule_rhel10 = "ysebastia/molecule:rhel-10.1"
        release_molecule_rhel9 = "ysebastia/molecule:rhel-9.7"
        release_molecule_ubuntu22 = "ysebastia/molecule:ubuntu-22.04"
        release_molecule_ubuntu24 = "ysebastia/molecule:ubuntu-24.04"
        release_properdocs = "ysebastia/properdocs:1.6.7"
        release_pylint = "ysebastia/pylint:4.0.4"
        release_shellcheck = "ysebastia/shellcheck:0.11.0"
        release_tflint = "ysebastia/tflint:0.60.0"
        release_wget = "ysebastia/wget:1.25.0-r2"
        release_yamllint = "ysebastia/yamllint:1.38.0"
    }
    stages {
        stage ('Checkout') {
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
                        additionalBuildArgs "--build-arg https_proxy=$HTTPS_PROXY"
                        dir 'src/cloc'
                        filename 'Dockerfile'
                        label 'docker'
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
                      additionalBuildArgs "--build-arg https_proxy=$HTTPS_PROXY"
                      dir 'src/hadolint'
                      filename 'Dockerfile'
                      label 'docker'
                     }
                  }
                steps {
                    hadolint(QUALITY_DOCKERFILE)
                }
            }
                stage ('shellcheck') {
                  agent {
                    dockerfile {
                        additionalBuildArgs "--build-arg https_proxy=$HTTPS_PROXY"
                        dir 'src/shellcheck'
                        filename 'Dockerfile'
                        label 'docker'
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
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_wget}", "--build-arg https_proxy=$HTTPS_PROXY src/wget").push()
                            }
                        }
                    }
                }
            }
        }
        stage('Build #1') {
            parallel {
                stage('cloc') {
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_cloc}", "--build-arg https_proxy=$HTTPS_PROXY src/cloc").push()
                            }
                        }
                    }
                }
                stage('csslint') {
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_csslint}", "--build-arg https_proxy=$HTTPS_PROXY src/csslint").push()
                            }
                        }
                    }
                }
                stage('hadolint') {
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_hadolint}", "--build-arg https_proxy=$HTTPS_PROXY src/hadolint").push()
                            }
                        }
                    }
                }
                stage('helm') {
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_helm}", "--build-arg https_proxy=$HTTPS_PROXY --build-arg http_proxy=$HTTP_PROXY src/helm").push()
                            }
                        }
                    }
                }
                stage('jscpd') {
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_jscpd}", "--build-arg https_proxy=$HTTPS_PROXY src/jscpd").push()
                            }
                        }
                    }
                }                
                stage('make') {
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_make}", "--build-arg https_proxy=$HTTPS_PROXY src/make").push()
                            }
                        }
                    }
                }
                stage('shellcheck') {
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_shellcheck}", "--build-arg https_proxy=$HTTPS_PROXY src/shellcheck").push()
                            }
                        }
                    }
                }
                stage('tflint') {
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_tflint}", "--build-arg https_proxy=$HTTPS_PROXY src/tflint").push()
                            }
                        }
                    }
                }
            }
        }
        stage('Build #2') {
            parallel {
                stage('python') {
                    agent { label 'rhel' }
                    steps {
                        sh 'make python'
                        sh 'echo $DH_CREDS_PSW | podman login -u $DH_CREDS_USR --password-stdin docker.io'
	                    sh "podman push docker.io/${env.release_ansible}"
                        sh "podman push docker.io/${env.release_ansiblebuilder}"
                        sh "podman push docker.io/${env.release_ansiblelint}"
                        sh "podman push docker.io/${env.release_checkov}"
                        sh "podman push docker.io/${env.release_properdocs}"
                        sh "podman push docker.io/${env.release_pylint}"
                        sh "podman push docker.io/${env.release_yamllint}"
                        sh 'podman logout docker.io'
                    }
                }                
            }
        }
        stage('Build #3') {
            parallel {
                stage('molecule') {
                    agent { label 'rhel' }
                    steps {
                        sh 'make molecule molecule_os'
                        sh 'echo $DH_CREDS_PSW | podman login -u $DH_CREDS_USR --password-stdin docker.io'
	                    sh "podman push docker.io/${env.release_molecule_debian}"
	                    sh "podman push docker.io/${env.release_molecule_rhel10}"
                        sh "podman push docker.io/${env.release_molecule_rhel9}"
                        sh "podman push docker.io/${env.release_molecule_ubuntu22}"
                        sh "podman push docker.io/${env.release_molecule_ubuntu24}"
                        sh 'podman logout docker.io'
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
