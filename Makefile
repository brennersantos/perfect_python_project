# Makefile

.PHONY: install format lint test sec

install:
	@poetry install

format:
	@blue ./perfect_python_project/
	@isort ./perfect_python_project/
	@pycodestyle ./perfect_python_project/
	@pydocstyle ./perfect_python_project/
	@mypy ./perfect_python_project/
	
lint:
	@blue --check ./perfect_python_project/
	@isort --check ./perfect_python_project/
	@pycodestyle ./perfect_python_project/
	@pydocstyle ./perfect_python_project/
	@mypy ./perfect_python_project/

test:
	@pytest -v

sec:
	@pip-audit