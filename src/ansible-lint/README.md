Jenkins definition
```
def ansiblelint(quality) {
  sh 'touch ansible-lint.txt'
  sh 'ansible-lint -p | tee -a ansible-lint.txt'
  recordIssues qualityGates: [[threshold: quality, type: 'TOTAL', unstable: false]],  tools: [ansibleLint(id: 'ansibleLint', name: 'Ansible Lint', pattern: 'ansible-lint.txt')]
  archiveArtifacts artifacts: 'ansible-lint.txt', followSymlinks: false
  sh 'rm ansible-lint.txt'
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
  stage ('Ansible lint') {
    agent {
      docker {
        image 'ysebastia/ansible-lint:6.9.0-1'
      }
    }
    steps {
      ansiblelint(QUALITY_ANSIBLE)
    }
  }
```

Command call
```
$ docker run --rm -t -v "$PWD":/app ysebastia/ansible-lint:6.9.0-1 ansible-lint -p /app
```
