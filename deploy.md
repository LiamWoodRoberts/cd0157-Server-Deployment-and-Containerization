## Creating an EKS Cluster

Create Cluster
```
eksctl create cluster --name simple-jwt-api --region=us-east-2 --profile udacity-user
```

Verify Cluster Built Successfully
```
kubectl get nodes
```

## IAM

Get Account Id
```
aws sts get-caller-identity --query Account --output text --profile udacity-user
```

Account Id: 274927094101

Create an IAM Role using trust.json relationship
```
aws iam create-role --role-name UdacityFlaskProjectKubectlRole --assume-role-policy-document file://trust.json --output text --query 'Role.Arn' --profile udacity-user
```

Attatch Policy to Role
```
aws iam put-role-policy --role-name UdacityFlaskProjectKubectlRole --policy-name eks-describe --policy-document file://iam-role-policy.json --profile udacity-user
```

## Allow IAM Role Access to Cluster

Fetch Current Config Map
```
kubectl get -n kube-system configmap/aws-auth -o yaml > aws-auth-patch.yml
```

Update Config Map
```
kubectl patch configmap/aws-auth -n kube-system --patch "$(cat aws-auth-patch.yml)"
```
## Project Clean Up
Delete Cluster
```
eksctl delete cluster --name simple-jwt-api --region=us-east-2 --profile udacity-user
```