# Organisation Git repo for Jenkins X

This git repository contains all the cluster creation details for managing your Jenkins X installation.  The repo contains details of multiple clusters, for different Kubernetes cloud providers and the teams associated with them.

## Steps to Create Cluster

* `jx create terraform ...`
    * has a bug, have to raise issue
    * working on PR
* either go to repo in `.jx` folder
* or checkout from GitHub
    * and copy the GCP service account key json to <org-name>.key.json
    * and configure key location in `terraform.tfvars`
* `terraform init`
* `terraform plan`
* `terraform apply`
* get kubectl config
    * `gcloud container clusters get-credentials kearos-dev --zone europe-west4-a --project ...`
    * `gcloud container clusters get-credentials joostvdg-cbc --region europe-west4 --project ...`
    * confirm `kubectl get nodes -o wide`

## Node Pools

```bash
gcloud container node-pools list --cluster joostvdg-cbc --region europe-west4
```

## Install JX

* `jx install --ng`
* missing flags
    * project
    * zone
    * provider?
* make sure to use Let's Encrypt Production!
    * vault doesn't work with staging
* does not create webhooks, have to figure out why