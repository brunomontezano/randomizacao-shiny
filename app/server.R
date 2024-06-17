shinyServer(function(input, output) {
  gerar_tabela_randomizacao <- function(seed, n_pacientes, n_bracos) {
    set.seed(seed)

    n_bracos <- as.numeric(n_bracos)

    tratamentos <- paste("Grupo", seq_len(n_bracos))

    if (n_bracos > n_pacientes) {
      stop(
        "O número de tratamentos não pode ser maior que o número de pacientes."
      )
    }

    pacientes_por_tratamento <- rep(floor(n_pacientes / n_bracos), n_bracos)
    pacientes_restantes <- n_pacientes - sum(pacientes_por_tratamento)
    if (pacientes_restantes > 0) {
      pacientes_por_tratamento[1:pacientes_restantes] <-
        pacientes_por_tratamento[1:pacientes_restantes] + 1
    }

    id <- paste("P", seq_len(n_pacientes), sep = "")
    pacientes <- paste("Paciente", seq_len(n_pacientes))

    tratamento <- rep(tratamentos, pacientes_por_tratamento)

    tratamento <- sample(tratamento)

    data.frame(id = id, paciente = pacientes, tratamento = tratamento)
  }

  gerar_tabela_chave <- function(seed, n_bracos) {
    set.seed(seed)

    n_bracos <- as.numeric(n_bracos)

    if (n_bracos == 2) {
      tratamento <- c(input$tt_1, input$tt_2)
    } else if (n_bracos == 3) {
      tratamento <- c(input$tt_1, input$tt_2, input$tt_3)
    } else if (n_bracos == 4) {
      tratamento <- c(input$tt_1, input$tt_2, input$tt_3, input$tt_4)
    } else if (n_bracos == 5) {
      tratamento <- c(
        input$tt_1, input$tt_2, input$tt_3, input$tt_4,
        input$tt_5
      )
    } else if (n_bracos == 6) {
      tratamento <- c(
        input$tt_1, input$tt_2, input$tt_3,
        input$tt_4, input$tt_5, input$tt_6
      )
    }

    grupo <- paste("Grupo", seq_len(n_bracos))

    # A randomização acontece nas linhas abaixo
    return(
      data.frame(tratamento, grupo) |>
        transform(grupo = sample(grupo))
    )
  }

  dados_randomizacao <- reactive(gerar_tabela_randomizacao(
    input$seed,
    input$n_pacientes,
    input$bracos
  ))

  dados_chave <- reactive(gerar_tabela_chave(
    input$seed,
    input$bracos
  ))

  output$tabela_randomizacao <- DT::renderDT({
    DT::datatable(
      gerar_tabela_randomizacao(
        input$seed,
        input$n_pacientes,
        input$bracos
      ),
      rownames = FALSE,
      caption = "Tabela de randomização dos pacientes.",
      options = list(
        language = list(
          url = paste0(
            "//cdn.datatables.net/plug-ins/1.10.11/i18n/",
            "Portuguese-Brasil.json"
          )
        ),
        pageLength = 10
      )
    )
  })

  output$tabela_chave <- DT::renderDT({
    DT::datatable(
      gerar_tabela_chave(
        input$seed,
        input$bracos
      ),
      rownames = FALSE,
      caption = "Tabela com chave para remoção do cegamento.",
      options = list(
        dom = "t",
        language = list(
          url = paste0(
            "//cdn.datatables.net/plug-ins/1.10.11/i18n/",
            "Portuguese-Brasil.json"
          )
        ),
        pageLength = 10
      )
    )
  })

  output$info_pacientes_bracos <- renderText({
    paste(
      "Esta é uma tabela de randomização para um estudo envolvendo",
      input$n_pacientes,
      "pacientes e",
      input$bracos,
      "braços de tratamento."
    )
  })

  output$info_chave <- renderText({
    paste0(
      "A tabela de chave pode ser usada para revelar os tratamentos quando",
      "a alocação dos grupos deve ser não cego."
    )
  })

  output$baixar_chave <- downloadHandler(
    filename = function() {
      paste(
        stringr::str_to_lower(stringr::str_replace_all(input$titulo, " ", "_")),
        input$seed,
        "chave.csv",
        sep = "_"
      )
    },
    content = function(file) {
      write.csv(dados_chave(), file, na = "", row.names = FALSE)
    }
  )

  output$baixar_randomizacao <- downloadHandler(
    filename = function() {
      paste(
        stringr::str_to_lower(stringr::str_replace_all(input$titulo, " ", "_")),
        input$seed,
        "randomizacao.csv",
        sep = "_"
      )
    },
    content = function(file) {
      write.csv(dados_randomizacao(), file, na = "", row.names = FALSE)
    }
  )
})
