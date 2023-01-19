Jenkins definition
```
def yamllint(quality) {
  sh 'touch yamllint.txt'
  sh 'yamllint -f parsable . | tee -a yamllint.txt'
  recordIssues qualityGates: [[threshold: quality, type: 'TOTAL', unstable: false]],  tools: [yamlLint(id: 'yamlLint', name: 'Yaml Lint', pattern: 'yamllint.txt')]
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
  stage ('Yaml lint') {
    agent {
      docker {
        image 'ysebastia/yamllint:1.29.0'
      }
    }
    steps {
      yamllint(QUALITY_YAML)
    }
  }
```
