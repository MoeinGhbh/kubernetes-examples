Kubernetes command:

kubectl get all

-----------------------------------Pod------------------

pod.yaml
command:

- kubectl apply -f pod.yaml
- kubectl get pods
- kubectl describe pod nginx

```
apiVersion: v1
kind: Pod
metadata:
    name: nginx
    lables:
        app: nginx
        tier: frontend
spec:
    containers:
        - name: redis-app
        image: redis
        - name: busybox
        imge: busybox
```

--------------------------ReplicationController-----------



replicaset-definition.yml

- kubectl create -f replicaset-definition.yml
- kubectl get replicationcontroller

```
apiVersion: v1
kind: replicationController
metadata:
    name: mapp-rc
    labels:
        app:myapp
        type: front-end
spec:
    replicas: 3
    template:
        metadata:
            name: myapp-pod
            labels:
                app: myapp
                type: fornt-end
spec:
    containers:
        - name: name
          image: nginx
```

------------------------------Replicaset----------------------

re-definition.yaml
kubectl create -f rc-definition.yml

command

- kubectl get replicaset
- kubectl delete replicaset myapp-replicaset
(Also delete all underlying PODs)

scale:

- kubectl replace -f replicaset-definition.yml
- kubectl scale --replicas=6 -f replicaset-definition.yml
- kubectl scale --repicas=6 replicaset myapp-replicaset (type-name )

```
apiVersion: apps/v1
kind: ReplicaSet
metadata:
    name: myapp-replicaset
    labels:
        app: myapp
        type: fron-tend
spec:
    replicas: 3
    selector:
    matchLabels:
        typr: frontend4
    template:
        metadata:
            name: myapp-pod
            labels:
                app: myapp
                type: fornt-end
    spec:
        containers:
            - name: nginx-container
              image: nginx
```
---------------------------------Deployment--------------------

deployment.yaml

Command:

- kubectl create -f deployment-definition.yml
- kubectl get deployments
- kubectl describe deployment name-deployment-app
- kubectl delete deployment name-deployment-app

```
apiVersion: apps/v1
Kind: deployment
metadata:
    name: myapp-deployment
    labels:
        tier: fontend
        app: nginx
spec:
    replicas: 4
    selector:
        matchLabels:
            app: myapp
    template:
        containers:
        metadata:
            name: nginx-2
            labels:
                app: myapp
spec:
containers:
    - name: forntend4
      image: redis
```

-------------  rollout  ------------------

checking the status of deployment file

- kubectl rollout status deployment/myapp-deployment
- kubectl rollout history deployment/myapp-deployment

- kubectl create -f deployment-definition.yml --record=true

(record history of deployment)

- kubectl edit -f deployment-definition.yml --record

- kubectl set image deployment maypp-deployment nginx=nginx:1.18-perl --record

undo

- kubectl rollout status deployment/myapp-deployment




NOTE:

kubectl apply command can be used to update an already existing deployment, kubectl create but cannot. 


Service:

Help us to connetivity between group of pods

(forntend backend external datasource and user from out)


Kubernetes service is an object, one of them listen to the report and forward request fron that port to the to that port that running the web application


NodePort (30000-32767)   --> work with cluster IP (10.244.0.0)

- kubectl -f create service-definition.yml
- kubectl get services

```
apiVersion: v1
Kind: Service
metadata:
    name: myapp-service
spec:
    type: NodePort
    ports:
       - targetPort: 80
         port: 80
         nodePort: 30008
    selector:
        app: myapp
        type: frontend
```

----------------------------------------------

Cluster IP

- kubectl -f create service-definition.yml

```
apiVersion: v1
Kind: Service
metadata:
    name: myapp-service
spec:
    type: ClusterIP
    ports:
       - targetPort: 80
         port: 80
        
    selector:
        app: myapp
        type: frontend
```




Loadbalancing

```
apiVersion: v1
Kind: Service
metadata:
    name: myapp-service
spec:
    type: loadbalancing
    ports:
       - targetPort: 80
         port: 80
         nodePort: 30008
```
 
	
