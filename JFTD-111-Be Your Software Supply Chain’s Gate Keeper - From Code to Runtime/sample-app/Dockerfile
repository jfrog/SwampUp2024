# Create image based on the official Node image from dockerhub
FROM <your-course-instance>/<docker-virtual-repo-name>/node:lts-buster

# Create app directory
WORKDIR /usr/src/app

# Set NPM registry config to point resolve dependencies from Artifactory
#COPY ./.npmrc-Docker .npmrc
#RUN npm config fix
# Note: The secret below is just a randomly-generated string.  It's not an actual operational secret :)
ENV api_key=BQE7suZMs7U7anJ

# Copy dependency definitions
#COPY package.json ./package.json
#COPY package-lock.json ./package-lock.json

# Install dependencies
#RUN npm set progress=true \
#    && npm config set depth 0 \
#    && npm i install

# Get all the code needed to run the app.  We can do this because we've already resolved and installed the deps
# in a previous lab.  In CI, this would look different, but for our lab purposes this is perfectly fine
COPY . .

# Expose the port the app runs in
EXPOSE 3000

# Serve the app
CMD ["npm", "start"]

# Just keep it up
#CMD ["tail", "-f", "/dev/null"]