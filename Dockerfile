FROM python:3

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  sudo curl wget ca-certificates gnupg2 && \
  curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
  curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
  # odbc dependencies
  apt-get update && \
  apt-get install -y --no-install-recommends \
  unixodbc-dev && \
  ACCEPT_EULA=Y apt-get install msodbcsql17 -y && \
  # remove temp files
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /opt/odbc

# install MS ODBC
COPY odbc/installodbc.sh .
RUN ./installodbc.sh

CMD ["/bin/bash"]
