
    apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws
  annotations:
    argocd.argoproj.io/sync-options: SkipDryRunOnMissingResource=true
    argocd.argoproj.io/sync-wave: "2" # Sync after XRD

spec:
  package: xpkg.upbound.io/crossplane-contrib/provider-aws:v0.45.1
  controllerConfigRef:
    name: aws-config
---
apiVersion: aws.crossplane.io/v1beta1
kind: ProviderConfig
metadata:
  name: default
  annotations:
    argocd.argoproj.io/sync-options: SkipDryRunOnMissingResource=true
    argocd.argoproj.io/sync-wave: "10" # Sync after XRD

spec:
  credentials:
    source: InjectedIdentity
---
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-aws-s3
  annotations:
    argocd.argoproj.io/sync-options: SkipDryRunOnMissingResource=true
    argocd.argoproj.io/sync-wave: "2" # Sync after XRD
spec:
  package: "xpkg.upbound.io/upbound/provider-aws-s3:{{ .Values.upbound.aws.version }}"
  controllerConfigRef:
    name: aws-config
---    
apiVersion: pkg.crossplane.io/v1alpha1
kind: ControllerConfig
metadata:
  name: aws-config
  annotations:
    eks.amazonaws.com/role-arn: {{ .Values.providerConfigs.default.roleARN }}
    argocd.argoproj.io/sync-wave: "1" # Sync after XRD
    argocd.argoproj.io/sync-options: SkipDryRunOnMissingResource=true
