# Ferramenta para randomização em ensaios clínicos <a href='https://github.com/brunomontezano/randomizacao-shiny/'><img src='assets/clinical_trial.webp' align="right" height="139" alt="Doctor and patient" /></a>

[![DOI](https://zenodo.org/badge/782120300.svg)](https://zenodo.org/doi/10.5281/zenodo.10970915)

Trata-se de um gerador de tabela de randomização para ensaios clínicos
desenvolvido em R e Shiny. O projeto está publicado no
[shinyapps.io](https://brunomontezano.shinyapps.io/randomizacao-shiny/).

O aplicativo web gera duas tabelas: uma tabela para randomização e uma segunda
tabela para revelar os braços de tratamento inicialmente cegados.

A chave para aleatorização do processo está nas funções `sample` e `set.seed`
do R. A primeira é usada para sortear valores de forma (pseudo) aleatória, e a
segunda função serve para garantir a replicabilidade de rotinas que usam da
aleatoridade dentro do R.

Por meio do `set.seed`, toda vez que o mesmo número (chave inicial) for usado
como a "semente", as mesmas tabelas randomizadas serão geradas, e isso garante
que os resultados possam ser replicados por pares e demais pesquisadores.

Dentro do web app, existem dois botões que podem ser usados para baixar ambas
tabelas para um computador local em formato CSV.

O projeto se baseou em um projeto similar da autora
[aurora-mareviv](https://github.com/aurora-mareviv).

## Licença

O repositório está licenciado pela GPL-3. Leia a licença completa no arquivo
`LICENSE`.

## For english speakers

It is a randomization table generator for clinical trials developed in R and
Shiny. The project is published on
[shinyapps.io](https://brunomontezano.shinyapps.io/randomizacao-shiny/).

The web application generates two tables: a table for randomization and a second
table to reveal the initially blinded treatment arms.

The key to randomizing the process is in the `sample` and `set.seed` R
functions. The `sample` function is used to select values in a (pseudo) random
manner, and the `set.seed` function serves to guarantee the replicability of
routines that use randomness inside R.

Through `set.seed`, every time the same number (initial key) is used as the
"seed", the same randomized tables will be generated, and this ensures that the
results can be replicated by peers and other researchers.

Within the web app, there are two buttons that can be used to download both
tables to a local computer in CSV format.

The project was based on a similar project by the author
[aurora-mareviv](https://github.com/aurora-mareviv).
The repository is licensed under GPL-3. Read the full license in the file
`LICENSE`.
