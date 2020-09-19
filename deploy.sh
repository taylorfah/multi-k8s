docker build -t tfah/multi-client:latest -t tfah/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tfah/multi-server:latest -t tfah/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tfah/multi-worker:latest -t tfah/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tfah/multi-client:latest
docker push tfah/multi-server:latest
docker push tfah/multi-worker:latest

docker push tfah/multi-client:$SHA
docker push tfah/multi-server:$SHA
docker push tfah/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=tfah/multi-client:$SHA
kubectl set image deployments/server-deployment server=tfah/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=tfah/multi-worker:$SHA