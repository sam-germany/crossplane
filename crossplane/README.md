
> helm repo add crossplane-stable https://charts.crossplane.io/stable
> helm repo update
> helm install crossplane --namespace crossplane-system --create-namespace crossplane-stable/crossplane

> helm repo add komodorio https://helm-charts.komodor.io \
  && helm repo update komodorio \
  && helm upgrade --install komoplane komodorio/komoplane