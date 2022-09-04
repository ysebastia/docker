Jenkins definition
```
def pylint(src, quality) {
    script {
        env.SRC_PYTHON = src
    }
    sh 'pylint $SRC_PYTHON --output-format=parseable --output=pylint.log || exit 0'
    recordIssues qualityGates: [[threshold: quality, type: 'TOTAL', unstable: false]], tools: [pyLint(pattern: 'pylint.log')]
    archiveArtifacts artifacts: 'pylint.log', followSymlinks: false
    sh 'rm pylint.log'
}
```

Jenkins environment
```
  environment {
    QUALITY_PYTHON = "1"
  }
```

Jenkins stage
```
  stage ('Pylint') {
    agent {
      docker {
        image 'ysebastia/pylint:2.12.2-r1-2'
      }
    }
    steps {
      pylint('./',QUALITY_PYTHON)
    }
  }
```
