# build the image for the webserver.
docker buildx build --platform linux/amd64 -t demo/webserver:latest .

# start a container. map host port 8080 to container port 8080.
docker run -d -p 8080:8080 demo/webserver

# shell in just to poke around the container fs. 
docker exec -it <container id> bash 

# Authenticate to the AWS public ecr registry.
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/x0t1p1c7

# Re-tag the image.
docker tag demo/webserver:latest public.ecr.aws/x0t1p1c7/demo/webserver:latest

# Push to ECR. 
docker push public.ecr.aws/x0t1p1c7/demo/webserver:latest