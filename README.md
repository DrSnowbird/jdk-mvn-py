# Java 8 (1.8.0_92) JRE server + Maven 3.3.9 + PyDev 2.7.11

Components:

* Oracle Java "1.8.0_92" JRE Runtime Environment for Server
  Java(TM) SE Runtime Environment (build 1.8.0_92-b14)
  Java HotSpot(TM) 64-Bit Server VM (build 25.92-b14, mixed mode)
* Apache Maven 3.3.9
* Python 2.7.11 with python-dev python-numpy

### Pull the image from Docker Repository


```bash
docker pull openkbs/jre-mvn-py
```

### Base the image to build add-on components:
```Dockerfile
FROM openkbs:jre-mvn-py
```

### Run the image

- make sure you create your work directory, e.g., /data

Then, you're ready to run :+1:

```bash
docker run -d --name my-jre-mvn-py -v /data:/data -i -t openkbs/jre-mvn-py
```
### Build and Run your own image
- Say, you will build the image "my/jre-mvn-py".

```bash
docker build -t my/jre-mvn-py .
```
To run your own image, say, with some-jre-mvn-my:

```bash
docker run -d --name some-jre-mvn-py -v /data:/data -i -t my/jre-mvn-py
```
