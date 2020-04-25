#Part 1 - Setting the working directory
setwd("U:/ST3002")

#Part 2 - Establishing advice clause vectors
direct = c("It is your responsibility to", "It is not your responsibility to")
recommend = c("You should", "You should not")

#Some advice vectors
food = c("eat less", "eat more", "eat pineapple")
dance = c("dance as your career", "never dance again", "get a new hobby")
homework = c("do homework today", "do homework tomorrow", "always do your homework")

#Part 3 - Access single element of my vectors
resp =direct[1]
danceadvice = dance[2]

#Part 4 - Accessing elements from two of my vectors to generate advice
str = paste(recommend[2], homework[1])
cat(str, "\n")

#Part 5 - Using Random integers to generate advice
idx = sample(1:2, size = 1, replace = TRUE)
idx2 = sample (1:3, size = 1, replace = TRUE)
advice = paste(direct[idx], food[idx2])

#Part 6
for(i in 1:100){
  
  idx = sample(1:2, size = 1, replace = TRUE)
  idx2 = sample (1:3, size = 1, replace = TRUE)
  rand = sample(1:2, size = 1, replace = TRUE)
  rand2 = sample(1:3, size = 1, replace = TRUE)
  
  #Using idx and idx2 to determine the advice clause and advice vector
  if(idx == 1){
    adviceclause = direct
    if(idx2 == 1){
      advicevector = food
      advice = paste(adviceclause[rand], advicevector[rand2], sep= " ")
      cat(advice, "\n")
    }
    else if(idx2 == 2){
      advicevector = dance
      advice = paste(adviceclause[rand], advicevector[rand2], sep= " ")
      cat(advice, "\n")
    }
    else{
      advicevector = homework
      advice = paste(adviceclause[rand], advicevector[rand2], sep= " ")
      cat(advice, "\n")
    }
  }

  else{
      adviceclause = recommend
      if(idx2 ==1){
        advicevector = food
        advice = paste(adviceclause[rand], advicevector[rand2], sep= " ")
        cat(advice, "\n")
      }
      else if(idx2 == 2){
        #condition to account for "Not Never" (double negative)
        if(rand == 2 && rand2 == 2){
          adviceedit = "You should"
          advice = paste(adviceedit, advicevector[rand2], sep= " ")
          cat(advice, "\n")
        }else{
        advicevector = dance
        advice = paste(adviceclause[rand], advicevector[rand2], sep= " ")
        cat(advice, "\n")
        }
      }
      else{
        advicevector = homework
        advice = paste(adviceclause[rand], advicevector[rand2], sep= " ")
        cat(advice, "\n")
      }
  }
  }