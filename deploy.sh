docker build -t likcu/multi-client:latest -t likcu/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t likcu/multi-server:latest -t likcu/multi-server:$SHA -f ./client/Dockerfile ./client
docker build -t likcu/multi-worker:latest -t likcu/multi-worker:$SHA -f ./client/Dockerfile ./client
docker push likcu/multi-client:latest
docker push likcu/multi-server:latest
docker push likcu/multi-worker:latest
docker push likcu/multi-client:$SHA
docker push likcu/multi-server:$SHA
docker push likcu/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=likcu/multi-server:$SHA
kubectl set image deployments/client-deployment client=likcu/multi-client:$SHA
kubectl set image deployments/client-deployment client=likcu/multi-worker:$SHA