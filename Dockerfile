FROM docker.elastic.co/logstash/logstash:8.5.3

# Remove a configuração padrão
RUN rm -f /usr/share/logstash/pipeline/logstash.conf

# Copia os arquivos de configuração e pipeline para o container
COPY --chown=logstash:logstash config/ /usr/share/logstash/config/
COPY --chown=logstash:logstash pipeline/ /usr/share/logstash/pipeline/

# Exponha as portas necessárias
EXPOSE 5044 9600

