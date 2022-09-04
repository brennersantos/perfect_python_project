Referências:
https://www.youtube.com/watch?v=O3bs4JtHrow
https://blog.pronus.io/posts/python/como-comecar-um-projeto-python-perfeito/

* Criar repositório no Git
* Criar pastas para a documentação (docs), os testes (tests) e o código fonte (perfect_python_project - nome do projeto)
* Criar documento README.md
* Criar documento .gitignore
https://www.toptal.com/developers/gitignore

* Escolher versão do python com o pyenv
pyenv install <python-version>
pyenv local <python-version>

* Iniciar o poetry para gerenciar o ambiente virtual
poetry init -n
poetry shell

* Instalar pacotes para a documentação 
poetry add --dev mkdocs
mkdocs new .

* Instalar pacotes para os tests
poetry add --dev pytest

* Instalar pacotes para o código fonte
poetry add --dev blue
poetry add --dev isort
poetry add --dev prospector
poetry add --dev pip-audit

* Criar arquivo Makefile
.PHONY: install format lint test sec

install:
	@poetry install
format:
	@blue .
	@isort .
	@prospector .
lint:
	@blue --check .
	@isort --check .
	@propector 
test:
	@pytest -v
sec:
	@pip-audit

* Ciar arquivo ./.git/hooks/pre-commit e dar permissão de execução
make lint
make test
make sec

chmod +x ./.git/hooks/pre-commit


* Criar arquivo ./.github/workflows/continuous_integration.yml

name: Coninuous Integration
on: [push]
jobs:
  lint_and_test:
    runs-on: ubuntu-latest
    steps:

      - name: Set up python
        uses: actions/setup-python@v2
        with:
            python-version: <python-version>

      - name: Check out repository
        uses: actions/checkout@v2

      - name: Install Poetry
        uses: snok/install-poetry@v1
        with:
            virtualenvs-in-project: true
      
      - name: Load cached venv
        id: cached-poetry-dependencies
        uses: actions/cache@v2
        with:
            path: .venv
            key: venv-${{ hashFiles('**/poetry.lock') }}

      - name: Install dependencies
        if: steps.cached-poetry-dependencies.outputs.cache-hit != 'true'
        run: poetry install --no-interaction

      - name: Run Lint
        run: poetry run make lint

      - name: Run Test
        run: poetry run make test
      
      - name: Run Sec
        run: poetry run make sec