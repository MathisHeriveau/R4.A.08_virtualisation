# Création d'une image node pour le projet angular
FROM node:latest as builder
# Création du répertoire de travail
WORKDIR /app
# Copie du fichier depuis le répertoire courant vers le répertoire de travail
COPY angular-nginx-docker .
# Installation des dépendances et build du projet
RUN npm i && npm run ng build --prod

# Création d'une image nginx pour sauvegarder le build du projet angular
FROM nginx:latest
# Mettre le travail dans le répertoire /usr/share/nginx/html
WORKDIR /usr/share/nginx/html
# Supprimer le contenu du répertoire
RUN rm -rf ./*
# Copier le contenu du répertoire /app/dist dans le répertoire courant
COPY --from=builder /app/dist/angular-nginx-docker .
# Containers run gninx avec le paramètre -g daemon off; pour garder le conteneur en cours d'exécution
CMD ["nginx", "-g", "daemon off;"]


