# Data-Analyses-on-Defect-Data-with-Defect-Prediction-Methods
Data Analyses on Defect Data and Experiments with Defect Prediction Methods

In spite of diligent planning, good documentation and proper process control during software development, appearance
of defects are inevitable. These software defects may lead to degradation of the quality and even sometimes extremely serious
problems. Defect Prediction Models aim at identifying errorprone modules of a software system to guide quality assurance
activities such as tests or code reviews. But checking every metrics includes a lot of cost and man power, so in this paper, I study
whether the precision of existing models for defect prediction can be improved using our top correlated metrics and/or by
combining the top metrics.

1. Data - (Can share the datasets on request)
Five datasets for this project, Each dataset (compressed) contains several csv files. we use:

i. single-version-ck-oo.csv contains code metrics for all source files. For example, "numberOfLinesOfCode" is the file size in term of lines of code.

ii. change-metrics.csv contains metrics for change histories of all source files. For example, "linesAddedUntil" is the total number of lines of code added to this file.

iii. bug-metrics.csv contains metrics for bug histories of all source files. For example, "numberOfBugsFoundUntil" is the total number of bugs found in this file.

Each file also contains the number of post-release defects in column "bugs".

2. Research questions
Performed data analysis and machine learning to answer the following research questions for each provided dataset.

a. What are the metrics with highest correlation to the number of post-release defects ("bugs")? You should identify top 5 metrics in single-version-ck-oo.csv, 5 in change-metrics.csv, and 2 in bug-metrics.csv. How those metrics correlate to each other?

b. What are the prediction performance of each of those metrics on the following regression models? 

i. Linear regression model (function lm)

ii. Tree regression model (function rpart in library rpart)

iii. negative binomial generalized linear model (function glm.nb in library MASS)

To measure prediction performance, you should use the following cross-validation method:

i. Select randomly 80% data for training and 20% for predicting. You should set the random seed as the last 4 digits of your A number.

ii. Compute the mean absolute error and Spearman ranked correlation of the predicted and the actual number of post-release defects.

iii. Repeat this process 30 times and compute the average results as the overall prediction performance.

c. What are the highest prediction performance when combining the metrics? You should select at most 2 top metrics from each data file and run all three aforementioned regression models. Which model has the highest performance?
