# TFLINT

## Cli

Command call
```
docker run --rm -t -v "${PWD}":/app -w /app docker.io/ysebastia/tflint:0.55.1 tflint --recursive
```

## Jenkins

Jenkins definition
```
def tflint(quality) {
  sh 'touch tflint.xml'
  sh 'tflint --recursive --format=checkstyle | tee -a  tflint.xml'
  recordIssues enabledForFailure: true, qualityGates: [[threshold: quality, type: 'TOTAL', unstable: false]], tools: [checkStyle(id: 'tflint', name: 'TFLint', pattern: 'tflint.xml')]
  archiveArtifacts artifacts: 'tflint.xml', followSymlinks: false
  sh 'rm tflint.xml'
}
```

Jenkins environment
```
  environment {
    QUALITY_TERRAFORM = "1"
  }
```

Jenkins stage
```
  stage ('Tflint') {
    agent {
      docker {
        image 'ysebastia/tflint:0.55.1'
      }
    }
    steps {
      tflint(QUALITY_TERRAFORM)
    }
  }
```



## Gitlab-CI

```yaml
# Extensions de tests Tflint

# Un runner docker est utilisé pour l'exécution des jobs
# Les résultats des tests sont publiés au format Junit
.tflint:
  image: docker.io/ysebastia/tflint:0.55.1
  stage: test
  tags:
    - docker
  script:
    - tflint --recursive --format=junit | tee tflint.xml
  artifacts:
    when: always
    reports:
      junit: tflint.xml
```