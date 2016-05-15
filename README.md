# Java 8 JRE server + Maven 3 + PyDev

Basic Components:

 * Oracle Java 1.8.0-92 JRE Runtime Environment for Server
 * Python Stacks: python python-setuptools python-dev python-numpy
 * Apache Maven 3.3.9


### Pull the image from Docker Repository


```bash
docker pull openkbs/jre-mvn-py
```

### To Run the image

- make sure you create your work directory, e.g., /data

Then, you're ready to run :+1:

```bash
docker run -d --name my-jre-mvn-py -v /data:/data -i -t openkbs/jre-mvn-py
```
### Build the image
- Say, you will build the image "my/jre-mvn-py".

```bash
docker build -t my/jre-mvn-py .
```
