docker build -t jglatter/multi-client:latest -t jglatter/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t jglatter/multi-server:latest -t jglatter/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t jglatter/multi-worker:latest -t jglatter/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push jglatter/multi-client:latest
docker push jglatter/multi-server:latest
docker push jglatter/multi-worker:latest

docker push jglatter/multi-client:$GIT_SHA
docker push jglatter/multi-server:$GIT_SHA
docker push jglatter/multi-worker:$GIT_SHA


kubectl apply -f ./k8s
kubectl set image deployments/server-deployment server=jglatter/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=jglatter/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=jglatter/multi-worker:$GIT_SHA

