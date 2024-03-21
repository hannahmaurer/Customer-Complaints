library(readxl)
library(dplyr)
library(tidyverse)
library(tidyr)
library(ggplot2)
library(tidytext)
library(textdata)
library(wordcloud2)
library(stringr)

#Call the csv file
setwd('C:/Users/hanna/Documents/DATA 332/Consumer')
consumer_complaints <- read.csv('Consumer_Complaints.csv')

get_sentiments("afinn")
get_sentiments("bing")
get_sentiments("nrc")

#Rename column
consumer_complaints <- consumer_complaints %>%
  rename(word = Consumer.complaint.narrative)

#filter out blanks
df <- consumer_complaints %>%
  filter(word != "")

#chart with one word 
single_word <- df %>%
  mutate(word = str_split(word, "\\s+"))
single_word <- unnest(single_word, word)

#Remove punctuation and convert lowercase
clean_text <- function(text) {
  cleaned_text <- gsub("[[:punct:]]", "", text)
  cleaned_text <- tolower(cleaned_text)
  return(cleaned_text)
}

#Apply to table
single_word$word <- sapply(single_word$word, clean_text)

#create nrc sentiments table
nrc_negative <- get_sentiments("nrc") %>% 
  filter(sentiment == "negative")

nrc_negative_result <- single_word %>%
  inner_join(nrc_negative) %>%
  count(word, sort = TRUE)

top_tweleve_nrc_negative <- head(nrc_negative_result, 12)
  
ggplot(top_tweleve_nrc_negative, aes(x = word, y = n, fill = word)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = n), vjust = -.5, colour = "black") +
  labs(title = "Top 12 NRC Negative Words",
       x = "Word",
       y = "Amount Used") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  theme(legend.position = "none")

#create bing sentiments table
bing_negative <- get_sentiments("bing") %>%
  filter(sentiment == "negative")

bing_negative_result <- single_word %>%
  inner_join(bing_negative) %>%
  count(word, sort = TRUE)

top_tweleve_bing_negative <- head(bing_negative_result, 12)

ggplot(top_tweleve_bing_negative, aes(x = word, y = n, fill = word)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = n), vjust = -.5, colour = "black") +
  labs(title = "Top 12 BING Negative Words",
       x = "Word",
       y = "Amount Used") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  theme(legend.position = "none")

#create word clouds
wordcloud2(data = top_tweleve_nrc_negative)

wordcloud2(data = top_tweleve_bing_negative)

