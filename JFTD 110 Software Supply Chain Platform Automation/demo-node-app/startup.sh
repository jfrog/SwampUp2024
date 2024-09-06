#!/bin/bash

echo "Installing packages..."
npm install -g express-generator mocha
npm install

echo ""
echo "Node version: " $(node -v)
echo "NPM version: " $(npm -v)
echo "Express version: " $(express --version)

echo ""
echo "Starting up the app on port 3000..."
DEBUG=demo-node-app:* npm start