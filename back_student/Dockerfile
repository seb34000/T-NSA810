FROM node:11-alpine 

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY . .

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

RUN apk add g++ make python

RUN yarn install


EXPOSE 3000

CMD ["/entrypoint.sh"]
# CMD ["yarn", "migration:start"]
# CMD ["yarn", "start"]
