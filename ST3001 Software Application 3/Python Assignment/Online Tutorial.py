# -*- coding: utf-8 -*-
"""
Created on Fri Apr  6 10:39:21 2018

@author: Ross

"""
#imports the nltk library by using the built in downloader
import nltk
nltk.download()

import nltk.classify.util
from nltk.classify import NaiveBayesClassifier
from nltk.corpus import movie_reviews
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
from nltk.corpus import wordnet

sent = "The quick brown fox, jumps over the lazy little dog. Hello World!"

#splits sentence by delimiter
sent.split(" ")

#tokenises each word, accounts for punctuation
toks = word_tokenize(sent)
toks

#analyses each word and categorises them accordingly
nltk.pos_tag(toks)

#Gives detail of each tag from line above
nltk.help.upenn_tagset()

#Finds definitions of any word
syn = wordnet.synsets("computer")
print(syn)
print(syn[1].name())
print(syn[1].definition())

syn = wordnet.synsets("talk")
syn[0].examples()

syn = wordnet.synsets("speak")[0]
print(syn.hyponyms())

syn = wordnet.synsets("good")
for s in syn:
    for l in s.lemmas():
        if(l.antonyms()):
            print(l.antonyms())

#Words which have no meaning, useless in sentiment analysis            
#English language selected
stopwords.words('english')[:16]

para = "The program was open to all women between the ages of 17 and 35, in good health, who had graduated from an accredited high school. "
words = word_tokenize(para)

#Removes all the useless words
useful_words = [word for word in words if word not in stopwords.words('english')]
print(useful_words)
            

#Accessing the movie reviews data imported at the top
movie_reviews.words()
#Shows the two types positive and negative
movie_reviews.categories()

movie_reviews.fileids()[:4]
#Reads in all the words in the movie reviews
all_words = movie_reviews.words()
#Generates a frequency distribution of all the words
frds = nltk.FreqDist(all_words)
#Brings up the 20 most common words 
frds.most_common(20)


#Function which creates the correct format to use the Naive Bayes classifier
def create_word_features(words):
    useful_words = [word for word in words if word not in stopwords.words('english')]
    my_dict = dict([(word, True) for word in useful_words])
    return my_dict

create_word_features(["the", "quick", "brown", "quick", "a", "fox"])

neg_reviews = []
for fileid in movie_reviews.fileids('neg'):
    words = movie_reviews.words(fileid)
    neg_reviews.append((create_word_features(words),"negative"))
print(len(neg_reviews))
