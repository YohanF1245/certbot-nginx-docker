#!/bin/bash

# Script pour tester le déploiement SCP

echo "==== Préparation de l'archive temporaire ===="
TEMP_DIR=$(mktemp -d)
echo "Répertoire temporaire: $TEMP_DIR"

echo "==== Copie des fichiers du projet ===="
cp -r ./* $TEMP_DIR/
cp -r ./.github $TEMP_DIR/ 2>/dev/null || true

echo "==== Contenu de l'archive ===="
find $TEMP_DIR -type f | sort

echo "==== Création de l'archive tar ===="
tar -czvf /tmp/test-deploy.tar.gz -C $TEMP_DIR .

echo "==== Taille de l'archive ===="
du -h /tmp/test-deploy.tar.gz

echo "==== Nettoyage ===="
rm -rf $TEMP_DIR

echo "==== Test terminé ===="
echo "Archive créée à /tmp/test-deploy.tar.gz"
echo "Utilisez cette commande pour la transférer manuellement:"
echo "scp /tmp/test-deploy.tar.gz USER@HOST:~/harmoneyz.tar.gz"
echo "Puis sur le serveur:"
echo "cd ~ && mkdir -p harmoneyz && tar -xzvf harmoneyz.tar.gz -C harmoneyz" 