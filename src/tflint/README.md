Jenkins definition
```
def tflint(quality) {
  sh 'touch tflint.xml'
  sh 'tflint ./ -f checkstyle | tee -a  tflint.xml'
  recordIssues qualityGates: [[threshold: quality, type: 'TOTAL', unstable: false]], tools: [checkStyle(pattern: 'tflint.xml')]
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
        image 'ysebastia/tflint:0.41.0'
      }
    }
    steps {
      tflint(QUALITY_TERRAFORM)
    }
  }
```
