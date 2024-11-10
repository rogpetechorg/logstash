# Use a imagem base do Logstash
FROM docker.elastic.co/logstash/logstash:8.15.3

# Permite o uso de comandos de instalação como root
USER root

# Instala o vim
RUN apt-get update && apt-get install -y vim && rm -rf /var/lib/apt/lists/*

# Cria os diretórios para configuração, se necessário
RUN mkdir -p /usr/share/logstash/pipeline /usr/share/logstash/config

# Remove o pipeline padrão, se existir
RUN rm -f /usr/share/logstash/pipeline/logstash.conf

# Copia os arquivos de configuração e pipeline para o container
COPY config/ /usr/share/logstash/config/
COPY pipeline/ /usr/share/logstash/pipeline/

# Ajusta as permissões para o usuário logstash
RUN chown -R logstash:logstash /usr/share/logstash/config /usr/share/logstash/pipeline
RUN chmod -R 755 /usr/share/logstash/config /usr/share/logstash/pipeline

# Altera o usuário para logstash
USER logstash

# Exponha as portas necessárias
EXPOSE 5044 9600

# Comando para iniciar o Logstash com o pipeline especificado
CMD ["logstash", "-f", "/usr/share/logstash/pipeline/logstash.conf"]
