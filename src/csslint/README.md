Jenkins definition
```
def csslint(src, quality) {
  script {
      env.SRC_CSS = src
  }
  sh 'touch csslint.xml'
  sh 'csslint --format=lint-xml $SRC_CSS | tee -a csslint.xml'
  recordIssues qualityGates: [[threshold: quality, type: 'TOTAL', unstable: false]], tools: [cssLint(pattern: 'csslint.xml')]
  archiveArtifacts artifacts: 'csslint.xml', followSymlinks: false
  sh 'rm csslint.xml'
}
```

Jenkins environment
```
  environment {
    QUALITY_ANSIBLE = "1"
  }
```


Jenkins stage
```
  stage ('CSS lint') {
    agent {
        docker {
            image 'ysebastia/csslint:1.0.5'
        }
    }
    steps {
      csslint('./', QUALITY_CSS)
    }
  }
```
