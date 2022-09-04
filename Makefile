.PHONY: install format lint test sec

install:
	@poetry install

install_hooks:
    scripts/install_hooks.sh

format:
	@blue .
	@isort .
	
lint:
	@blue  . --check
	@isort . --check
	
test:
	@pytest -v

sec:
	@pip-audit