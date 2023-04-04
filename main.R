# Instalacja i wczytanie pakietów

if (!require("shiny")) install.packages("shiny")
if (!require("DT")) install.packages("DT")
if (!require("plotly")) install.packages("plotly")
if (!require("shinyWidgets")) install.packages("shinyWidgets")
if (!require("shiny.fluent")) install.packages("shiny.fluent")
if (!require("tidyverse")) install.packages("tidyverse")

library(tidyverse)
library(shiny.fluent)
library(shiny)
library(DT)
library(plotly)
library(shinyWidgets)

# Definicja UI
ui <- fluidPage(
  
  tags$style(
    type = "text/css", "body { 
    background-color: #071E22;
    font-family: font-family: 'Barlow', Sans-Serif;
    color: #F4C095;
    }"
  ),
  
  tags$head(
    tags$link(rel = "stlesheet", type = "text/css", href = "site.css"),
    
    HTML('<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Barlow:wght@200;300;500&display=swap" rel="stylesheet">')
    
  ),
  
  div(class = "container",
      div(class = "row",
          div(class = "bg-light my-5 py-3",
              
              theme = bslib::bs_theme(version = 5, primary = "#071E22"),
              
              titlePanel(
                h1("KREATOR BUDOWY KOMPUTERA",
                   style = "font-family: 'Barlow', sans-serif; font-weight: 350; text-align: center; padding: 20px;"),
                
                div(tags$img(src = "logo.png", height = "200px", width = "300px", deleteFile = FALSE), style = "text-align: center")
              ),
              sidebarLayout( 
                sidebarPanel( style = "background-color: #1D7874;",
                              selectInput("category", "Wybierz kategorię podzespołów:",
                                          choices = c("Obudowa", "Procesor", "Karta graficzna", "Płyta główna", "Pamięć RAM", "Zasilacz", "Dysk SSD", "Dysk twardy", "Chłodzenie"),
                                          selected = "Obudowa"),
                              hr(),
                              conditionalPanel(
                                condition = "input.category === 'Obudowa'",
                                selectInput("obudowa", "Wybierz obudowę:",
                                            choices = c("Krux Leda", "Silver Monkey X Crate", "Corsair 4000D Airflow", "Fractal Design North Chalk White TG Clear"),
                                            selected = "Krux Leda")
                              ),
                              conditionalPanel(
                                condition = "input.category === 'Procesor'",
                                selectInput("processor", "Wybierz procesor:",
                                            choices = c("Intel i7", "Intel i9", "AMD Ryzen 7", "AMD Ryzen 9"),
                                            selected = "Intel i7")
                              ),
                              conditionalPanel(
                                condition = "input.category === 'Karta graficzna'",
                                selectInput("gpu", "Wybierz kartę graficzną:",
                                            choices = c("Nvidia RTX 3060", "Nvidia RTX 3070", "AMD Radeon RX 6700 XT"),
                                            selected = "Nvidia RTX 3060")
                              ),
                              conditionalPanel(
                                condition = "input.category === 'Płyta główna'",
                                selectInput("motherboard", "Wybierz płytę główną:",
                                            choices = c("ASUS Prime B450M-A", "Gigabyte B550 AORUS ELITE", "MSI MPG B550 GAMING CARBON WIFI"),
                                            selected = "ASUS Prime B450M-A")
                              ),
                              conditionalPanel(
                                condition = "input.category === 'Pamięć RAM'",
                                selectInput("RAM", "Wybierz pamięć RAM:",
                                            choices = c("Kingston FURY 16GB (2x8GB) 3200MHz CL16 Beast Black", "PNY 32GB (2x16GB) 3200MHz CL16 XLR8 RGB", "GOODRAM 16GB (2x8GB) 3600MHz CL18 IRDM RGB", "Kingston FURY 64GB (2x32GB) 5600MHz CL40 Beast Black"),
                                            selected = "Kingston FURY 16GB (2x8GB) 3200MHz CL16 Beast Black")
                              ),
                              conditionalPanel(
                                condition = "input.category === 'Zasilacz'",
                                selectInput("zasilacz", "Wybierz zasilacz:",
                                            choices = c("SilentiumPC Elementum E2 550W 80 Plus", "be quiet! Pure Power 11 FM 650W 80 Plus Gold", "ENDORFY Supremo FM5 850W 80 Plus Gold"),
                                            selected = "SilentiumPC Elementum E2 550W 80 Plus")
                              ),
                              conditionalPanel(
                                condition = "input.category === 'Dysk SSD'",
                                selectInput("SSD", "Wybierz dysk SSD:",
                                            choices = c("Lexar 1TB M.2 PCIe Gen4 NVMe NM710", "Samsung 2TB M.2 PCIe Gen4 NVMe 980 PRO", "GOODRAM 256GB 2,5' SATA SSD CX400"),
                                            selected = "Lexar 1TB M.2 PCIe Gen4 NVMe NM710")
                              ),
                              conditionalPanel(
                                condition = "input.category === 'Dysk HDD'",
                                selectInput("HDD", "Wybierz dysk HDD:",
                                            choices = c("Seagate BARRACUDA 2TB 7200obr. 256MB", "Toshiba P300 1TB 7200obr. 64MB OEM", "Seagate IRONWOLF 4TB 5400obr. 256MB"),
                                            selected = "Seagate BARRACUDA 2TB 7200obr. 256MB")
                              ),
                              conditionalPanel(
                                condition = "input.category === 'Chłodzenie'",
                                selectInput("chłodzenie", "Wybierz chłodzenie:",
                                            choices = c("be quiet! Pure Loop 2 FX 360 3x120mm", "NZXT Kraken x53 2x120mm", "Corsair iCUE H150i ELITE 3x120mm", "SilentiumPC Fortis 5"),
                                            selected = "be quiet! Pure Loop 2 FX 360 3x120mm")
                              ),
                              
                              numericInput("quantity", "Ilość:", value = 1, min = 1, max = 10),
                              actionButton("add_button", "Dodaj do koszyka", style = "color: #EE2E31; text-black"),
                              actionButton("clear_button", "Wyczyść koszyk", style = "color: #EE2E31; text-black"),
                              hr(),
                              h4("Cena całkowita:"),
                              verbatimTextOutput("cart_text"),
                              tags$img(src = 'tlo.png', heigh = 900, width = 900)
                ),
                mainPanel(
                  DTOutput("cart_table"),
                  downloadButton("download_data", "Pobierz koszyk", style="position: relative; left: calc(45%);"),
                  
                )
              )
          )
      )
  )
)
# Definicja server
server <- function(input, output, session) {
  # Inicjalizacja danych koszyka
  cart <- reactiveValues(
    products = data.frame(
      Category = character(),
      Product = character(),
      Price = numeric(),
      Quantity = integer(),
      stringsAsFactors = FALSE
    ),
    total_price = 0
  )
  
  # Funkcja dodająca produkt do koszyka
  add_to_cart <- function(category, product, price, quantity) {
    # Sprawdzenie, czy dany produkt jest już w koszyku
    idx <- which(cart$products$Product == product)
    
    if (length(idx) > 0) {
      # Jeśli produkt jest już w koszyku, dodaj do jego ilości
      cart$products$Quantity[idx] <- cart$products$Quantity[idx] + quantity
    } else {
      # W przeciwnym razie dodaj nowy produkt do koszyka
      new_product <- data.frame(
        Category = category,
        Product = product,
        Price = price,
        Quantity = quantity,
        stringsAsFactors = FALSE
      )
      cart$products <- rbind(cart$products, new_product)
    }
    # Zaktualizowanie ceny całkowitej
    cart$total_price <- cart$total_price + (price * quantity)
  }
  
  #Funkcja czyszcząca koszyk
  clear_cart <- function() {
    cart$products <- data.frame(
      Category = character(),
      Product = character(),
      Price = numeric(),
      Quantity = integer(),
      stringsAsFactors = FALSE
    )
    cart$total_price <- 0
  }
  
  #Obserwator dodawania produktu do koszyka
  observeEvent(input$add_button, {
    category <- input$category
    quantity <- input$quantity
    
    if (category == "Obudowa") {
      obudowa <- input$obudowa
      if (obudowa == "Krux Leda") {
        price <- 350
      } else if (obudowa == "Silver Monkey X Crate") {
        price <- 499
      } else if (obudowa == "Corsair 4000D Airflow") {
        price <- 479
      } else {
        price <- 669
      }
      add_to_cart(category, obudowa, price, quantity)
    } 
    
    else if (category == "Procesor") {
      processor <- input$processor
      if (processor == "Intel i7") {
        price <- 1500
      } else if (processor == "Intel i9") {
        price <- 2500
      } else if (processor == "AMD Ryzen 7") {
        price <- 1800
      } else {
        price <- 2800
      }
      add_to_cart(category, processor, price, quantity)
    } 
    
    else if(category == "Karta graficzna") {
      gpu <- input$gpu
      if (gpu == "Nvidia RTX 3060") {
        price <- 2000
      } else if (gpu == "Nvidia RTX 3070") {
        price <- 3000
      } else {
        price <- 2500
      }
      add_to_cart(category, gpu, price, quantity)
    }
    
    else if(category == "Płyta główna") {
      motherboard <- input$motherboard
      if (motherboard == "ASUS Prime B450M-A") {
        price <- 600
      } else if (motherboard == "Gigabyte B550 AORUS ELITE") {
        price <- 900
      } else {
        price <- 1100
      }
      add_to_cart(category, motherboard, price, quantity)
    } 
    
    else if(category == "Pamięć RAM") {
      RAM <- input$RAM
      if (RAM == "Kingston FURY 16GB (2x8GB) 3200MHz CL16 Beast Black") {
        price <- 229
      } else if (RAM == "PNY 32GB (2x16GB) 3200MHz CL16 XLR8 RGB") {
        price <- 399
      } else if (RAM == "GOODRAM 16GB (2x8GB) 3600MHz CL18 IRDM RGB") {
        price <- 249
      } else {
        price <- 1259
      }
      add_to_cart(category, RAM, price, quantity)
    }
    
  })
  
  # funkcja zapisująca dane do pliku tekstowego
  write_data_to_file <- function(data, file_name) {
    write.table(data, file = file_name, row.names = FALSE, sep = "\t")
  }
  
  #Obserwator czyszczenia koszyka
  observeEvent(input$clear_button, {
    clear_cart()
  })
  
  #Wyjście tekstowe z ceną całkowitą
  output$cart_text <- renderPrint({
    paste0(cart$total_price, "zł", "\n\n")
    cat(paste0(cart$total_price, "zł", "\n\n"))
  })
  
  #Tabela z zawartością koszyka
  output$cart_table <- renderDT({
    datatable(
      cart$products,
      options = list(paging = FALSE),
      rownames = FALSE,
      colnames = c("Kategoria", "Produkt", "Cena", "Ilość")
    )
  })
  
  # pobieranie tabeli jako pliku tekstowego
  output$download_data <- downloadHandler(
    filename = function() {
      paste("dane", ".txt", sep = "")
    },
    content = function(file) {
      write_data_to_file(output$cart_table, file)
    }
  )
}

#Uruchomienie aplikacji
shinyApp(ui, server)
