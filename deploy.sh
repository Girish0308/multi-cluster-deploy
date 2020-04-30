docker build -t girish0308/multi-client:latest -t girish0308/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t girish0308/multi-server:latest -t girish0308/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t girish0308/multi-worker:latest -t girish0308/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push girish0308/multi-client:latest
docker push girish0308/multi-server:latest
docker push girish0308/multi-worker:latest

docker push girish0308/multi-client:$SHA
docker push girish0308/multi-server:$SHA
docker push girish0308/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=girish0308/multi-server:$SHA
kubectl set image deployments/client-deployment client=girish0308/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=girish0308/multi-worker:$SHA

