# Lung cancer random forest

This R code uses data taken from Kaggle, it contains 15 features such as Smoking, Yellow Fingers, Allergies among others along with the target for estimating which is whether the patient developed Lung Cancer. It is a binary classification problem and is only a small dataset with less than 400 rows in total. 

I used supervised learning with a training set comprising of 70% of the original dataset. Random forest is useful in that it takes bootstrapped samples of features from your dataset and uses them in the different layers of decision trees within your forest, this solves one of the common issues of optimising feature selection within machine learning.

As it stands the final accuracy score is 89%, more effort needs to be made to reduce the false negatives as these carry the highest risk overall. 
