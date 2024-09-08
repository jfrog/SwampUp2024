# Base image from 
FROM node:18

# Create app directory
WORKDIR /usr/src/app

# Copy dependency definitions
COPY package.json ./package.json

# RUN --mount=type=secret,id=npmrc,target=/root/.npmrc \
RUN npm i && rm -f /app/.npmrc

# Get all the code needed to run the app
COPY . .

# Expose the port the app runs in
EXPOSE 3000

# Serve the app
CMD ["npm", "start"]