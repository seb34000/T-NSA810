#!/bin/sh

sleep 10

# Exécutez la migration
yarn migration:start

# Démarrez ensuite votre application
exec yarn start