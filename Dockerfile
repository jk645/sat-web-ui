FROM node:22 AS builder
WORKDIR /build
COPY ./sat-spa/ ./
RUN npm install
RUN npm run build

FROM node:22 AS server
WORKDIR /opt
COPY ./sat-ui/ ./
COPY --from=builder /build/dist/ /opt/public/app/
RUN npm install
CMD ["node", "./bin/www"]
EXPOSE 3000
