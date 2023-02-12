local p = import '../params.libsonnet';
local params = p.components.app;

[
{
  "apiVersion": "apps/v1",
  "kind": "Deployment",
  "metadata": {
    "labels": {
      "app": "myapp"
    },
    "name": params.deploymentName
  },
  "spec": {
    "replicas": params.replicaCount,
    "selector": {
      "matchLabels": {
        "app": "myapp"
      }
    },
    "template": {
      "metadata": {
        "labels": {
          "app": "myapp"
        }
      },
      "spec": {
        "containers": [
          {
            "image":  params.image.repository+':'+params.image.tag,
            "imagePullPolicy": "Always",
            "name": "myapp",
            "ports": [
              {
                "containerPort": params.port
              }
            ]              
          }
        ]
      }
    }
  }
},
{
  "apiVersion": "v1",
  "kind": "Service",
  "metadata": {
    "name": params.serviceName
  },
  "spec": {
    "ports": [
      {
        "name": "web",
        "port": params.port,
        "targetPort": params.targetPort,
        "nodePort": params.nodePort,         
      }
    ],
    "selector": {
      "app": "myapp"
    },
    "type": "NodePort"
  }
}

]