# OpenProject

Make sure you are using the latest version of the Docker images and launch the containers:

```shell
docker compose pull
```

**PORT**

By default the port is bound to `0.0.0.0` means access to OpenProject will be public.
See below how to change that.

If you want to specify a different port, you can do so with:

```
PORT=4000
```

If you don't want OpenProject to bind to `0.0.0.0` you can bind it to localhost only like this:

```
PORT=127.0.0.1:8080
```

**HTTPS/SSL**

OpenProject **does not** handle SSL termination itself. This
is usually done separately via a [reverse proxy
setup](https://www.openproject.org/docs/installation-and-operations/installation/docker/#apache-reverse-proxy-setup).
Without this you will run into an `ERR_SSL_PROTOCOL_ERROR` when accessing OpenProject.

You can disable OpenProject's HTTPS option via:

```
OPENPROJECT_HTTPS=false
```


## Admin User

The default username and password is login: `admin`, and password: `admin`.

In a manual installation, you will need to ssh to the web container and run
`bundle exec rake db:seed`

To change the password manually run the following commands inside the container

```shell
RAILS_ENV=production bundle exec rails c 
# Wait until the Ruby REPL finish loading...
admin = User.find_by(login: 'admin')
admin.password = 'admin'
# Must confirm to the password
admin.password_confirmation = 'admin'
admin.save!
# Watch the output for errors
```

## Configuration

Environment variables can be added to `docker-compose.yml` under `x-op-app -> environment` to change
OpenProject's configuration. Some are already defined and can be changed via the environment.

You can pass those variables directly when starting the stack as follows.

```
VARIABLE=value docker-compose up -d
```

You can also put those variables into an `.env` file in your current working directory, and Docker Compose will pick it up automatically. See `.env.example`
for details.


## Troubleshooting

You can look at the logs with:

    docker-compose logs -n 1000

For the complete documentation, please refer to https://docs.openproject.org/installation-and-operations/.

### Network issues

If you're running into weird network issues and timeouts such as the one described in
[OP#42802](https://community.openproject.org/work_packages/42802), you might have success in remove the two separate
frontend and backend networks. This might be connected to using podman for orchestration, although we haven't been able
to confirm this.


### SMTP setup fails: Network is unreachable.

Make sure your container has DNS resolution to access external SMTP server when set up as described in
[OP#44515](https://community.openproject.org/work_packages/44515).

```yml
worker:
   dns:
     - "Your DNS IP" # OR add a public DNS resolver like 8.8.8.8
 ```
