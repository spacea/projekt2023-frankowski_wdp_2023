# Instalacja i wczytanie pakietów

if (!require("shiny")) install.packages("shiny")
if (!require("DT")) install.packages("DT")
if (!require("plotly")) install.packages("plotly")
if (!require("shinyWidgets")) install.packages("shinyWidgets")
if (!require("shiny.fluent")) install.packages("shiny.fluent")
if (!require("tidyverse")) install.packages("tidyverse")
if (!require("shinythemes")) install.packages("shinythemes")
if (!require("shinyjs")) install.packages("shinyjs")
if (!require("leaflet")) install.packages("leaflet")

library(tidyverse)
library(shiny.fluent)
library(shiny)
library(DT)
library(plotly)
library(shinyWidgets)
library(shinythemes)
library(shinyjs)
library(leaflet)

sklepy_xkom <- read.csv("sklepy_xkom.csv", stringsAsFactors = FALSE)

# Definicja UI
ui <- fluidPage( theme = shinytheme("superhero"),
                 
                 #background: linear-gradient(to bottom, #61718A, #343c4a);
                 
                 tags$style(
                   type = "text/css", "body { 
    
    background: linear-gradient(180deg, #012b35 0%, #00172C 100%), linear-gradient(36deg, #FAFF00 0%, #800000 73%), linear-gradient(110deg, #001D38 30%, #FBFF49 100%), linear-gradient(140deg, #61FF00 0%, #040EFF 72%), linear-gradient(127deg, #FFB800 0%, #02004D 100%), linear-gradient(140deg, #6DCA4C 28%, #CD0000 100%), radial-gradient(100% 100% at 70% 0%, #7A3B00 0%, #49B8A4 100%);
    background-blend-mode: overlay, color-dodge, difference, difference, difference, color-dodge, normal;
    
    color: rgba(0,0,0,.8);
    font-family: Poppins,sans-serif;
    font-weight: 400;
    word-wrap: break-word;
    font-kerning: normal;
    -ms-font-feature-settings: 'kern','liga','clig','calt';
    -webkit-font-feature-settings: 'kern','liga','clig','calt';
    font-feature-settings: 'kern','liga','clig','calt';
    }"
                 ),
                 
                 tags$head(
                   tags$link(rel = "stylesheet", type = "text/css", href = "site.css"),
                   tags$style(
                     "#cart_table {
    color: black;
    margin: 10px;
    padding: 20px;
    background: #fff;
    box-shadow: 0 16px 80px rgb(17 0 102 / 16%);
    border-radius: 40px;
    position: relative; left: calc(3%);
                     }
                     
                     #leaflet{margin: auto;}
      "
                   ),
                   
                   HTML('<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300&display=swap" rel="stylesheet">')
                   
                 ),
                 
                 div(class = "container",
                     div(class = "row",
                         div(class = "bg-light my-5 py-3",
                             
                             theme = bslib::bs_theme(version = 5, primary = "#071E22"),
                             
                             titlePanel(
                               h1("PATRYK FRANKOWSKI", tags$img(src = "logo.png", heigh = 300, width = 300), "MIKOŁAJ KONIECZNY",
                                  style = "font-family: 'Poppins', sans-serif; font-weight: 400; text-align: center; padding: 20px; color: white")
                             ),
                             
                             tabsetPanel(
                                        sidebarLayout( 
                                          sidebarPanel( style = "background: #fff;
    box-shadow: 0 16px 80px rgb(17 0 102 / 16%);
    border-radius: 40px;
    z-index: 1; padding: 10px;",
                                                        selectInput("category", "Wybierz kategorię podzespołów:",
                                                                    
                                                                    choices = c("Obudowa", "Płyta główna", "Procesor", "Karta graficzna",  "Pamięć RAM", "Zasilacz", "Dysk SSD", "Dysk twardy", "Chłodzenie"),
                                                                    selected = "Obudowa"),
                                                        
                                                        conditionalPanel(
                                                          condition = "input.category === 'Obudowa'",
                                                          selectInput("obudowa", "Wybierz obudowę:",
                                                                      choices = c("Krux Leda", "Silver Monkey X Crate", "Corsair 4000D Airflow", "Fractal Design North Chalk White TG Clear"),
                                                                      selected = "Krux Leda")
                                                        ),
                                                        
                                                        conditionalPanel(
                                                          condition = "input.category === 'Płyta główna'",
                                                          selectInput("motherboard", "Wybierz płytę główną:",
                                                                      choices = c("ASUS Prime B450M-A", "Gigabyte B550 AORUS ELITE", "MSI MPG B550 GAMING CARBON WIFI"),
                                                                      selected = "ASUS Prime B450M-A")
                                                        ),
                                                        conditionalPanel(
                                                          condition = "input.category === 'Procesor'",
                                                          selectInput("processor", "Wybierz procesor:",
                                                                      choices = c("Intel Core i7-9700K", "Intel Core i9-13900K", "AMD Ryzen 7 7700X", "AMD Ryzen 9 7900X"),
                                                                      selected = "Intel Core i7-9700K")
                                                        ),
                                                        conditionalPanel(
                                                          condition = "input.category === 'Karta graficzna'",
                                                          selectInput("gpu", "Wybierz kartę graficzną:",
                                                                      choices = c("Gigabyte GeForce RTX 3060 EAGLE OC", "Zotac GeForce RTX 3070 Gaming Twin Edge 8GB GDDR6", "XFX Radeon RX 6700 CORE Gaming SWFT 309 10GB GDDR6"),
                                                                      selected = "Gigabyte GeForce RTX 3060 EAGLE OC")
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
                                                        
                                                        numericInput("quantity", "Ilość:", value = 1, min = 1, max = 10, ),
                                                        hr(),
                                                        actionButton("add_button", "Dodaj do koszyka", style = "
    background: linear-gradient(180deg, #012b35 0%, #00172C 100%), linear-gradient(36deg, #FAFF00 0%, #800000 73%), linear-gradient(110deg, #001D38 30%, #FBFF49 100%), linear-gradient(140deg, #61FF00 0%, #040EFF 72%), linear-gradient(127deg, #FFB800 0%, #02004D 100%), linear-gradient(140deg, #6DCA4C 28%, #CD0000 100%), radial-gradient(100% 100% at 70% 0%, #7A3B00 0%, #49B8A4 100%);
background-blend-mode: overlay, color-dodge, difference, difference, difference, color-dodge, normal;

    color: white;
    font-weight: 400;
    margin: 10px;
    padding: 20px;
    background-image: url('guzik.png');
    box-shadow: 0 16px 80px rgb(17 0 102 / 16%);
    border-radius: 40px;
    
    "),
                                                        actionButton("clear_button", "Wyczyść koszyk", style = "
    color: white;
    margin: 10px;
    background-image: url('guzik.png');
    padding: 20px;
    box-shadow: 0 16px 80px rgb(17 0 102 / 16%);
    border-radius: 40px;
    
    "),
                                                        hr(),
                                                        h4("Cena całkowita", style = "text-align: center;"),
                                                        textOutput("cart_text"),style = "text-align: center;",
                                                        hr(),
                                                        h4("Wizualizacja komputera"),
                                                        
                                                        h4("Obudowa", style = "text-align: center; background: #fff;box-shadow: 0 16px 80px rgb(17 0 102 / 16%);border-radius: 40px;z-index: 1; padding: 10px;", actionButton("hide_obudowa", "Usuń", style = "background: #fff;box-shadow: 0 16px 80px rgb(17 0 102 / 16%);border-radius: 40px;z-index: 1; padding: 10px; color: black; position: relative; left: calc(25%); background-image: url('guzik.png'); color: white;")),
                                                        h4("Płyta główna", style = "text-align: center; background: #fff;box-shadow: 0 16px 80px rgb(17 0 102 / 16%);border-radius: 40px;z-index: 1; padding: 10px;", actionButton("hide_plytaglowna", "Usuń", style = "background: #fff;box-shadow: 0 16px 80px rgb(17 0 102 / 16%);border-radius: 40px;z-index: 1; padding: 10px; color: black; position: relative; left: calc(21%); background-image: url('guzik.png'); color: white;")),
                                                        h4("Procesor", style = "text-align: center; background: #fff;box-shadow: 0 16px 80px rgb(17 0 102 / 16%);border-radius: 40px;z-index: 1; padding: 10px;", actionButton("hide_cpu", "Usuń", style = "background: #fff;box-shadow: 0 16px 80px rgb(17 0 102 / 16%);border-radius: 40px;z-index: 1; padding: 10px; color: black; position: relative; left: calc(27%); background-image: url('guzik.png'); color: white;")),
                                                        h4("Karta graficzna", style = "text-align: center; background: #fff;box-shadow: 0 16px 80px rgb(17 0 102 / 16%);border-radius: 40px;z-index: 1; padding: 10px;", actionButton("hide_gpu", "Usuń", style = "background: #fff;box-shadow: 0 16px 80px rgb(17 0 102 / 16%);border-radius: 40px;z-index: 1; padding: 10px; color: black; position: relative; left: calc(18%); background-image: url('guzik.png'); color: white;")),
                                                        h4("Pamięć RAM", style = "text-align: center; background: #fff;box-shadow: 0 16px 80px rgb(17 0 102 / 16%);border-radius: 40px;z-index: 1; padding: 10px;", actionButton("hide_ram", "Usuń", style = "background: #fff;box-shadow: 0 16px 80px rgb(17 0 102 / 16%);border-radius: 40px;z-index: 1; padding: 10px; color: black; position: relative; left: calc(22%); background-image: url('guzik.png'); color: white;")),
                                                        h4("Chłodzenie", style = "text-align: center; background: #fff;box-shadow: 0 16px 80px rgb(17 0 102 / 16%);border-radius: 40px;z-index: 1; padding: 10px;", actionButton("hide_chlodzenie", "Usuń", style = "background: #fff;box-shadow: 0 16px 80px rgb(17 0 102 / 16%);border-radius: 40px;z-index: 1; padding: 10px; color: black; position: relative; left: calc(23%); background-image: url('guzik.png'); color: white;")),
                                                        actionButton("hide_all", "Usuń wszystko", style = "color: black; background: #fff;box-shadow: 0 16px 80px rgb(17 0 102 / 16%);border-radius: 40px;z-index: 1; padding: 10px;"),
                                                        hr(),
                                                        
                                                        
                                                        downloadButton("download_data", "Pobierz koszyk", style = "color: black; background: #fff;box-shadow: 0 16px 80px rgb(17 0 102 / 16%);border-radius: 40px;z-index: 1; padding: 10px;"),
                                                        
                                          ),
                                          mainPanel(
                                            DTOutput("cart_table"),
                                            sidebarLayout(
                                              sidebarPanel( style = "
    width: 840px; height: 900px;
    ext-align: center;
    background: #fff;
    box-shadow: 0 16px 80px rgb(17 0 102 / 16%);
    border-radius: 40px;
    z-index: 1;",
                                               h4("Wizualizacja komputera", style = "position: relative; left: calc(38%);"),
                
                                                tags$div(
                                                  style="
    background: #fff;
    box-shadow: 0 16px 80px rgb(17 0 102 / 16%);
    border-radius: 40px;
    z-index: 1; 
    padding: 10px; 
    width:800px; height: 800px;",
                                                  fluidRow( style = "position: relative; right: calc(8%);",
                                                            
                                                            #Obudowy
                                                    column(1, imageOutput("KruxLeda"), style = "position: absolute; top: 0; left: 0; z-index: 1;"),
                                                    column(1, imageOutput("silvermonkey"), style = "position: absolute; top: 0; left: 0; z-index: 2;"),
                                                    column(1, imageOutput("corsair_biala"), style = "position: absolute; top: 0; left: 0; z-index: 2;"),
                                                    column(1, imageOutput("fractal"), style = "position: absolute; top: 0; left: 0; z-index: 2;"),
                                                    
                                                            #Płyty główne
                                                    column(1, imageOutput("AsusPrime"), style = "position: absolute; top: 0; left: 0; z-index: 3;"),
                                                    
                                                            #Procesory
                                                    column(1, imageOutput("ryzen"), style = "position: absolute; top: 0; left: 0; z-index: 4;"),
                                                    column(1, imageOutput("intel"), style = "position: absolute; top: 0; left: 0; z-index: 5;"),
                                                    
                                                            #Kart graficzne
                                                    column(1, imageOutput("rtx3060"), style = "position: absolute; top: 0; left: 0; z-index: 6;"),
                                                    
                                                            #RAM
                                                    column(1, imageOutput("goodram"), style = "position: absolute; top: 0; left: 0; z-index: 7;"),
                                                    
                                                            #Chłodzenie
                                                    column(1, imageOutput("bequiet_chlo"), style = "position: absolute; top: 0; left: 0; z-index: 8;"),
                                                    
                                                  ),
                                                )
                                              ),
                                              mainPanel(
                                                #pusto
                                              )
                                            )
                                         )
                                   )
                               )
                             
                         )
                     )
                 ),
                 tabPanel("Mapa punktów x-kom",
                          h2("Lokalizacje sklepów X-kom w Polsce"),
                          leafletOutput("map", width = "1590px", height = "600px"),
                          style = " 
    text-align: center;
    color: black;
    margin: 10px;
    padding: 20px;
    background: #fff;
    box-shadow: 0 16px 80px rgb(17 0 102 / 16%);
    border-radius: 40px;",
                          
                 )
)
# Definicja servera
server <- function(input, output, session) {
  
  observeEvent(input$hide_all, {
    output$KruxLeda <- NULL
    output$silvermonkey <- NULL
    output$corsair_biala <- NULL
    output$fractal <- NULL
    output$ryzen <- NULL
    output$intel <- NULL
    output$rtx3060 <- NULL
    output$AsusPrime <- NULL
    output$goodram <- NULL
    output$bequiet_chlo <- NULL
  })
  
  # Funkcja usuwająca obraz po kliknięciu przycisku "Usuń"
  observeEvent(input$hide_obudowa, {
    
    #obudowy
    output$KruxLeda <- NULL
    output$silvermonkey <- NULL
    output$corsair_biala <- NULL
    output$fractal <- NULL
    
  })
    
  observeEvent(input$hide_cpu, {
    
    #procesory
    output$ryzen <- NULL
    output$intel <- NULL
    
  })
  
  observeEvent(input$hide_gpu, {
    
    #karty graficzne
    output$rtx3060 <- NULL
    
  })
  
  observeEvent(input$hide_plytaglowna, {
    
    #płyty główne
    output$AsusPrime <- NULL
    
  })
  
  observeEvent(input$hide_ram, {
    
    #ram
    output$goodram <- NULL
    
  })
    
  observeEvent(input$hide_chlodzenie, {
    
    #Chodzenie
    output$bequiet_chlo <- NULL
    
  })
  
  # Utworzenie mapy
  output$map <- renderLeaflet({
    leaflet(sklepy_xkom) %>%
      addTiles() %>%
      setView(lat = 52.2297, lng = 21.0122, zoom = 6) # Ustawienie punktu startowego mapy
  })
  
  # Dodanie znaczników na mapie dla każdego sklepu X-kom
  observe({
    leafletProxy("map", data = sklepy_xkom) %>%
      clearMarkers() %>%
      addMarkers(
        lng = ~longitude,
        lat = ~latitude,
        popup = ~paste("<b>", nazwa, "</b><br/>", adres, "<br/>", kod_pocztowy, " ", miasto, sep = ""),
        label = ~nazwa
      )
  })
  
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
  
  #Dodawanie produktów do koszyka
  observeEvent(input$add_button, {
    category <- input$category
    quantity <- input$quantity
    
    
    if (category == "Obudowa") {
      obudowa <- input$obudowa
      if (obudowa == "Krux Leda") {
        price <- 350
        output$KruxLeda <- renderImage({
          file <- "grafiki/Obudowa/KruxLeda.png"
          list(src = file, alt = "Krux Leda")},deleteFile = FALSE)
      } else if (obudowa == "Silver Monkey X Crate") {
        price <- 499
        output$silvermonkey <- renderImage({
          file <- "grafiki/Obudowa/silvermonkey.png"
          list(src = file, alt = "Silver Monkey")},deleteFile = FALSE)
      } else if (obudowa == "Corsair 4000D Airflow") {
        price <- 479
        output$corsair_biala <- renderImage({
          file <- "grafiki/Obudowa/corsair_biala.png"
          list(src = file, alt = "Silver Monkey")},deleteFile = FALSE)
      } else if (obudowa == "Fractal Design North Chalk White TG Clear") {
        price <- 669
        output$fractal <- renderImage({
          file <- "grafiki/Obudowa/fractal.png"
          list(src = file, alt = "Fractal")},deleteFile = FALSE)
      }
      add_to_cart(category, obudowa, price, quantity)
    }
    else if(category == "Płyta główna") {
      motherboard <- input$motherboard
      if (motherboard == "ASUS Prime B450M-A") {
        price <- 600
        output$AsusPrime <- renderImage({
          file <- "grafiki/PłytaGlowna/plytaglowna_przyklad.png"
          list(src = file, alt = "przyklad")},deleteFile = FALSE)
      } else if (motherboard == "Gigabyte B550 AORUS ELITE") {
        price <- 900
      } else if (motherboard == "MSI MPG B550 GAMING CARBON WIFI") {
        price <- 1100
      }
      add_to_cart(category, motherboard, price, quantity)
    } 
    
    else if (category == "Procesor") {
      processor <- input$processor
      if (processor == "Intel Core i7-9700K") {
        price <- 1500
        output$intel <- renderImage({
          file <- "grafiki/Procesor/intel.png"
          list(src = file, alt = "Intel")},deleteFile = FALSE)
      } else if (processor == "Intel Core i9-13900K") {
        price <- 2500
        output$intel <- renderImage({
          file <- "grafiki/Procesor/intel.png"
          list(src = file, alt = "Intel")},deleteFile = FALSE)
      } else if (processor == "AMD Ryzen 7 7700X") {
        price <- 1900
        output$ryzen <- renderImage({
          file <- "grafiki/Procesor/procesor_przyklad.png"
          list(src = file, alt = "Ryzen")},deleteFile = FALSE)
      } else if (processor == "AMD Ryzen 9 7900X") {
        price <- 2500
        output$ryzen <- renderImage({
          file <- "grafiki/Procesor/procesor_przyklad.png"
          list(src = file, alt = "Ryzen")},deleteFile = FALSE)
      }
      add_to_cart(category, processor, price, quantity)
    } 
    
    else if(category == "Karta graficzna") {
      gpu <- input$gpu
      if (gpu == "Gigabyte GeForce RTX 3060 EAGLE OC") {
        price <- 1800
        output$rtx3060 <- renderImage({
          file <- "grafiki/KartaGraficzna/RTX-3060.png"
          list(src = file, alt = "przyklad")},deleteFile = FALSE)
      } else if (gpu == "Zotac GeForce RTX 3070 Gaming Twin Edge 8GB GDDR6") {
        price <- 2500
      } else if (gpu == "XFX Radeon RX 6700 CORE Gaming SWFT 309 10GB GDDR6") {
        price <- 1900
      }
      add_to_cart(category, gpu, price, quantity)
    }
    
    
    
    else if(category == "Pamięć RAM") {
      RAM <- input$RAM
      if (RAM == "Kingston FURY 16GB (2x8GB) 3200MHz CL16 Beast Black") {
        price <- 229
      } else if (RAM == "PNY 32GB (2x16GB) 3200MHz CL16 XLR8 RGB") {
        price <- 399
      } else if (RAM == "GOODRAM 16GB (2x8GB) 3600MHz CL18 IRDM RGB") {
        price <- 249
        output$goodram <- renderImage({
          file <- "grafiki/RAM/ram_przyklad.png"
          list(src = file, alt = "RAM")},deleteFile = FALSE)
      } else if (RAM == "Kingston FURY 64GB (2x32GB) 5600MHz CL40 Beast Black") {
        price <- 1100
      }
      add_to_cart(category, RAM, price, quantity)
    }
    
    else if(category == "Zasilacz") {
      zasilacz <- input$zasilacz
      if (zasilacz == "SilentiumPC Elementum E2 550W 80 Plus") {
        price <- 199
      } else if (zasilacz == "be quiet! Pure Power 11 FM 650W 80 Plus Gold") {
        price <- 500
      } else if (zasilacz == "ENDORFY Supremo FM5 850W 80 Plus Gold") {
        price <- 600
      }
      add_to_cart(category, zasilacz, price, quantity)
    }
    
    else if(category == "Dysk SSD") {
      SSD <- input$SSD
      if (SSD == "Lexar 1TB M.2 PCIe Gen4 NVMe NM710") {
        price <- 299
      } else if (SSD == "Samsung 2TB M.2 PCIe Gen4 NVMe 980 PRO") {
        price <- 859
      } else if (SSD == "GOODRAM 256GB 2,5' SATA SSD CX400") {
        price <- 79
      }
      add_to_cart(category, SSD, price, quantity)
    }
    
    else if(category == "Dysk HDD") {
      HDD <- input$HDD
      if (HDD == "Seagate BARRACUDA 2TB 7200obr. 256MB") {
        price <- 245
      } else if (HDD == "Toshiba P300 1TB 7200obr. 64MB OEM") {
        price <- 189
      } else if (HDD == "Seagate IRONWOLF 4TB 5400obr. 256MB") {
        price <- 469
      }
      add_to_cart(category, HDD, price, quantity)
    }
    
    else if(category == "Chłodzenie") {
      chłodzenie <- input$chłodzenie
      if (chłodzenie == "be quiet! Pure Loop 2 FX 360 3x120mm") {
        price <- 729
        output$bequiet_chlo <- renderImage({
          file <- "grafiki/Chlodzenie/chlodzenie_przyklad.png"
          list(src = file, alt = "Chlodzenie")},deleteFile = FALSE)
      } else if (chłodzenie == "NZXT Kraken x53 2x120mm") {
        price <- 1139
      } else if (chłodzenie == "Corsair iCUE H150i ELITE 3x120mm") {
        price <- 1499
      } else if (chłodzenie == "SilentiumPC Fortis 5") {
        price <- 179
      }
      add_to_cart(category, chłodzenie, price, quantity)
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
      colnames = c("Kategoria", "Produkt", "Cena", "Ilość"),
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
