[supervisord]
nodaemon=true

[program:php-fpm]
command=php-fpm -F
autostart=true
autorestart=true
priority=5
stdout_events_enabled=true
stderr_events_enabled=true