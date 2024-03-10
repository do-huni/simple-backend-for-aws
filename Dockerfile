#Build stage

FROM node:18 as build

WORKDIR /usr/src/my-app

COPY package*.json .

RUN npm install

COPY . .

RUN npm run build

#Production stage

FROM node:18 as production

WORKDIR /usr/src/my-app
# as build 노드에서 build폴더 가져와서 as production 노드에 복사해라
COPY --from=build ./usr/src/my-app/build ./build   

COPY --from=build ./usr/src/my-app/package.json ./package.json

# COPY --from=build ./usr/src/my-app/packge-lock.json .package-lock.json

RUN npm install --only=production

CMD ["npm", "start"]

