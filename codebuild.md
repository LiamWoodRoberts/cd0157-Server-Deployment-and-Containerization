## AWS Parameter Store

Add Parameter to Store
```
aws ssm put-parameter --name JWT_SECRET --overwrite --value "${JWT_SECRET}" --type SecureString --profile udacity-user --region us-east-2
```

## Testing Endpoint

Get Endpoint Extrenal IP
```
kubectl get services simple-jwt-api -o wide
```

Extrenal IP: ad2e72c0b0ec34b79b5c0aeb675f43dd-465184208.us-east-2.elb.amazonaws.com

Test Endpoint
```
export TOKEN=`curl -d '{"email":"wolf@thedoor.com","password":"huff-puff"}' -H "Content-Type: application/json" -X POST ad2e72c0b0ec34b79b5c0aeb675f43dd-465184208.us-east-2.elb.amazonaws.com/auth  | jq -r '.token'`
curl --request GET 'ad2e72c0b0ec34b79b5c0aeb675f43dd-465184208.us-east-2.elb.amazonaws.com/contents' -H "Authorization: Bearer ${TOKEN}" | jq
```
