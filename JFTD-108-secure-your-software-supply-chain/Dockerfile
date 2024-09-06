FROM node:16.19.0
# ARG JF_TOKEN

# Create app directory
WORKDIR /usr/src/app
COPY package*.json ./
# RUN apt-get update && \
#     apt-get install -y curl make ncat && \
#     apt-get clean
# RUN curl -fL https://install-cli.jfrog.io | sh

# If you are building your code for production
# RUN jf c import ${JF_TOKEN} && \
#     jf npmc --repo-resolve=dro-npm-unsecure-remote && \
#     jf npm i --omit dev
RUN npm install
EXPOSE 3000

COPY server.js ./
COPY public public/
COPY views views/
COPY fake-creds.txt /usr/src/
CMD [ "node", "server.js" ]

