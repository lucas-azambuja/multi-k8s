docker build -t lucasazambuja/multi-docker-client:latest -t lucasazambuja/multi-docker-client:$SHA -f ./client/Dockerfile ./client
docker build -t lucasazambuja/multi-docker-server:latest -t lucasazambuja/multi-docker-server:$SHA -f ./server/Dockerfile ./server
docker build -t lucasazambuja/multi-docker-worker:latest -t lucasazambuja/multi-docker-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lucasazambuja/multi-docker-client:latest
docker push lucasazambuja/multi-docker-client:$SHA
docker push lucasazambuja/multi-docker-server:latest
docker push lucasazambuja/multi-docker-server:$SHA
docker push lucasazambuja/multi-docker-worker:latest
docker push lucasazambuja/multi-docker-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lucasazambuja/multi-docker-server:$SHA
kubectl set image deployments/client-deployment client=lucasazambuja/multi-docker-client:$SHA
kubectl set image deployments/worker-deployment worker=lucasazambuja/multi-docker-worker:$SHA