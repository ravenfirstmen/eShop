# About

Deploying eShop apps on kubernetes (k3d) and set observability with grafana instead of aspire.

## Dependencies

- .NET SDK 8
- Install `aspirate` (https://github.com/prom3theu5/aspirational-manifests)
 
## How to

- Generate the certificates to setup a secure private regitry. (Only after .NET 8.0.4 will be possible to use insecure registries.)
    - `./00-generate-registry-certificates.sh`
- Install the CA in your system
    - `./01-install-registry-ca-certificate.sh`

- Start the cluster
    - `./start-cluster.sh`
    (The cluster has monitoring stack installed - Grafana, Loki, Tempo, Prometheus and Open Telementry collector)

- Prepare the solution
    - `./prepare.sh`

- Apply the manifests
    - `./apply.sh`

....

- Destroy everything
    - `./stop-cluster.sh`


