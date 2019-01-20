docker build -t sainumtown/multi-client:latest -t sainumtown/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sainumtown/multi-server:latest -t sainumtown/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sainumtown/multi-worker:latest -t sainumtown/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sainumtown/multi-client:latest
docker push sainumtown/multi-server:latest
docker push sainumtown/multi-worker:latest

docker push sainumtown/multi-client:$SHA
docker push sainumtown/multi-server:$SHA
docker push sainumtown/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sainumtown/multi-server:$SHA
kubectl set image deployments/client-deployment client=sainumtown/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sainumtown/multi-worker:$SHA