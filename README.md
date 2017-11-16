This project was created to demonstate building Jenkins as a Docker container running on a GCP Kubernetes cluster with dynamic slaves managed by Kubernetes.  Declarative infrastructure as a code is used with Terraform and Kubernetes.  Please do not consider this to be production ready.  It is a demonstration and possibly a building block for a production system.

##### Tools
* Bash (Most commands will work on Windows by default except for openssl)
* Google SDK https://cloud.google.com/sdk/
* Terraform https://www.terraform.io/docs/index.html
* Kubectl https://kubernetes.io/docs/user-guide/kubectl-overview/

##### Build cluster and storage
Use the terraform documentation to configure the GCP provider
```
terraform init
terraform plan
terraform apply
```

##### Build Jenkins Master docker container
* Manage plugin installations and versions
* Configure Jenkins Master to use Kubernetes for slaves
* Mitigate Jenkins security alerts
* Upload container to GCP Container Registry
```
docker build . -t jenkins-master:VERSION -t gcr.io/GCP_PROJECT/jenkins-master:VERSION
gcloud docker -- push gcr.io/GCP_PROJECT/jenkins-master:VERSION
```

##### Fetch kubectl config
Fetch the kube config for new created cluster
```
gcloud container clusters get-credentials jenkins -z us-central1-a
```

##### Add Jenkins Namespace
```
kubectl apply -f namespace.yaml
```

##### Add and enable Jenkins namespace to kubectl config
This is an optional step.  If there are mulitple namespaces, the (-ns) option can be used with kubectl.
```
kubectl config set-context jenkins --namespace=jenkins  --cluster=gke_GCP_PROJECT_us-central1-a_jenkins --user=gke_GCP_PROJECT_us-central1-a_jenkins
kubectl config set-context $(kubectl config current-context) --namespace=jenkins
```

##### Deploy Jenkins Master
```
kubectl apply -f deployment.yaml
kubectl apply -f services.yaml
```

##### Create Certificate
This is a self-signed certificate converted to 
```
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN=jenkins/O=jenkins"
kubectl create secret generic tls --from-file=tls.crt --from-file=tls.key
cat tls.key | base64 -w0
cat tls.crt | base64 -w0
```

##### Deploy Load Balancer
```
kubectl apply -f ingress.yaml
```

##### Links and Credit
* Kubernetes the Hard Way https://github.com/kelseyhightower/kubernetes-the-hard-way
* GCP Jenkins Documentation https://cloud.google.com/solutions/configuring-jenkins-container-engine
* Jenkins and Docker https://github.com/jenkinsci/docker
