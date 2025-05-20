
# Dhaka Tribune Newspaper Scraper

This project contains an R script to scrape recent news articles from Dhaka Tribune , a leading English-language news portal in Bangladesh. The script uses RSelenium for dynamic page interaction (e.g., clicking "Load More" buttons) and rvest for parsing article content.
## 🚀 Features

- Automates scrolling and clicking on "Load More" to fetch all available latest news.
- Extracts article URLs from the main news page.
- Scrapes detailed information including: Article title, Publication time, Last updated time, Full article content
- Outputs the collected data into a CSV file.
- Clean Selenium session termination after scraping is complete.



# 📦 Requirements

Ensure the following are installed before running the script:

- `RSelenium`
- `rvest`
- `dplyr`
- `stringr`
- `tidyverse` (optional)

## System Dependencies

- Java Runtime Environment (JRE)
- Firefox browser (GeckoDriver is used internally by RSelenium)

> ⚠️ **Note:** Some systems may require additional setup for RSelenium and headless browsing.

# 📁 Files Included

- `article_scraper.R`: Main R script to scrape articles.
- Output file generated automatically: `dhakatribune_articles.csv`


## ▶️ How to Run 
- Clone this repository:

```bash
  https://github.com/maruf9921/Dhaka_Tribune_Newspaper_Scraper
```
- Open the R script in RStudio or your preferred R environment.

- Ensure dependencies are installed:
```bash
  install.packages(c("RSelenium", "rvest", "dplyr", "stringr"))
```

- Run the script.

## 📝 Notes
- The website might change its structure, so CSS selectors used in the script may need updates accordingly.
- This scraper respects JavaScript-rendered content by leveraging Selenium.
- Always check the site’s robots.txt and terms of service before scraping.

## 🤝 Contributions
Contributions are welcome!
Feel free to submit a pull request or open an issue to suggest improvements, report bugs, or request new features.

    