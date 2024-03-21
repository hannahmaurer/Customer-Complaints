# Consumer Complaints
## Contributors
Hannah Maurer
## Introduction
With this CSV file, we were able to clean and manipulate the data to analyze the top 12 NRC and BING negative words.
## Dictionary
1. NRC - "Categorizes words in a binary fashion (“yes”/“no”) into categories of positive, negative, anger, anticipation, disgust, fear, joy, sadness, surprise, and trust."
2. BING - "Categorizes words in a binary fashion into positive and negative categories."

Source: https://www.tidytextmining.com/sentiment.html
## Data Cleaning
1. I edited the file so the complaints column title matched the word title in the nrc_negative table

`consumer_complaints <- consumer_complaints %>%
  rename(word = Consumer.complaint.narrative)`

2. I filtered out all the blanks in the column

`df <- consumer_complaints %>%
  filter(word != "")`

3. I set the column so each word had its own row

`single_word <- df %>%
  mutate(word = str_split(word, "\\s+"))
single_word <- unnest(single_word, word)`

4. I created a function that removes punctuation and makes all the words lowercase

`clean_text <- function(text) {
  cleaned_text <- gsub("[[:punct:]]", "", text)
  cleaned_text <- tolower(cleaned_text)
  return(cleaned_text)
}`

5. I then applied the function to the table

`single_word$word <- sapply(single_word$word, clean_text)`
## Data Analysis
1. Top 12 NRC Negative Words
   ![Top 12 NRC Negative Words](https://github.com/hannahmaurer/Customer-Complaints/assets/159860800/3f1ecbce-5cb1-463a-97c9-e710d5a52363)
- Using the bar chart we are able to get an accurate representation of what words were used heavy in the customers complaints
2. Top 12 BING Negative Words
   ![Top 12 BING Negative Words](https://github.com/hannahmaurer/Customer-Complaints/assets/159860800/adf94c19-189e-429b-921d-71cc8eb078e0)
- Using the bar chart we are able to get an accurate representation of what words were used heavy in the customers complaints
3. Top 12 NRC Negative Word Cloud
   ![Top 12 NRC Negative Word Cloud](https://github.com/hannahmaurer/Customer-Complaints/assets/159860800/205c659e-fa54-48c9-807c-b9404649fd42)
- The word cloud uses a range of sizes to accurately show the usage of the word
4. Top 12 BING Negative Word Cloud
   ![Top 12 BING Negative Word Cloud](https://github.com/hannahmaurer/Customer-Complaints/assets/159860800/ecc75787-17e0-4c47-ba96-59c15066aa24)
- The word cloud uses a range of sizes to accurately show the usage of the word
    







