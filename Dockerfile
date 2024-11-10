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

# Exponha as portas necessárias
EXPOSE 5044 9600

# Comando para iniciar o Logstash com o pipeline especificado
CMD ["logstash", "-f", "/usr/share/logstash/pipeline/logstash.conf"]
