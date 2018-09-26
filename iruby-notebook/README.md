# Run

``` 
docker run -it --rm -p 8888:8888 -v $PWD:/app macbasket/iruby-notebook --notebook-dir /app
```

``` 
docker run -it --rm -p 8888:8888 -v $PWD:/app macbasket/iruby-notebook --notebook-dir /app -h
```

Use --NotebookApp.token=${TOKEN} to set a token for logon.

get the key and logon to localhost:8888

# Notes for mac:

runs as 1000:1000

For mac to get rw on a volume mount you may need something like this:

```
PASS=`uuidgen`
echo ${PASS}
docker run -it --rm -p 8888:8888 -v ${PWD}:/app:rw -v ${PWD}/local:/.local -v ${PWD}/ipython:/.ipython -v ${PWD}/.jupyter:/.jupyter --user 502  macbasket/iruby-notebook:latest --NotebookApp.token=${PASS}
```

Or this:

```
FROM macbasket/iruby-notebook

RUN echo "add in non-root user" \
  && groupadd -g 500 person \
  && useradd -d "/home/person" -u 500 -g 500 -m -s /bin/bash person

USER person
```