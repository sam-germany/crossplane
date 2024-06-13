
test
----
k create ns crossplane-system
helm repo add crossplane-stable https://charts.crossplane.io/stable
helm repo update
helm install crossplane --namespace crossplane-system --version 1.15.0 crossplane-stable/crossplane
=======
k wait --for condition=extablished --timeout=300s crd/providers.pkg.crossplane.io
k apply -f aws-prodider.yaml

k wait --for condition=extablished --timeout=300s crd/providerconfigs.aws.crossplane.io
k apply -f aws-provider-config.yaml


######################################################################################
Change to AWS kubectl cli
--------------------------
> export AWS_ACCESS_KEY_ID=""
> export AWS_SECRET_ACCESS_KEY=""

> aws eks --region ap-southeast-1 update-kubeconfig --name pc-eks

######################################################################################
Install Crossplane:
-----------------
> helm repo add crossplane-stable https://charts.crossplane.io/stable
> helm repo update
> helm install crossplane --namespace crossplane-system --create-namespace crossplane-stable/crossplane

> helm repo add komodorio https://helm-charts.komodor.io \
  && helm repo update komodorio \
  && helm upgrade --install komoplane komodorio/komoplane

