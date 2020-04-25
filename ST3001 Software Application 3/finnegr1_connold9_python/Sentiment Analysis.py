# -*- coding: utf-8 -*-
"""
ST3001
Ross Finnegan & Devin Connolly

Python Sentiment Analysis
"""

import os
import sys
import pandas as pd
import nltk
import nltk.classify.util
import ctypes  

from nltk.corpus import stopwords
from nltk.classify import NaiveBayesClassifier
from nltk.tokenize import word_tokenize
    

##Part A - Importing & Cleaning
#Begin by ensuring an appropriate directory is selected
currentDir = os.getcwd()
print("Please ensure the CSV files are available in:", currentDir)
#Attach to the reviews file
reviewDir = os.path.join(currentDir, "yelp_review.csv")
#Attach to the business file
businessDir = os.path.join(currentDir, "yelp_business.csv")

#Read in the required columns (business id, stars, text) from the reviews csv file
#The nrows attribute is used to limit the size of the data taken from the csv. This may be adjusted as required.
try:
    reviews = pd.read_csv(reviewDir, usecols = [2,3,5], nrows = 100000)
except FileNotFoundError:
    ctypes.windll.user32.MessageBoxW(0, "Review file not found. Please check your working directory and file name.", "Error", 1)
    sys.exit("ERROR")
    
#Read in the required columns (business id, categories) from the business csv file
try:
    businesses = pd.read_csv(businessDir, usecols = [0,12], nrows = 100000)
except FileNotFoundError:
    ctypes.windll.user32.MessageBoxW(0, "Businesses file not found. Please check your working directory and file name.", "Error", 1)
    sys.exit("ERROR")
    
#Here you may select any category that you would like to analyse reviews from - In this case we have chosen hotels
#If the category does not exist the program is terminated
chosen_subset = businesses[businesses.categories.str.contains("Hotels")]
if len(chosen_subset) == 0:
    ctypes.windll.user32.MessageBoxW(0, "Category not found. Please check the list of available categories at www.yelp.com", "Error", 1)
    sys.exit("ERROR")



#Merging all the reviews to the corresponding businesses in chosen_subset
try:
    merged = pd.merge(chosen_subset, reviews, on="business_id")
except KeyError:
    ctypes.windll.user32.MessageBoxW(0, "No matching businesses found. Please retry", "Error", 1)
    sys.exit("ERROR")
    
##Part B - Sentiment Analysis    
#Selecting positive 5 star reviews
positive = merged[merged['stars']==5]
#Selecting negative 1 star reviews
negative = merged[merged['stars']==1]

#This function vectorises the review text into inidividual word lists
positive_words = positive.apply(lambda row: word_tokenize(row['text']), axis = 1)
negative_words = negative.apply(lambda row: word_tokenize(row['text']), axis = 1)


#Reset the indices for both series as they are incorrect due to the extract based on star rating above
positive_words = positive_words.reset_index(drop=True)
negative_words = negative_words.reset_index(drop=True)

#This is how the Naive Bayes classifier expects the input
def create_word_features(words):
    useful_words = [word for word in words if word not in stopwords.words('english')]
    my_dict = dict([(word, True) for word in useful_words])
    return my_dict

#Here we are creating the list that will be used for training and testing our sentiment analysis
#Each positive review is formatted as required and positive/negative is appended to mark the sentiment    
#Note: This loop may take up to 2 minutes to execute
pos_reviews = []
for review in range(len(positive_words)):
    words = positive_words[review]
    pos_reviews.append((create_word_features(words), "positive"))
    
neg_reviews = []
for review in range(len(negative_words)):
    words = negative_words[review]
    neg_reviews.append((create_word_features(words), "negative"))


#These limits are used to divide the train and test data.
#This step allows the program to run with varying sample sizes    
pos_set_limit = int(round(len(pos_reviews)*0.75,0))
neg_set_limit = int(round(len(neg_reviews)*0.75,0))

train_set = pos_reviews[:pos_set_limit]+ neg_reviews[:neg_set_limit]
test_set = pos_reviews[pos_set_limit:] + neg_reviews[neg_set_limit:]

#We use the naive bayes classifier from the nltk library to train our classifer
classifier = NaiveBayesClassifier.train(train_set)

#The performance of the classifier is then tested using the pre-established test set
accuracy = nltk.classify.util.accuracy(classifier, test_set)

print("Classifier complete!\nThis classifier trained on a sample size of",(len(train_set)),"reviews.\nThe test set returned an accuracy of ",round((accuracy * 100),2),"%")

########################################################################################
"""
In this section we will take a positive and negative review from real posts on TripAdvisor to see 

how our sentiment analysis tool performs

"""

review_imperial = """ The ONLY good thing about this hotel is the location. It is definitely more of a hostel than a hotel. 
It was one of 4 hotels that were included in our travel package to 4 cities in Ireland.
It was by far the biggest disappointment.
The hotel was not clean - we were given a room that had been a party room the night before. The carpet had been cleaned and was still soaking wet!!!
We had to be moved 3 times before we found a satisfactory room. The Salt Hill hotel is a much nicer place. Bar was not bad though - we met some very nice people there.
"""

words = word_tokenize(review_imperial)
words = create_word_features(words)
classifier.classify(words)

review_menlo = """Ended up booking to stay here last minute and we weren’t disappointed.
A lovely hotel with a friendly staff. Nice decor and rooms were nice and clean. 
Breakfast was the highlight - a great selection to please all tastes.
"""

words = word_tokenize(review_menlo)
words = create_word_features(words)
classifier.classify(words)
    