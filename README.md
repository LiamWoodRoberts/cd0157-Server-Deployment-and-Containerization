# Running the App Locally

Local development is handled using docker and docker-compose.

Build and run the image with the following commands:

```
docker-compose up -d --build
```

Ensure the app passes the required tests using the command:

```
docker-compose exec web python -m pytest
```

You can also test the endpoints manually with the following commands:

Health Check
```
curl --request GET 'http://localhost:80/'
```

Auth + Contents
```
export TOKEN=`curl --data '{"email":"abc@xyz.com","password":"WindowsPwd"}' --header "Content-Type: application/json" -X POST localhost:80/auth  | jq -r '.token'`
echo $TOKEN
curl --request GET 'http://localhost:80/contents' -H "Authorization: Bearer ${TOKEN}" | jq .
```

At any time you can stop the app using the command:
```
docker-compose stop
```

# Testing Endpoint

You can test the app once it has been deployed using its external endpoint. You can get this through AWS by running the following command:

```
kubectl get services simple-jwt-api -o wide
```

Extrenal IP: ad2e72c0b0ec34b79b5c0aeb675f43dd-465184208.us-east-2.elb.amazonaws.com

Test Endpoint
```
export TOKEN=`curl -d '{"email":"wolf@thedoor.com","password":"huff-puff"}' -H "Content-Type: application/json" -X POST ad2e72c0b0ec34b79b5c0aeb675f43dd-465184208.us-east-2.elb.amazonaws.com/auth  | jq -r '.token'`
curl --request GET 'ad2e72c0b0ec34b79b5c0aeb675f43dd-465184208.us-east-2.elb.amazonaws.com/contents' -H "Authorization: Bearer ${TOKEN}" | jq
```


# Deploying a Flask API

This is the project starter repo for the course Server Deployment, Containerization, and Testing.

In this project you will containerize and deploy a Flask API to a Kubernetes cluster using Docker, AWS EKS, CodePipeline, and CodeBuild.

The Flask app that will be used for this project consists of a simple API with three endpoints:

- `GET '/'`: This is a simple health check, which returns the response 'Healthy'. 
- `POST '/auth'`: This takes a email and password as json arguments and returns a JWT based on a custom secret.
- `GET '/contents'`: This requires a valid JWT, and returns the un-encrpyted contents of that token. 

The app relies on a secret set as the environment variable `JWT_SECRET` to produce a JWT. The built-in Flask server is adequate for local development, but not production, so you will be using the production-ready [Gunicorn](https://gunicorn.org/) server when deploying the app.

## Initial setup
1. Fork this project to your Github account.
2. Locally clone your forked version to begin working on the project.

## Dependencies

- Docker Engine
    - Installation instructions for all OSes can be found [here](https://docs.docker.com/install/).
    - For Mac users, if you have no previous Docker Toolbox installation, you can install Docker Desktop for Mac. If you already have a Docker Toolbox installation, please read [this](https://docs.docker.com/docker-for-mac/docker-toolbox/) before installing.
 - AWS Account
     - You can create an AWS account by signing up [here](https://aws.amazon.com/#).
     
## Project Steps

Completing the project involves several steps:

1. Write a Dockerfile for a simple Flask API
2. Build and test the container locally
3. Create an EKS cluster
4. Store a secret using AWS Parameter Store
5. Create a CodePipeline pipeline triggered by GitHub checkins
6. Create a CodeBuild stage which will build, test, and deploy your code

For more detail about each of these steps, see the project lesson.
