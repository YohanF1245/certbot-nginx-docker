FROM nginx:latest

# Install cron
RUN apt-get update && apt-get install -y cron

# Add crontab file in the cron directory
RUN echo "0 6 * * * /usr/sbin/nginx -s reload > /var/log/nginx/cronreload.log 2>&1\n" > /etc/cron.d/nginx-reload-cron

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/nginx-reload-cron

# Apply cron job
RUN crontab /etc/cron.d/nginx-reload-cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Run the command on container startup
CMD sh -c 'cron && nginx -g "daemon off;"'
