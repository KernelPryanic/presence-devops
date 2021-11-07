external_url 'https://gitlab.presence.icu'
gitlab_rails['initial_root_password'] = File.read('/run/secrets/gitlab_root_password')
gitlab_rails['initial_shared_runners_registration_token'] = File.read('/run/secrets/gitlab_runner_token')

nginx['redirect_http_to_https'] = true
nginx['redirect_http_to_https_port'] = 80
# nginx['custom_gitlab_server_config'] = "location /.well-known/acme-challenge/ {\n root /var/opt/gitlab/nginx/www/; \n}\n"

letsencrypt['enable'] = true
letsencrypt['auto_renew'] = true
