local imageTag = std.extVar('mytag');
{
  components: {
  "app": {
    "image": {
      "repository": "gorkov/app",
      "tag": imageTag,
      "imagePullPolicy": "Always"
    }
  }    
  },
}