docker build -t xjohnx/multi-client:latest -t xjohnx/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t xjohnx/multi-server:latest -t xjohnx/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t xjohnx/multi-worker:latest -t xjohnx/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push xjohnx/multi-client:latest
docker push xjohnx/multi-client:$SHA
docker push xjohnx/multi-server:latest
docker push xjohnx/multi-server:$SHA
docker push xjohnx/multi-worker:latest
docker push xjohnx/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=xjohnx/multi-server:$SHA
kubectl set image deployments/client-deployment client=xjohnx/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=xjohnx/multi-worker:$SHA