
# DevOps Coding Challenge

The Challenge is to read a log file in [cri-o](https://cri-o.io/) format and send it to elasticsearch.
I used python to write a code which opens the log file and splits each line with specific keywords and send them to elasticseach. The code has been tested both locally(on docker) and on EKS.





## Deployment

To deploy this project use helmfile to implement elasticsearch on your kubenetes cluster:

```
 helmfile apply
```

Verify that elasticseach and kibana service has been created:
```
 kubectl get svc
 ```
 Make sure and verify that elasticseach and kibana pods are running. Wait until you see both pods are in ```READY``` state:
 ```
 kubectl get pods
```

Use below command to create an index in kibana: (if everything works fine you can see ```INFO: Index pattern successfully created``` message)
```
 kubectl run index-shell --rm -i --image ellerbrock/alpine-bash-curl-ssl -- bash < createindexbash.sh
```
Use the helm to install the chart which is a job and runs the application. It uses the image which has been created by means of the Dockerfile which is in the ```dockerimage``` directory. you can find the python code in that folder too. The docker image has been uploaded to docker hub and is accessible to public. 
```
 helm install crio-log-job ./mychart
```
Use below commands to verify that the job has been ```Completed```:
```
 kubectl get jobs
 kubectl get pods
```
Now navigate to kibana on port 5601 and go to ```Discover``` which is under ```Analytics``` section to see the logs which has been indexed. (as I used EKS, I created an ALB ingress to access kibana, You can find the yaml file for it in ALBingress directory. If you want to use it, it is published on http port 80 and with the address http://elastickibana-crio-log.com. You can find the cname address by means of the following command)

```
 kubectl get ingress
```



## Note

Needless to say, you can find the python code in ```dockerimage``` directory by the name of ```main.py```

If you want to use the code locally on docker you should modify main.py to point to elasticsearch IP address. For example change ``` es = Elasticsearch( ['http://elasticsearch-master:9200'] ) ``` to ``` es = Elasticsearch( ['http://localhost:9200'] ) ```
## Future Improvements

1. This app can be implemented in a way that can read the file continuously and push them to elastic.

2. Also by using regex it can read other kinds of logs( as it only can index logs which is in cri-o format).


## Todo list to use the code as replacement for e.g. fluent bit

1. Reading from different sources: as this code only reads from a log file

2. Use of TLS/SSL: this code send the logs in cleartext and it can be improved to use TLS/SSL

3. Pushing the logs to different detinations not just leasticsearch
## Author

- [Hadi](hadi.mhn00@gmail.com)

