library(shiny)

linebreaks <- function(n) {
  HTML(strrep(br(), n))
}

fluidPage(
  theme = shinythemes::shinytheme("sandstone"),
  headerPanel("Randomização simples para ensaios clínicos"),
  sidebarPanel(
    textInput(
              "titulo",
              "Escolha o título do estudo:",
              placeholder = "Por exemplo: Ensaio LitiQuet"),
    numericInput(
      "n_pacientes",
      label = "Número total de pacientes:",
      value = 30
    ),
    numericInput(
      "seed",
      label = "Escolha a chave inicial (para fins de replicabilidade):",
      value = 1
    ),
    selectInput("bracos", "Número de braços:",
      choices = c("2", "3", "4", "5", "6")
    ),
    textInput("tt_1", "Nomeie o primeiro braço:",
      placeholder = "Por exemplo: Lítio"
    ),
    textInput("tt_2", "Nomeie o segundo braço",
      placeholder = "Por exemplo: Quetiapina"
    ),
    conditionalPanel(
      condition = "input.bracos >= 3",
      textInput("tt_3", "Nomeie o terceiro braço",
        placeholder = "Por exemplo: Placebo"
      )
    ),
    conditionalPanel(
      condition = "input.bracos >= 4",
      textInput("tt_4", "Nomeie o quarto braço",
        placeholder = "Por exemplo: Valproato"
      )
    ),
    conditionalPanel(
      condition = "input.bracos >= 5",
      textInput("tt_5", "Nomeie o quinto braço",
        placeholder = "Por exemplo: Lamotrigina"
      )
    ),
    conditionalPanel(
      condition = "input.bracos >= 6",
      textInput("tt_6", "Nomeie o sexto braço",
        placeholder = "Por exemplo: Olanzapina"
      )
    ),
    textOutput("info_pacientes_bracos"),
    textOutput("info_chave"),
    linebreaks(1),
    downloadButton("baixar_chave", "Baixar tabela de chave"),
    downloadButton("baixar_randomizacao", "Baixar tabela de randomização"),
    helpText("Escrito em R/Shiny por Bruno Montezano.
             Baseado no projeto de A. Baluja.")
  ),
  mainPanel(
    div(DT::DTOutput("tabela_chave"), style = "font-size:80%"),
    linebreaks(2),
    div(DT::DTOutput("tabela_randomizacao"), style = "font-size:80%")
  )
)
