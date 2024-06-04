#!/bin/bash

# Function to run commands silently
run_silently() {
  "$@" > /dev/null 2>&1
}

echo "🔥 Deleting existing Minikube cluster..."
run_silently minikube delete --force

echo "🚀 Starting Minikube cluster..."
run_silently minikube start --force

echo "🐳 Building back image..."
run_silently docker build -t back:1.0 ./back_student

echo "🐳 Building front image..."
run_silently docker build -t front:1.0 ./front_student

echo "🐳 pushing docker images to minikube ..."
run_silently docker save -o back_1.0.tar back:1.0
run_silently docker save -o front_1.0.tar front:1.0
run_silently minikube image load back_1.0.tar
run_silently minikube image load front_1.0.tar


echo "🔧 Creating namespace argocd..."
run_silently kubectl create namespace argocd

echo "⚙️ Installing Argo CD..."
run_silently helm install argocd argo/argo-cd -n argocd

echo "⏳ Waiting for Argo CD server to be ready..."
run_silently kubectl wait --for=condition=Ready pod -l app.kubernetes.io/name=argocd-server -n argocd

echo "🎉 Argocd is ready and installed! 🎉"

echo "🔒 Forwarding port to access Argo CD..."
run_silently kubectl port-forward service/argocd-server -n argocd 8080:443 &
sleep 5

echo "🔑 Logging in to Argo CD as admin..."
 argocd login localhost:8080 --username admin --password $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d) --insecure

echo "🔐 Updating admin password..."
 argocd account update-password --account admin --current-password $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d) --new-password adminadmin

echo "📚 Adding Git repository to Argo CD..."
argocd repo add https://github.com/seb34000/T-NSA810 --username $GIT_USER --password $GIT_TOKEN

echo "🔄 Adding source to Argo CD application..."
run_silently argocd app create nsa \
    --repo https://github.com/seb34000/T-NSA810 \
    --path mannifests \
    --dest-server https://kubernetes.default.svc \
    --dest-namespace nsa \
    --revision HEAD \
    --project default \
    --sync-policy automated \
    --sync-option CreateNamespace=true

echo "🔄 Syncing Argo CD application..."
argocd app sync nsa
