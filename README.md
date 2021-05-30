docker-setup-test
=
This is a repository which is the base for a build we trust enough
to run online :P

`docker build --no-cache -t docker-setup-test .` build the code into a docker image called `docker-setup-test`.

to run the development environment, run `docker-compose build`, afterwards you can run `docker-compose up` to use
the project.