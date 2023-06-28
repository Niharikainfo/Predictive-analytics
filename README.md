# Problem:
The problem at hand is the prediction of loan defaulters, which is a critical issue for banks and financial institutions. Loan defaulters pose a significant risk to the financial health of these institutions, potentially resulting in substantial financial losses. To mitigate this risk, banks are increasingly turning to machine learning algorithms to anticipate and identify borrowers who are more likely to default on their loans. The challenge lies in accurately classifying loan applicants as either defaulters or non-defaulters based on historical data and various borrower attributes.

# Solution:
The solution to the loan defaulter prediction problem involves building a reliable machine learning algorithm that can effectively classify borrowers based on their likelihood of defaulting on a loan. The algorithm needs to be trained using historical data that includes information about borrowers' income, gender, loan purpose, and other relevant variables. By analyzing patterns and relationships within this dataset, the algorithm can learn to make accurate predictions about the default risk associated with new loan applicants.

# Goal:
The primary goal is to develop a robust machine-learning algorithm that can accurately predict loan defaulters. This algorithm will enable banks to make informed decisions when assessing loan applicants, reducing the risk of financial losses. By accurately identifying potential defaulters, banks can adjust their lending practices, such as offering different interest rates or adjusting loan terms, to minimize risk and maximize revenue. Ultimately, the goal is to enhance the overall financial stability and profitability of the lending institution by leveraging predictive analytics to identify and mitigate default risk.

# About Dataset
The dataset contains both categorical and continuous variables, including factors such as credit type and region, and continuous variables such as age and income. There are also missing values and outliers in the dataset, which require preprocessing before building predictive models.

•	ID - This variable represents the unique ID of each loan borrower.
•	Gender - This variable represents the gender of the borrower (male/female).
•	approv_in_adv - This variable indicates whether the loan was approved in advance or not.
•	loan_type - This variable represents the type of loan (Type 1, Type 2, or Type 3).
•	loan_purpose - This variable indicates the purpose of the loan (p1, p2, p3, or p4).
•	Credit_Worthiness - This variable represents the type of creditworthiness (I1 or I2).
•	open_credit - This variable indicates whether the borrower has open credit or not.
•	business_or_commercial - This variable indicates whether the loan is for business or commercial purposes.
•	loan_amount - This variable represents the amount of the loan.
•	rate_of_interest - This variable represents the interest rate of the loan.
•	property_value - This variable represents the value of the property for which the loan is taken.
•	income - This variable represents the borrower's income.
•	credit_type - This variable represents the type of credit.
•	Credit_Score - This variable represents the credit score of the borrower.
•	age - This variable represents the age of the borrower.
•	LTV - This variable represents the loan-to-value ratio.
•	Region - This variable represents the region of the borrower.
•	Security_Type - This variable represents the type of security provided for the loan.
•	Status - This variable represents the loan status (0: Not approved; 1: Approved).

By analyzing these variables, we can identify the factors that are most likely to contribute to loan defaulters and develop a robust machine learning algorithm to predict the likelihood of defaulting on a loan.

# # Techniques, Tasks performed for Data Cleaning/EDA
1) Checked for missing values in the dataset.
2) Imputed missing values using the median/mode of respective variables.
3) Converted selected variables to factors for classification models.
4) Checked skewness, kurtosis, and outliers in continuous variables.
5) Treated outliers by replacing them with missing values.
6) Partitioned the data into training and testing sets.
7) Built twelve different models, including logistic regression, naive bayes, decision trees, and random forest.
8) Evaluated model performance using confusion matrix.
9) Created plots of decision tree models and extracted information from the random forest model.
10) Additional tasks included visualizing model structures and complexity.

# Algorithms used for creating the ML models

# # Logistic Regression
o	Model 1.1- removed outliers
o	Model 1.2- imputed outliers
o	Model 1.3- After removing insignificant variables
o	Model 1.4- After removing insignificant variables

# # Naive Bayes 
o	Model 2.1- Removed Outliers
o	Model 2.2- imputed outliers

# #	Decision Trees (with criterion as information gain)
o	Model 3.1- Removed outliers
o	Models 3.2- imputed outliers

# # Decision Trees (with criterion as gini index)
o	Model 4.1- Removed outliers
o	Model 4.2- Imputed outliers

# #	Random Forest 
o	Model 5.1- Removed outliers
o	Model 5.2- imputed outliers

# Evaluation of various models
The given models have been evaluated based on their confusion matrix, which provides information on the accuracy, sensitivity, specificity, and balanced accuracy of the model's predictions.

# Model 1.2:
Accuracy: 85.29% of predictions are correct.
Sensitivity: 99.54% of loans getting ‘not approved’ are correctly predicted. 
Specificity: 42.36% of loan getting ‘approved’ are correctly predicted.
Balanced Accuracy: 0.7095

# Model 1.1:
Accuracy: 83.92%
Sensitivity: 99.72%
Specificity: 37.19%
Balanced Accuracy: 0.6846

# Model 1.3:
Accuracy: 83.92%
Sensitivity: 99.72%
Specificity: 37.19%
Balanced Accuracy: 0.6846

# Model 1.4:
Accuracy: 85.47%
Sensitivity: 99.77%
Specificity: 42.36%
Balanced Accuracy: 0.7107

# Model 2.2:
Accuracy: 85.99%
Sensitivity: 100%
Specificity: 43.75%
Balanced Accuracy: 0.7188

# Model 2.1:
Accuracy: 83.92%
Sensitivity: 100%
Specificity: 36.36%
Balanced Accuracy: 0.6818

# Model 3.2:
Accuracy: 86.33%
Sensitivity: 97.24%
Specificity: 53.47%
Balanced Accuracy: 0.7535

# Model 3.1:
Accuracy: 90.19%
Sensitivity: 86.87%
Specificity: 100%
Balanced Accuracy: 0.9344

# Model 4.2:
Accuracy: 86.33%
Sensitivity: 97.24%
Specificity: 53.47%
Balanced Accuracy: 0.7535

# Model 4.1:
Accuracy: 90.19%
Sensitivity: 86.87%
Specificity: 100%
Balanced Accuracy: 0.9344

# Model 5.2:
Accuracy: 85.81%
Sensitivity: 90.55%
Specificity: 71.53%
Balanced Accuracy: 0.8104

# Model 5.1:
Accuracy: 89.56%
Sensitivity: 94.41%
Specificity: 75.21%
Balanced Accuracy: 0.8481

# Conclusion/ Result
Model 3.1 is the most accurate model for predicting loan defaulters, with an accuracy of 90.19%. It has a high sensitivity of 86.87% and a perfect specificity of 100%. The balanced accuracy of Model 3.1 is 0.9344, indicating its overall effectiveness in correctly predicting both approved and not approved loans.



