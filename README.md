
# terraform-gcloud-kubernetes

A simple example that deploys both a gcloud cluster & wordpress


A few commands are run in the local-exec step inside of `cluster.tf`

You can use `kubectl get service` to monitor the external IP address of wordpress



# To run

- You will need account.json which should be a service account in gcloud
- You will also need to change the `variables.tf` with real project ID that has compute API enabled!

`terraform apply`

# To remove

`terraform destroy`
