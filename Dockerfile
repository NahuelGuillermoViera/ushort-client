# build
FROM --platform=linux/amd64 node:22.18 AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# serve
FROM --platform=linux/amd64 nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist/ushort-client/browser /usr/share/nginx/html
