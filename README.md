# cAdvisor Sandbox

This repository contains a basic **cAdvisor** configuration example.

**cAdvisor** (Container Advisor) provides container users an understanding of the resource usage and 
performance characteristics of their running containers.

All the metrics from the running containers are gathered and pulled by **Prometheus**.
They can be visualised in **Grafana**.

More detailed documentation of the **[cAdvisor](https://github.com/google/cadvisor)**.

To run this example **Podman** installation is required.

## Diagram

![](diagram/flow.svg)

## Instructions

- Run `make up` to start up this example (run `make` to see full list of options).
- Observe metrics on the **Grafana** dashboard [localhost:3000](http://localhost:3000).
- Configure a dashboard to visualise all the metrics.
