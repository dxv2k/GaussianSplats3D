FROM node:21

# Copy package.json and package-lock.json
COPY package*.json ./

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the rest of the application code to the working directory
COPY . .

# Install application dependencies
RUN npm install && \
    npm run build

# Download and unzip asset files
RUN apt-get update && apt-get install -y wget unzip \
    && wget -O assets.zip https://projects.markkellogg.org/downloads/gaussian_splat_data.zip \
    && unzip -o assets.zip -d ./build/demo/assets/data \
    && rm assets.zip

# Expose the port that your Node.js application will run on
EXPOSE 8080

# Command to run your Node.js application
CMD ["npm", "run", "demo"]
