# ANSIBLE-LINT


## Cli

Command call

```bash
podman run --rm -t -v "${PWD}":/app:Z -w /app docker.io/ysebastia/ansible-lint:25.4.0 ansible-lint -p /app
```

## Jenkins

Jenkins definition

```
def ansiblelint(quality) {
  sh 'find . -name requirements.yml -exec ansible-galaxy collection install -r {} --ignore-certs --force --collections-path "~/.ansible/collections" \\;'
  sh 'ansible-galaxy collection list'
  sh 'touch ansible-lint.txt'
  sh 'ansible-lint -p | tee -a ansible-lint.txt'
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
        image 'ysebastia/ansible-lint:25.4.0'
      }
    }
    steps {
      ansiblelint(QUALITY_ANSIBLE)
    }
  }
```

## Gitlab-CI

```yaml
# Analyse ansible-lint du code Ansible

ansible-lint:
  image: docker.io/ysebastia/ansible-lint:25.4.0
  stage: test
  tags:
    - docker
  # Copie d'un fichier ansible.cfg s'il existe dans le dossier .config
  # Installation des dépendances Ansible si le fichier requirements.yml existe
  # Installation des dépendances Pip si le fichier requirements.txt existe
  # Mise à jour des permissions du répertoire build pour éviter d'exécuter ansible dans un dossier permissif
  before_script:
    - test -f .config/ansible.cfg && cp -f .config/ansible.cfg ansible.cfg
    - find . -name requirements.yml -exec ansible-galaxy collection install -r {} --ignore-certs --force --collections-path "~/.ansible/collections" \;
    - ansible-galaxy collection list
    - test -f requirements.txt && pip install --no-cache -r requirements.txt
    - chmod -R 700 /builds/
  # Analyse de code ansible et publication au format Junit
  script:
    - ansible-lint -v --show-relpath -f pep8 --nocolor
      | ansible-lint-junit -o ansible-lint.xml
  # Publication du résultat de l'analyse au format junit
  artifacts:
    when: always
    reports:
      junit: ansible-lint.xml
  rules:
    - when: on_success
```