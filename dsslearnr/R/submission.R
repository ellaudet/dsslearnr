#' @title Tutorial submission functions
#'
#' @description
#' Based on Professor Matt Blackwell's and Professor Colin Rundel's work
#' https://github.com/mattblackwell/qsslearnr and
#' https://github.com/rundel/learnrhash
#'
#' From their notes:
#' When including these functions in a learnr Rmd document it is necessary that the
#' server function, `submission_server()`, be included in an R chunk where
#' `context="server"`. Conversely, any of the ui functions, `*_ui()`, must *not*
#' be included in an R chunk with a `context`.
#'
#' @rdname submission_functions
#' @export
submission_server <- function(input, output) {
  p <- parent.frame()
  check_server_context(p)

  # Evaluate in parent frame to get input, output, and session
  local({
    build_report <- function(file) {
      # Copy the report file to a temporary directory before processing it, in
      # case we don't have write permissions to the current working dir (which
      # can happen when deployed).
      tempReport <- file.path(tempdir(), "tutorial-report.Rmd")
      tut_rep_path <- file.path(path.package("dsslearnr"),
                                "tutorials",
                                "tutorial-report.Rmd")
      file.copy(tut_rep_path, tempReport, overwrite = TRUE)


      # Set up parameters to pass to Rmd document
      objs <- learnr:::get_all_state_objects(session)
      skips <- learnr:::section_skipped_progress_from_state_objects(objs)
      subs <- learnr:::submissions_from_state_objects(objs)
      ##browser()
      out <- tibble::tibble(
        id = purrr::map_chr(subs, "id"),
        answers = purrr::map_chr(subs, list("data", "answer"),
                                 .default = NA),
        checked = purrr::map_lgl(subs, list("data", "checked"),
                                 .default = NA),
        correct = purrr::map_lgl(subs, list("data", "feedback", "correct"),
                                 .default = NA)
      )
      out$attempted <- !is.na(out$answers) | out$checked
      params <- list(reporttitle = tut_reptitle,
                     output = out,
                     student_name = input$name,
                     skipped = length(skips))

      ext <- tools::file_ext(file)
      out_format <- switch(ext, pdf = "pdf_document", html = "html_document")

      # Knit the document, passing in the `params` list, and eval it in a
      # child of the global environment (this isolates the code in the document
      # from the code in this app).
      rmarkdown::render(
        tempReport,
        output_format = out_format,
        output_file = file,
        params = params,
        envir = new.env(parent = globalenv())
      )
    }
    output$download_pdf <- downloadHandler(
      filename = "report.pdf",
      content = build_report
    )

    output$download_html <- downloadHandler(
      filename = "report.html",
      content = build_report
    )
  }, envir = p)
}

check_server_context <- function(.envir) {
  if (!is_server_context(.envir)) {
    calling_func <- deparse(sys.calls()[[sys.nframe() - 1]])

    err <- paste0(
      "Function `", calling_func, "`",
      " must be called from an Rmd chunk where `context = \"server\"`"
    )

    stop(err, call. = FALSE)
  }
}

is_server_context <- function(.envir) {
  # We are in the server context if there are the follow:
  # * input - input reactive values
  # * output - shiny output
  # * session - shiny session
  #
  # Check context by examining the class of each of these.
  # If any is missing then it will be a NULL which will fail.

  inherits(.envir$input,   "reactivevalues") &
    inherits(.envir$output,  "shinyoutput")    &
    inherits(.envir$session, "ShinySession")
}

#' @rdname submission_functions
#' @export
submission_ui <- shiny::div(
  "Once you have completed the practice exercises, you can generate a completion report by:",
  shiny::tags$br(),
  shiny::tags$ol(
    shiny::tags$li("Entering your name in the text box below"),
    shiny::tags$li("Clicking the Download PDF button")),
  shiny::textInput("name", "Your Name"),
  shiny::downloadButton(outputId = "download_pdf", label = "Download PDF")
)

utils::globalVariables(c("input", "session", "download_report"))
