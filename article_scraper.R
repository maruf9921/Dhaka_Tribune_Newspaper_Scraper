library(RSelenium)
library(rvest)
library(dplyr)
library(stringr)

# ---------- STEP 1: Launch RSelenium and load article URLs ----------

# Start Selenium driver (ensure Java + Firefox installed)
rD <- rsDriver(browser = "firefox", port = 4545L, verbose = FALSE)
remDr <- rD$client

# Open the Bangladesh section
remDr$navigate("https://www.dhakatribune.com/latest-news")
Sys.sleep(5)

# Click "Load More" button 5 times
for (i in 1:20) {
  cat("Clicking Load More: Attempt", i, "\n")
  tryCatch({
    remDr$executeScript("window.scrollTo(0, document.body.scrollHeight);")
    Sys.sleep(2)
    load_more_btn <- remDr$findElement(using = "css selector", ".ajax_load_btn")
    load_more_btn$clickElement()
    Sys.sleep(5)
  }, error = function(e) {
    cat("Error on click", i, ":", e$message, "\n")
  })
}

# Get full page source and parse
page_source <- remDr$getPageSource()[[1]]
page_html <- read_html(page_source)

# Extract article links
all_links <- page_html %>%
  html_nodes(".link_overlay") %>%
  html_attr("href") %>%
  na.omit() %>%
  unique()

article_links <- all_links %>%
  .[str_detect(., "^/")] %>%
  .[!str_detect(., "tag|category|author|latest-news|#")]

full_article_links <- paste0("https://www.dhakatribune.com", article_links)
cat("Total articles found:", length(full_article_links), "\n")

# ---------- STEP 2: Visit each article URL and scrape details ----------

# Function to scrape article details
get_article_details <- function(link) {
  tryCatch({
    page <- read_html(link)
    
    title <- page %>% html_nodes(".mb10") %>% html_text(trim = TRUE)
    news <- page %>% html_nodes("p") %>% html_text(trim = TRUE) %>% paste(collapse = " ")
    published <- page %>% html_node(".published_time") %>% html_text(trim = TRUE)
    updated <- page %>% html_node(".modified_time") %>% html_text(trim = TRUE)
    
    tibble(
      title = title,
      published = published,
      updated = updated,
      link = link,
      content = news
    )
  }, error = function(e) {
    cat("Failed to scrape:", link, "\n")
    return(tibble(title = NA, published = NA, updated = NA, link = link, content = NA))
  })
}

# Apply function to all article URLs
news_data <- lapply(full_article_links, get_article_details) %>% bind_rows()

# ---------- STEP 3: Output ----------

# View first few results
print(head(news_data, 3))

# Save to CSV
write.csv(news_data, "dhakatribune_articles.csv", row.names = FALSE)

# Clean up RSelenium
remDr$close()
rD$server$stop()

