Jenkins definition
```
def pylint(quality) {
  sh 'touch pylint.log'
  sh 'find ./ -name "*.py" |xargs pylint --output-format=parseable | tee -a pylint.log'
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
        image 'ysebastia/pylint:2.15.8'
      }
    }
    steps {
      pylint(QUALITY_PYTHON)
    }
  }
```
