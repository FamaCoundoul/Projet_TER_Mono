#!/bin/bash
set -e

echo "✅ Compilation Maven..."
cd backend-mono/E-Commerce
mvn clean package -DskipTests
cd -

echo "📦 Copie du .jar dans le dossier racine..."
cp backend-mono/E-Commerce/target/E-Commerce-0.0.1-SNAPSHOT.jar .

echo "🐳 Build Docker..."
docker-compose build backend


echo "🚀 Lancement..."
docker-compose up
