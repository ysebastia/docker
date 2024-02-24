Jenkins definition
```
def cloc() {
  sh 'cloc --by-file --xml --fullpath --not-match-d="(build|vendor)" --out=cloc.xml ./'
  sloccountPublish encoding: '', pattern: 'cloc.xml'
  archiveArtifacts artifacts: 'cloc.xml', followSymlinks: false
  sh 'rm cloc.xml'
}
```

Jenkins stage
```
stage ('Cloc') {
  agent {
    docker {
      image 'ysebastia/cloc:2.00'
    }
  }
  steps {
    cloc()
  }
}
```
