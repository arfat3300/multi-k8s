docker build -t arfatahmad/multi-client:latest -t arfatahmad/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t arfatahmad/multi-server:latest -t arfatahmad/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t arfatahmad/multi-worker:latest -t arfatahmad/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push arfatahmad/multi-client:latest
docker push arfatahmad/multi-server:latest
docker push arfatahmad/multi-worker:latest

docker push arfatahmad/multi-client:$SHA
docker push arfatahmad/multi-server:$SHA
docker push arfatahmad/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=arfatahmad/multi-client:$SHA
kubectl set image deployments/server-deployment server=arfatahmad/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=arfatahmad/multi-worker:$SHA