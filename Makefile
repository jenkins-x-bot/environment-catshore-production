CHART_REPO := http://jenkins-x-chartmuseum:8080
DIR := "env"
NAMESPACE := "pr-1518-5-production"
OS := $(shell uname)

build: clean
	rm -rf requirements.lock
	helm version
	helm init
	helm repo add releases ${CHART_REPO}
	helm repo add jenkins-x http://chartmuseum.build.cd.jenkins-x.io
	helm dependency build ${DIR}
	helm lint ${DIR}

install: 
	helm upgrade ${NAMESPACE} ${DIR} --install --namespace ${NAMESPACE} --debug

delete:
	helm delete --purge ${NAMESPACE}  --namespace ${NAMESPACE}

clean:


