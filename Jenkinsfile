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
    release_ansible = "ysebastia/ansible:2.16.6"
    release_ansiblelint = "ysebastia/ansible-lint:24.2.2"
    release_checkov = "ysebastia/checkov:3.2.70"
    release_cloc = "ysebastia/cloc:2.00"
    release_csslint = "ysebastia/csslint:1.0.5-1"
    release_dmarctsreportparser = "ysebastia/dmarcts-report-parser:master-bookworm-slim"
    release_dmarctsreportviewer = "ysebastia/dmarcts-report-viewer:master-php8.1.27-bookworm"
    release_doxygen = "ysebastia/doxygen:1.10.0"
    release_hadolint = "ysebastia/hadolint:2.12.0-1"
    release_helm = "ysebastia/helm:3.14.3"
    release_jest = "ysebastia/jest:29.7.0"
    release_jscpd = "ysebastia/jscpd:3.5.10-1"
    release_jshint = "ysebastia/jshint:2.13.6"
    release_make = "ysebastia/make:4.4.1-r2"
    release_molecule = "ysebastia/molecule:24.2.0"
    release_molecule_alma = "ysebastia/molecule:alma-9.3"
    release_molecule_debian = "ysebastia/molecule:debian-12.5"
    release_molecule_ubuntu = "ysebastia/molecule:ubuntu-mantic"
    release_phpcpd = "ysebastia/phpcpd:6.0.3-php8.1.27"
    release_phpcs = "ysebastia/phpcs:3.7.2-php8.1.27"
    release_phpmd = "ysebastia/phpmd:2.15.0-php8.1.27"
    release_pylint = "ysebastia/pylint:3.1.0"
    release_shellcheck = "ysebastia/shellcheck:0.10.0"
    release_tflint = "ysebastia/tflint:0.50.3"
    release_trivy = "ysebastia/trivy:0.49.1"
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
                stage('jscpd') {
                    agent {
                        label 'docker'
                    }
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_jscpd}", "src/jscpd").push()
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
                stage('molecule') {
                    agent {
                        label 'docker'
                    }
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_molecule_alma}", "src/molecule-alma").push()
                                docker.build("${env.release_molecule_debian}", "src/molecule-debian").push()
                                docker.build("${env.release_molecule_ubuntu}", "src/molecule-ubuntu").push()
                                docker.build("${env.release_molecule}", "src/molecule").push()
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
                stage('trivy') {
                    agent {
                        label 'docker'
                    }
                    steps {
                        script {
                            withDockerRegistry(credentialsId: 'docker') {
                                docker.build("${env.release_trivy}", "src/trivy").push()
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
