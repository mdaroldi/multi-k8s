docker build -t mdaroldi/multi-client:latest -t mdaroldi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mdaroldi/multi-server:latest -t mdaroldi/multi-server:$SHA -f ./server/Dockerfile ./server 
docker build -t mdaroldi/multi-worker:latest -t mdaroldi/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mdaroldi/multi-client:latest
docker push mdaroldi/multi-server:latest
docker push mdaroldi/multi-worker:latest

docker push mdaroldi/multi-client:$SHA
docker push mdaroldi/multi-server:$SHA
docker push mdaroldi/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mdaroldi/multi-server:$SHA
kubectl set image deployments/client-deployment client=mdaroldi/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mdaroldi/multi-worker:$SHA
