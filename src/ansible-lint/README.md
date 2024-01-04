Jenkins definition
```
def ansiblelint(quality) {
  sh 'find . -name requirements.yml -exec ansible-galaxy collection install -r {} --ignore-certs --force \\;'
  sh 'touch ansible-lint.txt'
  sh 'ansible-lint -p --exclude ansible_collections | tee -a ansible-lint.txt'
  recordIssues enabledForFailure: true, qualityGates: [[threshold: quality, type: 'TOTAL', unstable: false]],  tools: [ansibleLint(id: 'ansibleLint', name: 'Ansible Lint', pattern: 'ansible-lint.txt')]
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
        image 'ysebastia/ansible-lint:6.22.1'
      }
    }
    steps {
      ansiblelint(QUALITY_ANSIBLE)
    }
  }
```

Command call
```
docker run --rm -t -v "${PWD}":/app -w /app docker.io/ysebastia/ansible-lint:6.22.1 ansible-lint -p /app
```
