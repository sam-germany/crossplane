######################################################################################
Change to AWS kubectl cli
--------------------------
> export AWS_ACCESS_KEY_ID=""
> export AWS_SECRET_ACCESS_KEY=""

> aws eks --region eu-west-1 update-kubeconfig --name pc-eks

######################################################################################
Install Crossplane:
-----------------
> helm repo add crossplane-stable https://charts.crossplane.io/stable
> helm repo update
> helm install crossplane --namespace crossplane-system --create-namespace crossplane-stable/crossplane

> helm repo add komodorio https://helm-charts.komodor.io \
  && helm repo update komodorio \
  && helm upgrade --install komoplane komodorio/komoplane
  
> export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=komoplane,app.kubernetes.io/instance=komoplane" -o jsonpath="{.items[0].metadata.name}")
> export CONTAINER_PORT=$(kubectl get pod --namespace default $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
> echo "Visit http://127.0.0.1:8090 to use your application"
> kubectl --namespace default port-forward $POD_NAME 8090:$CONTAINER_PORT

01-terraform-script> cd ..
> cd crossplane
> cd crossplane-provider
> cd provider
> k apply -f .
> cd ..
> cd provider-config
> k apply -f .
> cd ..
> cd provider-functions
> k apply -f .
> cd ..
> cd ..
> cd crossplane-resources

> helm install external-secrets external-secrets/external-secrets -n external-secrets --create-namespace  -f values.yaml

If i need oidc provider for the existing cluster, use this command:
> aws eks describe-cluster --name pc-eks --query "cluster.identity.oidc.issuer" --output text --region eu-west-1

######################################################################################
> helm create <helm chart name> <name>

Note: First install only "CRD" and after that only the other two .yaml in helm-chart

> helm install <helm chart name> . 
> helm upgrade <helm chart name> .