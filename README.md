Build Jenkins Master docker container

docker build . -t jenkins-master:<version>
docker tag jenkins-master:<version> gcr.io/<gcp project>/jenkins-master:<version>
gcloud docker -- push gcr.io/<gcp project>/jenkins-master:<version>

Build cluster and storage
terraform init
terraform plan
terraform apply

Fetch kubectl config

gcloud container clusters get-credentials jenkins -z us-central1-a

Add Jenkins Namespace
kubectl apply -f namespace.yaml

Add and enable Jenkins namespace to kubectl config

kubectl config set-context jenkins --namespace=jenkins  --cluster=gke_<gcp project>_us-central1-a_jenkins --user=gke_<gcp project>_us-central1-a_jenkins

kubectl config set-context $(kubectl config current-context) --namespace=jenkins

Deploy Jenkins Master
kubectl apply -f deployment.yaml
kubectl apply -f services.yaml

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN=jenkins/O=jenkins"
kubectl create secret generic tls --from-file=tls.crt --from-file=tls.key
cat tls.key | base64 -w0
cat tls.crt | base64 -w0

kubectl apply -f ingress.yaml

https://cloud.google.com/solutions/configuring-jenkins-container-engine
