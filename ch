Namespaces:
------------------
You can get a list of the namespaces in the cluster like this:
kubectl get namespaces
create your own namespaces:
kubectl create ns my-ns
To assign an object to a custom namespace:
----------------------------------------------------------
apiVersion: v1
kind: Pod
metadata:
  name: my-ns-pod
  namespace: my-ns
  labels:
    app: myapp
spec:
  containers:
  - name: myapp-container
    image: busybox
    command: ['sh', '-c', 'echo Hello Kubernetes! && sleep 3600']

kubectl create -f my-ns.yml
kubectl get pods -n my-ns
kubectl describe pod my-ns-pod -n my-ns


You can specify custom commands for your containers:
--------------------------------------------------------------------------
apiVersion: v1
kind: Pod
metadata:
  name: my-command-pod
  labels:
    app: myapp
spec:
  containers:
  - name: myapp-container
    image: busybox
    command: ['echo']
  restartPolicy: Never

You can also add custom arguments like so:
----------------------------------------------------------
apiVersion: v1
kind: Pod
metadata:
  name: my-args-pod
  labels:
    app: myapp
spec:
  containers:
  - name: myapp-container
    image: busybox
    command: ['echo']
    args: ['This is my custom argument']
  restartPolicy: Never


containerPort:
---------------------
apiVersion: v1
kind: Pod
metadata:
  name: my-containerport-pod
  labels:
    app: myapp
spec:
  containers:
  - name: myapp-container
    image: nginx
    ports:
    - containerPort: 80


SecurityContexts:
-----------------------
Exec below commands in K8s Nodes
First, create some users, groups, and files on both worker nodes which we can use for testing.
"
sudo useradd -u 2000 user1
sudo groupadd -g 3000 group1
sudo useradd -u 2001 user2
sudo groupadd -g 3001 group2
sudo mkdir -p /etc/message/
vi  /etc/message/message.txt
Hello all

sudo chown 2000:3000 /etc/message/message.txt
sudo chmod 640 /etc/message/message.txt
"

vi my-securitycontext-pod.yml
---------------------------------------
apiVersion: v1
kind: Pod
metadata:
  name: my-securitycontext-pod
spec:
  containers:
  - name: myapp-container
    image: busybox
    command: ['sh', '-c', "cat /message/message.txt && sleep 3600"]

kubectl create -f my-securitycontext-pod.yml
kubectl get pods
kubectl logs my-securitycontext-pod
kubectl exec my-securitycontext-pod -- ps
kubectl delete pod my-securitycontext-pod 

vi my-securitycontext-pod.yml
---------------------------------------
apiVersion: v1
kind: Pod
metadata:
  name: my-securitycontext-pod
spec:
  securityContext:
    runAsUser: 2000
    fsGroup: 3000
  containers:
  - name: myapp-container
    image: busybox
    command: ['sh', '-c', "cat /message/message.txt && sleep 3600"]

kubectl create -f my-securitycontext-pod.yml
kubectl get pods
kubectl logs my-securitycontext-pod
kubectl exec my-securitycontext-pod -- ps
kubectl delete pod my-securitycontext-pod 

Now try with another user & group

Resource Requiremnts:
----------------------------------
Kubernetes is a powerful tool for managing and utilizing available resources to run container
vi rr.yml
------------
apiVersion: v1
kind: Pod
metadata:
  name: my-resource-pod
spec:
  containers:
  - name: myapp-container
    image: busybox
    command: ['sh', '-c', 'echo Hello Kubernetes! && sleep 3600']
    resources:
      requests:
        memory: "64Mi"
        cpu: "250m"
      limits:
        memory: "128Mi"
        cpu: "500m"


Multi-Container Pods:
==================
mcpod.yml
--------------
apiVersion: v1
kind: Pod
metadata:
  name: multi-container-pod
spec:
  containers:
  - name: nginx
    image: nginx:1.15.8
    ports:
    - containerPort: 80
  - name: busybox-sidecar
    image: busybox
    command: ['sh', '-c', 'while true; do sleep 30; done;']

kubectl apply -f mcpod.yml
kubectl get pods

<html>  
<head>  
<script type="text/javascript">  
function msg(){  
 alert("Hello Javatpoint");  
}  
</script>  
</head>  
<body>  
<p>Welcome to JavaScript</p>  
<form>  
<input type="button" value="click" onclick="msg()"/>  
</form>  
</body>  
</html>
powerstar pawankalyan
megastar
megapowerstar
