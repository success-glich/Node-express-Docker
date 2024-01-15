FROM node:18 as builder

WORKDIR /build


# take package.json from our dir to current working directory
# COPY package.josn .

# take package-lock.json from our dir to current working directory
# COPY package-lock.josn .

# copy all package prefix 
COPY package*.json .
RUN ["npm","install"]

COPY src/ src/
COPY tsconfig.json tsconfig.json

RUN ["npm","run","build"]
# alternativ
#  RUN npm run build

FROM  node:18 as runner

WORKDIR /app

COPY --from=builder  build/package*.json .
COPY --from=builder build/node_modules node_modules
COPY --from=builder  build/dist dist/

CMD [ "npm","start" ]


# we can test it locally
# `` docker build -t express-image .

# to see images
# ``docker images

# to run image on container
# `` docker run -it -p 8000:8000 <image-name>