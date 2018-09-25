FROM ubuntu:18.04

RUN  apt-get update \
  && apt-get install -qq -y --no-install-recommends python3 python3-pip libtool libffi-dev ruby ruby-dev make \
                     libzmq3-dev libczmq-dev \
  && gem install --no-ri --no-rdoc cztop iruby aws-sdk cfndsl pry awesome_print gnuplot rubyvis nyaplot \
  && apt-get clean -y \
  && apt-get autoclean -y \
  && apt-get autoremove -y \
  && rm -rf /usr/share/locale/* \
  && rm -rf /var/cache/debconf/*-old \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /usr/share/doc/*

RUN pip3 install --upgrade setuptools \
  && pip3 install ipython \ 
  && pip3 install jupyter 

RUN echo "add in non-root user" \
  && groupadd -g 1000 app \
  && useradd -d "/home/app" -u 1000 -g 1000 -m -s /bin/bash app

COPY run-iruby.sh /usr/local/bin

USER app

WORKDIR /app

ENTRYPOINT ["/usr/local/bin/run-iruby.sh"]
