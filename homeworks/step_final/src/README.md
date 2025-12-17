Before launch create s3 bucket, dynamodb table.

For cluster:

cd eks+argo/
mfa-login.sh - automates entering MFA code, obtaining temporary AWS credentials.

chmod +x mfa-login.sh - before launch.

eval $(./mfa-login.sh)

terraform init, plan, apply 

aws eks --region eu-central-1 update-kubeconfig --name danit

in root directory 

kubectl apply -f k8s/argocd-application.yaml

Wait 10 minutes for DNS names to resolve.

Access to Argo:

use outputs argo_url

user - admin


kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d && echo

