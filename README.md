# Logstash

É necessário fazer criar dois volumes:
1. Name: config e Path: /usr/share/logstash/config
2. Name: pipeline e PAth: /usr/share/logstash/pipeline

Criar os arquivos
1. /usr/share/logstash/pipeline/logstash.conf 

```conf
input {
  beats {
    port => 5044
  }
}

output {
  elasticsearch {
    hosts => ["${ELASTICSEARCH_HOST}"]
    user => "${ELASTICSEARCH_USER}"
    password => "${ELASTICSEARCH_PASSWORD}"
    ssl => true
    ssl_certificate_verification => true
    cacert => "/etc/ssl/certs/ca-certificates.crt"
  }
}

2. Path: /usr/share/logstash/config/logstash.yml

```yml
node.name: "${LOGSTASH_NODE_NAME:logstash}"

xpack.monitoring.enabled: true
xpack.monitoring.elasticsearch.hosts: [ "${ELASTICSEARCH_HOST:http://elasticsearch:9200}" ]
xpack.monitoring.elasticsearch.username: "${ELASTICSEARCH_USER:logstash_internal}"
xpack.monitoring.elasticsearch.password: "${ELASTICSEARCH_PASSWORD}"

```

