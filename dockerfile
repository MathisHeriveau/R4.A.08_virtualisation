# Création d'une image node pour le projet angular
FROM node:latest as builder
# Création du répertoire de travail
WORKDIR /app
# Copie du fichier depuis le répertoire courant vers le répertoire de travail
COPY angular-nginx-docker .
# Installation des dépendances et build du projet
RUN npm install
RUN npm install @angular/cli
RUN npm i && npm run ng build --prod

# Installation de Json-server
FROM node:latest as json-server
WORKDIR /app
COPY db.json .
RUN npm install -g json-server
CMD ["json-server", "--watch", "db.json", "--port", "3000", "--host", "0.0.0.0"]











