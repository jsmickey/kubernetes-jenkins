##### Build Jenkins Master docker container
```
docker build . -t jenkins-master:VERSION -t gcr.io/GCP_PROJECT/jenkins-master:VERSION
gcloud docker -- push gcr.io/GCP_PROJECT/jenkins-master:VERSION
```

##### Build cluster and storage
```
terraform init
terraform plan
terraform apply
```

##### Fetch kubectl config
```
gcloud container clusters get-credentials jenkins -z us-central1-a
```

##### Add Jenkins Namespace
```
kubectl apply -f namespace.yaml
```

##### Add and enable Jenkins namespace to kubectl config
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

##### Links
https://cloud.google.com/solutions/configuring-jenkins-container-engine
