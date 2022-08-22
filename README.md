# mkincl-python

[mkincl](https://github.com/mkincl/mkincl) provider for Python
development.

## About

Provides targets for running:

* [flake8](https://github.com/PyCQA/flake8)
* [isort](https://github.com/PyCQA/isort)
* [mypy](https://github.com/python/mypy)
* [black](https://github.com/psf/black)
* [pytest](https://github.com/pytest-dev/pytest)

Provides the Docker image `ghcr.io/mkincl/python-provider:v1`. This image can
be entered by running (after initialization):

```sh
make enter-container-python
```

## Usage

To initialize the provider and enable all Make targets, run:

```sh
make init
```

After this has been done you can run all linters with:

```sh
make lint
```

You can apply fixes with:

```sh
make fix
```

You can run tests via:

```sh
make test
```

If your project is using multiple providers and you just want to run the
tooling from this provider, append `-python` to the make target:

```sh
make <action>-python
```

To install the development dependencies this provider requires in your
environment, run:

```sh
make install-python-dev-dependencies
```
