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
        image 'ysebastia/tflint:0.50.2'
      }
    }
    steps {
      tflint(QUALITY_TERRAFORM)
    }
  }
```

Command call
```
docker run --rm -t -v "${PWD}":/app -w /app docker.io/ysebastia/tflint:0.50.2 tflint --recursive
```