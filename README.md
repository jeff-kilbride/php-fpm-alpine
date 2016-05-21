# PHP-FPM Docker Image on Alpine


This is a simple PHP-FPM installation running on Alpine Linux. It utilizes the official alpine:3.3 release and installs PHP packages via apk, the Alpine Linux package manager. Please see the Dockerfile for a list of PHP packages installed.

This image is created to enhance my own workflow. You are more than welcome to use it, if you are interested.

To use this image in your own Dockerfiles, add it to your FROM statement:

    FROM jkilbride/php-fpm-alpine

---
As an update, I have also now added a simple `.profile` to the `/root` directory for times when I need to login to the container and look around. (I was getting tired of typing `alias ll="ls -lFa"` every time I needed to login...) To use it, type `. /root/.profile` at the command prompt. Be aware that I prefer `vi` keybindings. If you prefer the default `emacs` keybindings, simply type `set -o emacs` at the prompt.


## Maintainer

* [Jeff Kilbride](https://github.com/jeff-kilbride) jeff@kilbride.com

## Caveats

As Alpine Linux uses musl, you may run into some issues with environments expecting glibc-like behaviour (for example, Kubernetes). Some of these issues are documented here:

* http://gliderlabs.viewdocs.io/docker-alpine/caveats/
* https://github.com/gliderlabs/docker-alpine/issues/8

## License

The code is available under the [MIT License](/LICENSE).