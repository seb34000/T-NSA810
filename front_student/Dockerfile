# FROM mhart/alpine-node:11 AS builder
# WORKDIR /app
# COPY . .
# RUN yarn install
# RUN yarn build
# WORKDIR /app
# COPY --from=builder /app/build .
# CMD ["serve", "-p", "80", "-s", "."]

# Étape de construction
FROM mhart/alpine-node:14 AS builder
WORKDIR /app
COPY . .
RUN yarn install
RUN yarn build

# Étape de déploiement
FROM mhart/alpine-node:14
WORKDIR /app
# Copie les fichiers construits depuis l'étape de construction
COPY --from=builder /app/build /app
# Installe un serveur HTTP simple pour servir les contenus statiques
RUN yarn global add serve
# Définit la commande pour servir l'application
CMD ["serve", "-p", "80", "-s", "/app"]
