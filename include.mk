NAME := python
VERSION := v1

MYDIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
export PATH := $(MYDIR)/bin:$(PATH)

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

# Specific targets
install-$(NAME)-dev-dependencies:
	pip3 install -r $(MYDIR)/requirements.txt

.PHONY: lint-$(NAME)-black lint-$(NAME)-isort lint-$(NAME)-flake8 lint-$(NAME)-mypy
lint-$(NAME): lint-$(NAME)-black lint-$(NAME)-isort lint-$(NAME)-flake8 lint-$(NAME)-mypy

lint-$(NAME)-black:
	find_py | xargs --no-run-if-empty black --check

lint-$(NAME)-isort:
	find_py | xargs --no-run-if-empty isort --check

lint-$(NAME)-flake8:
	find_py | xargs --no-run-if-empty flake8

lint-$(NAME)-mypy:
	find_py | xargs --no-run-if-empty mypy --install-types --non-interactive

.PHONY: fix-$(NAME)-black fix-$(NAME)-isort
fix-$(NAME): fix-$(NAME)-black fix-$(NAME)-isort

fix-$(NAME)-black:
	find_py | xargs --no-run-if-empty black

fix-$(NAME)-isort:
	find_py | xargs --no-run-if-empty isort

.PHONY: test-$(NAME)-pytest
test-$(NAME): test-$(NAME)-pytest

test-$(NAME)-pytest:
	python3 -m pytest

package-$(NAME):
	python3 -m build --sdist --wheel
