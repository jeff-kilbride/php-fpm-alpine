# PHP-FPM Docker Image on Alpine

This is a simple PHP-FPM installation running on Alpine Linux. It utilizes the official alpine:edge release and installs PHP packages via apk, the Alpine Linux package manager. Please see the Dockerfile for a list of PHP packages installed.

This image is created to enhance my own workflow. You are more than welcome to use it, if you are interested.

To use this image in your own Dockerfiles, add it to your FROM statement:

    FROM jkilbride/php-fpm-alpine

---
As an update, I have also added a simple `.profile` to the `/root` directory for times when I need to login to the container and look around. (I was getting tired of typing `alias ll="ls -lFa"` every time I needed to login...) To use it, type `. /root/.profile` at the command prompt. Be aware that I prefer `vi` keybindings. If you prefer the default `emacs` keybindings, simply type `set -o emacs` at the prompt.

## Nginx

This image is designed to work with my `nginx` image:  `jkilbride/nginx-alpine`. It creates a volume in the `/var/www` directory and copies the `info.php` file to `/var/www/app/webroot`. My `nginx` image is configured with `/var/www/app/webroot` as its document root. To run these two images together, type `docker-compose up -d` and point your web browser to `http://[your-docker-host]/info.php`. You should see the output of the `phpinfo()` command.

For a more interesting example, you can inject your own codebase into the `/var/www/app/webroot` directory of this image using a bind mount or a data volume. See the [Docker documentation on volumes](https://docs.docker.com/engine/userguide/containers/dockervolumes/) for more info.

## Maintainer

* [Jeff Kilbride](https://github.com/jeff-kilbride) jeff@kilbride.com

## Caveats

As Alpine Linux uses musl, you may run into some issues with environments expecting glibc-like behaviour (for example, Kubernetes). Some of these issues are documented here:

* http://gliderlabs.viewdocs.io/docker-alpine/caveats/
* https://github.com/gliderlabs/docker-alpine/issues/8

## License

The code is available under the [MIT License](/LICENSE).