Jenkins definition
```
def hadolint(quality) {
  sh 'touch hadolint.json'
  sh '/usr/local/bin/hadolint.bash | tee -a hadolint.json'
  recordIssues enabledForFailure: true, qualityGates: [[threshold: quality, type: 'TOTAL', unstable: false]], tools: [hadoLint(pattern: 'hadolint.json')]
  archiveArtifacts artifacts: 'hadolint.json', followSymlinks: false
  sh 'rm hadolint.json'
}
```

Jenkins environment
```
  environment {
    QUALITY_DOCKERFILE = "1"
  }
```

Jenkins stage
```
  stage ('hadolint') {
    agent {
        docker {
              image 'docker.io/ysebastia/hadolint:2.12.0-1'
          }
    }
    steps {
        hadolint(QUALITY_DOCKERFILE)
    }
  }
```

Command call
```
$ docker run --rm -t -v "$(pwd)":/app -w /app docker.io/ysebastia/hadolint:2.12.0-1
```
