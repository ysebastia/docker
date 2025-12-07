def hadolint(quality) {
  sh 'touch hadolint.json'
  sh '/usr/local/bin/hadolint.bash | tee -a hadolint.json'
  recordIssues enabledForFailure: true, qualityGates: [[threshold: quality, type: 'TOTAL', unstable: false]], tools: [hadoLint(pattern: 'hadolint.json')]
  archiveArtifacts artifacts: 'hadolint.json', followSymlinks: false
  sh 'rm hadolint.json'
}
def runtrivy(image, name) {
   script {
     env.IMAGE = image
     env.NAME = name
   }
   sh 'touch trivy.xml'
   sh 'trivy image $IMAGE --skip-db-update --scanners vuln --severity CRITICAL --no-progress --format template --template "@/tmp/contrib/junit.tpl" --cache-dir /tmp/.cache | tee trivy.xml'
   recordIssues enabledForFailure: true, tools: [junitParser(id: "trivy_${env.NAME}", name: "trivy_${env.NAME}", pattern: 'trivy.xml')]
   sh 'rm trivy.xml'
}
pipeline {
    agent {label 'docker'}
    environment {
        DH_CREDS=credentials('docker')
        QUALITY_DOCKERFILE = "1"
        release_ansible = "ysebastia/ansible:2.20.0"
        release_ansiblebuilder = "ysebastia/ansible-builder:3.1.1"
        release_ansiblelint = "ysebastia/ansible-lint:25.12.0"
        release_checkov = "ysebastia/checkov:3.2.495"
        release_cloc = "ysebastia/cloc:2.06"
        release_csslint = "ysebastia/csslint:1.0.5-1"
        release_hadolint = "ysebastia/hadolint:2.14.0"
        release_helm = "ysebastia/helm:3.19.1"
        release_jscpd = "ysebastia/jscpd:3.5.10-1"
        release_make = "ysebastia/make:4.4.1-r3"
        release_molecule = "ysebastia/molecule:25.12.0"
        release_molecule_debian = "ysebastia/molecule:debian-13.2"
        release_molecule_podman = "ysebastia/molecule:25.12.0-podman"
        release_molecule_rhel10 = "ysebastia/molecule:rhel-10.0"
        release_molecule_rhel9 = "ysebastia/molecule:rhel-9.6"
        release_pip_venv_alpine = "ysebastia/pip-venv:25.3-alpine"
        release_pip_venv_debian = "ysebastia/pip-venv:25.3-debian"
        release_pylint = "ysebastia/pylint:4.0.4"
        release_python = "ysebastia/python:3.12.10"
        release_shellcheck = "ysebastia/shellcheck:0.11.0"
        release_tflint = "ysebastia/tflint:0.58.1"
        release_trivy = "ysebastia/trivy:0.68.1"
        release_wget = "ysebastia/wget:1.25.0-r2"
        release_yamllint = "ysebastia/yamllint:1.37.1"
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
                stage('pip-venv') {
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_pip_venv_alpine}", "--build-arg https_proxy=$HTTPS_PROXY src/pip-venv/alpine").push()
                                docker.build("${env.release_pip_venv_debian}", "--build-arg https_proxy=$HTTPS_PROXY --build-arg http_proxy=$HTTPS_PROXY src/pip-venv/debian").push()
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
                stage('trivy') {
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_trivy}", "--build-arg https_proxy=$HTTPS_PROXY src/trivy").push()
                            }
                        }
                    }
                }
            }
        }
        stage('Build #2') {
            parallel {
                stage('ansible') {
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_ansible}", "--build-arg https_proxy=$HTTPS_PROXY src/ansible").push()
                            }
                        }
                    }
                }
                stage('ansible-builder') {
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_ansiblebuilder}", "--build-arg https_proxy=$HTTPS_PROXY src/ansible-builder").push()
                            }
                        }
                    }
                }
                stage('ansible-lint') {
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_ansiblelint}", "--build-arg https_proxy=$HTTPS_PROXY src/ansible-lint").push()
                            }
                        }
                    }
                }
                stage('checkov') {
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_checkov}", "--build-arg https_proxy=$HTTPS_PROXY src/checkov").push()
                            }
                        }
                    }
                }
                stage('pylint') {
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_pylint}", "--build-arg https_proxy=$HTTPS_PROXY src/pylint").push()
                            }
                        }
                    }
                }
                stage('python') {
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_python}", "--build-arg https_proxy=$HTTPS_PROXY src/python").push()
                            }
                        }
                    }
                }
                stage('yamllint') {
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_yamllint}", "--build-arg https_proxy=$HTTPS_PROXY src/yamllint").push()
                            }
                        }
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
	                    sh 'podman push docker.io/ysebastia/molecule:debian-13.2'
	                    sh 'podman push docker.io/ysebastia/molecule:rhel-10.0'
                        sh 'podman push docker.io/ysebastia/molecule:rhel-9.6'
                        sh 'podman logout docker.io'
                    }
                }
            }
        }
        stage('Trivy') {
          agent {
            docker {
              image "${env.release_trivy}"
            }
          }
          steps {
            runtrivy("${env.release_ansiblebuilder}", "ansible-builder")
            runtrivy("${env.release_ansiblelint}", "ansible-lint")
            runtrivy("${env.release_ansible}", "ansible")
            runtrivy("${env.release_checkov}", "checkov")
            runtrivy("${env.release_cloc}", "cloc")
            runtrivy("${env.release_csslint}", "csslint")
            runtrivy("${env.release_hadolint}", "hadolint")
            runtrivy("${env.release_helm}", "helm")
            runtrivy("${env.release_jscpd}", "jscpd")
            runtrivy("${env.release_make}", "make")
            runtrivy("${env.release_molecule_rhel9}", "molecule-rhel9")
            runtrivy("${env.release_molecule_rhel10}", "molecule-rhel10")
            runtrivy("${env.release_molecule_debian}", "molecule-debian")
            runtrivy("${env.release_molecule}", "molecule")
            runtrivy("${env.release_pip_venv_alpine}", "pip-venv-alpine")
            runtrivy("${env.release_pip_venv_debian}", "pip-venv-debian")
            runtrivy("${env.release_pylint}", "pylint")
            runtrivy("${env.release_python}", "python")
            runtrivy("${env.release_shellcheck}", "shellcheck")
            runtrivy("${env.release_tflint}", "tflint")
            runtrivy("${env.release_trivy}", "trivy")
            runtrivy("${env.release_wget}", "wget")
            runtrivy("${env.release_yamllint}", "yamllint")
          }
        }
    }
    post {
       always {
         cleanWs()
       }
    }
}
