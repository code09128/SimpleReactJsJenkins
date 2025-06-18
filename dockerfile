FROM node:alpine
WORKDIR /app
COPY package*.json ./
# COPY --from=production-dependencies-env /app/node_modules /app/node_modules
# COPY --from=build-env /app/build /app/build
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "run", "dev"]