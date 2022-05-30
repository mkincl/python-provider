NAME := python
VERSION := v1

MYDIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

# Container target
IMAGE_PYTHON := ghcr.io/mkincl/$(NAME)-provider:$(VERSION)

.PHONY: enter-container-$(NAME)
enter-container-$(NAME):
	docker run --rm --interactive --tty --pull always --volume "$$(pwd)":/pwd --workdir /pwd $(IMAGE_PYTHON)

# Generic targets
.PHONY: lint lint-$(NAME)
lint: lint-$(NAME)

.PHONY: fix fix-$(NAME)
fix: fix-$(NAME)

.PHONY: test test-$(NAME)
test: test-$(NAME)

.PHONY: package package-$(NAME)
package: package-$(NAME)

# Which files to act on. This is overrideable.
FILES_PYTHON = $(shell $(MYDIR)/bin/find_py)

.PHONY: has-files-python
has-files-python:
	@for file in $(FILES_PYTHON); do exit 0; done; echo "FILES_PYTHON is empty"; exit 1

# Specific targets
install-$(NAME)-dev-dependencies:
	pip3 install -r $(MYDIR)/requirements.txt

.PHONY: lint-$(NAME)-black lint-$(NAME)-isort lint-$(NAME)-flake8 lint-$(NAME)-mypy
lint-$(NAME): lint-$(NAME)-black lint-$(NAME)-isort lint-$(NAME)-flake8 lint-$(NAME)-mypy

lint-$(NAME)-black: has-files-python
	black --check $(FILES_PYTHON)

lint-$(NAME)-isort: has-files-python
	isort --check $(FILES_PYTHON)

lint-$(NAME)-flake8: has-files-python
	flake8 $(FILES_PYTHON)

lint-$(NAME)-mypy: has-files-python
	mypy --install-types --non-interactive $(FILES_PYTHON)

.PHONY: fix-$(NAME)-black fix-$(NAME)-isort
fix-$(NAME): fix-$(NAME)-black fix-$(NAME)-isort

fix-$(NAME)-black: has-files-python
	black $(FILES_PYTHON)

fix-$(NAME)-isort: has-files-python
	isort $(FILES_PYTHON)

.PHONY: test-$(NAME)-pytest
test-$(NAME): test-$(NAME)-pytest

test-$(NAME)-pytest:
	python3 -m pytest

package-$(NAME):
	python3 -m build --sdist --wheel
