docker build -t jorgensta/m-client:latest -t jorgensta/m-client:$SHA -f ./client/Dockerfile ./client
docker build -t jorgensta/m-server:latest -t jorgensta/m-server:$SHA -f ./server/Dockerfile ./server
docker build -t jorgensta/m-worker:latest -t jorgensta/m-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jorgensta/m-client:latest
docker push jorgensta/m-server:latest
docker push jorgensta/m-worker:latest

docker push jorgensta/m-client:$SHA
docker push jorgensta/m-server:$SHA
docker push jorgensta/m-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=jorgensta/m-server:$SHA
kubectl set image deployments/worker-deployment worker=jorgensta/m-worker:$SHA
kubectl set image deployments/client-deployment client=jorgensta/m-client:$SHA
