# TRIVY

## Jenkins

Jenkins definition

```
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
```

Jenkins stage

```
        stage('Trivy') {
          agent {
            docker {
              image docker.io/ysebastia/trivy:0.62.0
            }
          }
          steps {
            runtrivy(image/to/scan, "iage_name_to_display")
          }
       }
```

## Gitlab-CI

```yaml
# Extension d'analyse de vulnérabilité Trivy

.trivy:
  image:
    name: docker.io/ysebastia/trivy:0.62.0
    entrypoint: [""]
  tags:
    - docker
  stage: test
  variables:
    GIT_STRATEGY: none
    TRIVY_USERNAME: "$CI_REGISTRY_USER"
    TRIVY_PASSWORD: "$CI_REGISTRY_PASSWORD"
    TRIVY_AUTH_URL: "$CI_REGISTRY"
  script:
    - trivy image ${IMAGE} --skip-db-update --cache-dir /tmp/.cache --severity CRITICAL --exit-code 1 --no-progress --format template --template "@/tmp/contrib/junit.tpl" | tee trivy.xml
  allow_failure: true
  # Publication du résultat de l'analyse au format junit
  artifacts:
    when: always
    reports:
      junit: trivy.xml
```