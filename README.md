
# terraform-gcloud-kubernetes

A simple example that deploys both a gcloud cluster & wordpress


A few commands are run in the local-exec step inside of `cluster.tf`

You can use `kubectl get service` to monitor the external IP address of wordpress



# To run

`terraform apply`

# To remove

`terraform destroy`

- Remove gcloud compute disks
`gcloud compute disks delete mysql-disk --zone europe-west1-b`
`gcloud compute disks delete wordpress-disk --zone europe-west1-b`
