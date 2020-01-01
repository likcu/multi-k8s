docker build -t jessielee716/multi-client:latest -t jessielee716/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jessielee716/multi-server:latest -t jessielee716/multi-server:$SHA -f ./client/Dockerfile ./client
docker build -t jessielee716/multi-worker:latest -t jessielee716/multi-worker:$SHA -f ./client/Dockerfile ./client
docker push jessielee716/multi-client:latest
docker push jessielee716/multi-server:latest
docker push jessielee716/multi-worker:latest
docker push jessielee716/multi-client:$SHA
docker push jessielee716/multi-server:$SHA
docker push jessielee716/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jessielee716/multi-server:$SHA
kubectl set image deployments/client-deployment client=jessielee716/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jessielee716/multi-worker:$SHA