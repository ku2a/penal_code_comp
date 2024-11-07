url = "https://www.conceptosjuridicos.com/codigo-penal"
lines = readLines(url)
contenido = lines[33]
html = read_html(url)
strong_elements = html |> html_nodes("strong")
strong_text <- strong_elements %>%
  html_text()
adjacent_text_raw <- strong_elements %>%
  html_nodes(xpath = "following-sibling::text() | following-sibling::a")  # Select all siblings after <strong>

# Extract clean text, ignoring HTML tags
adjacent_text <- adjacent_text_raw %>%
  html_text()  # This will get the text content and strip out any tags

# Combine the <strong> text and the adjacent cleaned text
combined_text <- paste(strong_text, adjacent_text,sep = '|')

# Print the combined result
print(combined_text)