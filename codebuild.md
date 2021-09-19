## AWS Parameter Store

Add Parameter to Store
```
aws ssm put-parameter --name JWT_SECRET --overwrite --value "${JWT_SECRET}" --type SecureString --profile udacity-user --region us-east-2
```