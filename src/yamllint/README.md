# YAMLLINT

## Jenkins

Jenkins definition
```
def yamllint(quality) {
  sh 'touch yamllint.txt'
  sh 'yamllint -f parsable . | tee -a yamllint.txt'
  recordIssues enabledForFailure: true, qualityGates: [[threshold: quality, type: 'TOTAL', unstable: false]],  tools: [yamlLint(id: 'yamlLint', name: 'Yaml Lint', pattern: 'yamllint.txt')]
  archiveArtifacts artifacts: 'yamllint.txt', followSymlinks: false
  sh 'rm yamllint.txt'
}
```

Jenkins environment
```
  environment {
    QUALITY_YAML = "1"
  }
```

Jenkins stage
```
  stage ('yamllint') {
    agent {
      docker {
        image 'ysebastia/yamllint:1.33.0'
      }
    }
    steps {
      yamllint(QUALITY_YAML)
    }
  }
```

## Gitlab-CI

```yaml
# Analyse yamllint du code YAML

yamllint:
  image: docker.io/ysebastia/yamllint:1.33.0
  stage: test
  tags:
    - docker
  script:
    - yamllint -f parsable .
      | yamllint-junit -o yamllint.xml
  # Publication du résultat de l'analyse au format junit
  artifacts:
    when: always
    reports:
      junit: yamllint.xml
  rules:
    - when: on_success
```