#!/bin/bash

echo "🛠️ Building backend Docker image..."
cd ../backend-mono/E-Commerce
docker build -t ecom-mono .

echo "🛠️ Building frontend Docker image..."
cd ../../frontend-mono/E-commerce-web
docker build -t angular-frontend-mono .

echo "🚀 Deploying to Kubernetes..."
cd ../../k8s
kubectl apply -f mysql-deployment.yaml
kubectl apply -f backend-deployment.yaml
kubectl apply -f frontend-deployment.yaml

echo "✅ Deployment finished. You can check with: kubectl get all"
