FROM node:carbon


# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm install --only=production

RUN apt-get update -y
RUN apt-get install -y openssh-server
RUN sed -i '0,/PasswordAuthentication no/s//PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN echo  "root:unix"|chpasswd

# Bundle app source
COPY . .

EXPOSE 8080
CMD [ "npm", "start" ]
