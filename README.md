## Projeto Python Perfeito
Passos que segui para a criação desse setup:

### Referências
* [Como organizar um projeto Python? - Live de Python #192](https://www.youtube.com/watch?v=O3bs4JtHrow) | Eduardo Mendes
* [Como Começar um Projeto Python Perfeito](https://blog.pronus.io/posts/python/como-comecar-um-projeto-python-perfeito/) | André Felipe Dias

### Passos
1. Criar repositório no Git
2. Criar pastas para a documentação (docs), os testes (tests) e o código fonte (perfect_python_project - nome do projeto)
3. Criar documento README.md
4. Criar documento [.gitignore](https://www.toptal.com/developers/gitignore)
5. Escolher versão do python com o pyenv
`pyenv install python-version`
`pyenv local python-version`
6. Iniciar o poetry para gerenciar o ambiente virtual
`poetry init -n`
`poetry shell`
7. Instalar pacotes para a documentação 
`poetry add --dev mkdocs`
`mkdocs new .`
8. Instalar pacotes para os tests
`poetry add --dev pytest`
9. Instalar pacotes para o código fonte
`poetry add --dev blue`
`poetry add --dev isort`
`poetry add --dev pip-audit`

10. Criar arquivo Makefile
```
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
```

11. Ciar arquivo ./.git/hooks/pre-commit e dar permissão de execução
```
make format
make lint
make test
```
`chmod +x ./.git/hooks/pre-commit`

12. Criar arquivo 
`touch ./.github/workflows/continuous_integration.yml`
```
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
```
