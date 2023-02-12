
local base = import './base.libsonnet';

 base {
   components +: {
     app +: {
       "replicaCount": 1,
       "deploymentName": "myapp",
       "serviceName": "myapp",
       "port": 8080,
       "targetPort": 80,
       "nodePort": 30222
     },          
  }
 }