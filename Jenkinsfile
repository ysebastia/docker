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
    agent any
    environment {
    QUALITY_DOCKERFILE = "1"
    release_ansible = "ysebastia/ansible:2.17.4"
    release_ansiblelint = "ysebastia/ansible-lint:24.9.0"
    release_checkov = "ysebastia/checkov:3.2.253"
    release_cloc = "ysebastia/cloc:2.02"
    release_csslint = "ysebastia/csslint:1.0.5-1"
    release_dmarctsreportparser = "ysebastia/dmarcts-report-parser:master-bookworm-slim"
    release_dmarctsreportviewer = "ysebastia/dmarcts-report-viewer:master-php8.1.27-bookworm"
    release_doxygen = "ysebastia/doxygen:1.10.0"
    release_hadolint = "ysebastia/hadolint:2.12.0-1"
    release_helm = "ysebastia/helm:3.16.1"
    release_jest = "ysebastia/jest:29.7.0"
    release_jscpd = "ysebastia/jscpd:3.5.10-1"
    release_jshint = "ysebastia/jshint:2.13.6"
    release_make = "ysebastia/make:4.4.1-r2"
    release_molecule = "ysebastia/molecule:24.9.0"
    release_molecule_alma = "ysebastia/molecule:alma-9.4"
    release_molecule_debian = "ysebastia/molecule:debian-12.7"
    release_molecule_ubuntu = "ysebastia/molecule:ubuntu-mantic"
    release_phpcpd = "ysebastia/phpcpd:6.0.3-php8.1.27"
    release_phpcs = "ysebastia/phpcs:3.7.2-php8.1.27"
    release_phpmd = "ysebastia/phpmd:2.15.0-php8.1.27"
    release_pylint = "ysebastia/pylint:3.2.7"
    release_shellcheck = "ysebastia/shellcheck:0.10.0"
    release_tflint = "ysebastia/tflint:0.53.0"
    release_trivy = "ysebastia/trivy:0.54.1"
    release_wget = "ysebastia/wget:1.24.5-r0"
    release_yamllint = "ysebastia/yamllint:1.35.1"
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
                        additionalBuildArgs "--build-arg https_proxy=$HTTPS_PROXY"
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
                      additionalBuildArgs "--build-arg https_proxy=$HTTPS_PROXY"
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
                        additionalBuildArgs "--build-arg https_proxy=$HTTPS_PROXY"
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
                                docker.build("${env.release_wget}", "--build-arg https_proxy=$HTTPS_PROXY src/wget").push()
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
                                docker.build("${env.release_ansible}", "--build-arg https_proxy=$HTTPS_PROXY src/ansible").push()
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
                                docker.build("${env.release_ansiblelint}", "--build-arg https_proxy=$HTTPS_PROXY src/ansible-lint").push()
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
                                docker.build("${env.release_checkov}", "--build-arg https_proxy=$HTTPS_PROXY src/checkov").push()
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
                                docker.build("${env.release_cloc}", "--build-arg https_proxy=$HTTPS_PROXY src/cloc").push()
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
                                docker.build("${env.release_csslint}", "--build-arg https_proxy=$HTTPS_PROXY src/csslint").push()
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
                                docker.build("${env.release_dmarctsreportparser}", "--build-arg https_proxy=$HTTPS_PROXY src/dmarcts-report-parser").push()
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
                                docker.build("${env.release_dmarctsreportviewer}", "--build-arg https_proxy=$HTTPS_PROXY src/dmarcts-report-viewer").push()
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
                                docker.build("${env.release_doxygen}", "--build-arg https_proxy=$HTTPS_PROXY src/doxygen").push()
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
                                docker.build("${env.release_hadolint}", "--build-arg https_proxy=$HTTPS_PROXY src/hadolint").push()
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
                                docker.build("${env.release_helm}", "--build-arg https_proxy=$HTTPS_PROXY src/helm").push()
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
                                docker.build("${env.release_jest}", "--build-arg https_proxy=$HTTPS_PROXY src/jest").push()
                            }
                        }
                    }
                }
                stage('jscpd') {
                    agent {
                        label 'docker'
                    }
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_jscpd}", "--build-arg https_proxy=$HTTPS_PROXY src/jscpd").push()
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
                                docker.build("${env.release_jshint}", "--build-arg https_proxy=$HTTPS_PROXY src/jshint").push()
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
                                docker.build("${env.release_make}", "--build-arg https_proxy=$HTTPS_PROXY src/make").push()
                            }
                        }
                    }
                }
                stage('molecule') {
                    agent {
                        label 'docker'
                    }
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_molecule_alma}", "--build-arg https_proxy=$HTTPS_PROXY src/molecule-alma").push()
                                docker.build("${env.release_molecule_debian}", "--build-arg https_proxy=$HTTPS_PROXY src/molecule-debian").push()
                                docker.build("${env.release_molecule_ubuntu}", "--build-arg https_proxy=$HTTPS_PROXY src/molecule-ubuntu").push()
                                docker.build("${env.release_molecule}", "--build-arg https_proxy=$HTTPS_PROXY src/molecule").push()
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
                                docker.build("${env.release_phpcpd}", "--build-arg https_proxy=$HTTPS_PROXY src/phpcpd").push()
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
                                docker.build("${env.release_phpcs}", "--build-arg https_proxy=$HTTPS_PROXY src/phpcs").push()
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
                                docker.build("${env.release_phpmd}", "--build-arg https_proxy=$HTTPS_PROXY src/phpmd").push()
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
                                docker.build("${env.release_pylint}", "--build-arg https_proxy=$HTTPS_PROXY src/pylint").push()
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
                                docker.build("${env.release_shellcheck}", "--build-arg https_proxy=$HTTPS_PROXY src/shellcheck").push()
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
                                docker.build("${env.release_tflint}", "--build-arg https_proxy=$HTTPS_PROXY src/tflint").push()
                            }
                        }
                    }
                }
                stage('trivy') {
                    agent {
                        label 'docker'
                    }
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_trivy}", "--build-arg https_proxy=$HTTPS_PROXY src/trivy").push()
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
                                docker.build("${env.release_yamllint}", "--build-arg https_proxy=$HTTPS_PROXY src/yamllint").push()
                            }
                        }
                    }
                }
            }
        }
        stage('Trivy') {
          agent {
            docker {
              label 'docker'
              image "${env.release_trivy}"
            }
          }
          steps {
            runtrivy("${env.release_ansiblelint}", "ansible-lint")
            runtrivy("${env.release_ansible}", "ansible")
            runtrivy("${env.release_checkov}", "checkov")
            runtrivy("${env.release_cloc}", "cloc")
            runtrivy("${env.release_csslint}", "csslint")
            runtrivy("${env.release_dmarctsreportparser}", "dmarcts-report-parser")
            runtrivy("${env.release_dmarctsreportviewer}", "dmarcts-report-viewer")
            runtrivy("${env.release_doxygen}", "doxygen")
            runtrivy("${env.release_hadolint}", "hadolint")
            runtrivy("${env.release_helm}", "helm")
            runtrivy("${env.release_jest}", "jest")
            runtrivy("${env.release_jscpd}", "jscpd")
            runtrivy("${env.release_jshint}", "jshint")
            runtrivy("${env.release_make}", "make")
            runtrivy("${env.release_molecule}", "molecule")
            runtrivy("${env.release_molecule_debian}", "molecule-debian")
            runtrivy("${env.release_phpcpd}", "phpcpd")
            runtrivy("${env.release_phpcs}", "phpcs")
            runtrivy("${env.release_phpmd}", "phpmd")
            runtrivy("${env.release_pylint}", "pylint")
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
