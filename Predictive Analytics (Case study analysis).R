library(dplyr)
library(DescTools)
library(moments)
library(ggplot2)
library(imputeMissings)
library(purrr)
library(caret)
library(naivebayes)
library(rpart.plot)
library(randomForest)
#_______________________________________________________________________________

L<-as.data.frame(LoanDefaulters)

str(L)
#_______________________________________________________________________________

#check for missing values
map(L, ~sum(is.na(.)))

#impute missing values with median
L<-impute(L, method="median/mode")

#check for missing values again
map(L, ~sum(is.na(.)))
#_______________________________________________________________________________

#converting to factors
L[,c(2:8)]<-lapply(L[,c(2:8)],factor)
L$credit_type<-as.factor(L$credit_type)
L$age<-as.factor(L$age)
L$Region<-as.factor(L$Region)
L$Security_Type<-as.factor(L$Security_Type)
L$Status<-as.factor(L$Status)
#_______________________________________________________________________________

#checking for skewness, kurtosis, outliers in all continous variables

skewness(L$loan_amount)
kurtosis(L$loan_amount)
boxplot(L$loan_amount)

skewness(L$rate_of_interest)
kurtosis(L$rate_of_interest)
boxplot(L$rate_of_interest)

skewness(L$property_value)
kurtosis(L$property_value)
boxplot(L$property_value)

skewness(L$income)
kurtosis(L$income)
boxplot(L$income)

skewness(L$LTV)
kurtosis(L$LTV)
boxplot(L$LTV)

skewness(L$Credit_Score)
kurtosis(L$Credit_Score)
boxplot(L$Credit_Score)

#treating outliers

#storing outliers

outincome<-boxplot(L$income)$out
outloan<-boxplot(L$loan_amount)$out
outrate<-boxplot(L$rate_of_interest)$out
outprop<-boxplot(L$property_value)$out
outLTV<-boxplot(L$LTV)$out

#method 1; removing outliers
#creating L1
L1<-L

L1<- L1[-which(L$income %in% outincome),]
L1<- L1[-which(L$loan_amount %in% outloan),]
L1<- L1[-which(L$rate_of_interest %in% outrate),]
L1<- L1[-which(L$property_value %in% outprop),]
L1<- L1[-which(L$LTV %in% outLTV),]

#after removing outiers we still need to handle the skewness and kurtosis of 2 variables

#transformations

L1$loan_amountT<-sqrt(L1$loan_amount)
skewness(L1$loan_amountT)
kurtosis(L1$loan_amountT)

L1$property_valueT<-log10(L1$property_value)
skewness(L1$property_valueT)
kurtosis(L1$property_valueT)

#method 2: impute outliers
#creating L2
L2<-L

#replacing the outliers with NA i.e. missing values

L2[L2$loan_amount %in% outloan, "loan_amount"] = NA
L2[L2$income %in% outincome, "income"] = NA
L2[L2$LTV %in% outLTV, "LTV"] = NA
L2[L2$property_value %in% outprop, "property_value"] = NA
L2[L2$rate_of_interest %in% outrate, "rate_of_interest"] = NA

#imputing missing values

L2<-impute(L2, method="median/mode")

#with imputation, all the skewness and kurtosis are normalised.
#_______________________________________________________________________________

#Data partition
#1 (removed outliers) (Used in Models: M1.1, M2.1, M3.1, M4.1, M5.1)
set.seed(100)
Train1 <- createDataPartition(L1$Status, p=0.8, list=FALSE)
training1 <- L1[ Train1, ]
testing1 <- L1[ -Train1, ]

#_______________________________________________________________________________

#Model 1.1 (removed outliers)
#create the model using logistic regression
M1.1<-train(data=training1, Status ~ Gender + approv_in_adv + loan_amountT + loan_type 
          + loan_purpose + Credit_Worthiness + open_credit + business_or_commercial 
          + rate_of_interest + property_valueT + credit_type + Credit_Score + LTV 
          + age + Region + income, method="glm", family="binomial")

summary(M1.1)


#after removing the insignificant variables
M1.3<-train(data=training1, Status ~ loan_type + loan_purpose + open_credit 
            + rate_of_interest + credit_type + LTV + age + income, 
            method="glm", family="binomial")

#_______________________________________________________________________________

#Model 2.1 (removed outliers)
#create the model using naive bayes

M2.1 <- train(data=training1, Status ~ Gender+approv_in_adv + loan_amountT + loan_type 
            + loan_purpose + Credit_Worthiness + open_credit + business_or_commercial 
            + rate_of_interest + property_valueT +credit_type +Credit_Score + LTV 
            + age + Region + income, method="naive_bayes")
#_______________________________________________________________________________

#Model 3.1 (removed outliers)
#create the model using decision tree
#creating the model with criterion as information gain

M3.1 <- train(Status ~ Gender + approv_in_adv + loan_amountT + loan_type 
            + loan_purpose + Credit_Worthiness + open_credit + business_or_commercial 
            + rate_of_interest + property_valueT + credit_type + Credit_Score + LTV 
            + age + Region + income, data = training1, method = "rpart",parms = list(split = "information"))

# plot decision tree
rpart.plot(M3.1$finalModel)

#_______________________________________________________________________________

#Model 4.1 (removed outliers)
#create the model using decision tree
#creating the model with criterion as gini index

M4.1 <- train(Status ~ Gender+approv_in_adv + loan_amountT + loan_type 
            + loan_purpose + Credit_Worthiness + open_credit + business_or_commercial 
            + rate_of_interest + property_valueT +credit_type +Credit_Score + LTV 
            + age + Region + income, data = training1, method = "rpart")

# plot decision tree
rpart.plot(M4.1$finalModel)
#_______________________________________________________________________________

#Model 5.1 (removed outliers)
#create the model using random forest

M5.1 <- train(Status ~ Gender + approv_in_adv + loan_amount + loan_type 
            + loan_purpose + Credit_Worthiness + open_credit 
            + business_or_commercial + rate_of_interest + property_value 
            + credit_type + Credit_Score + LTV + age + Region 
            + income, data = training1, method = "rf")

#M5.1 output
M5.1
M5.1$finalModel
#_______________________________________________________________________________

# prediction for test data

predStatus1.1<-predict(M1.1, newdata = testing1)
predStatus1.3<-predict(M1.3, newdata = testing1)
predStatus2.1<-predict(M2.1, newdata = testing1)
predStatus3.1<-predict(M3.1, newdata = testing1)
predStatus4.1<-predict(M4.1, newdata = testing1)
predStatus5.1<-predict(M5.1, newdata = testing1)

#fitness metrics for validation
confusionMatrix(predStatus1.1, testing1$Status)
confusionMatrix(predStatus1.3, testing1$Status)
confusionMatrix(predStatus2.1, testing1$Status)
confusionMatrix(predStatus3.1, testing1$Status)
confusionMatrix(predStatus4.1, testing1$Status)
confusionMatrix(predStatus5.1, testing1$Status)
#_______________________________________________________________________________


#Model 1.2 (imputed outliers)
#create the model using logistic reression
M1.2 <-train(data=training2, Status ~ Gender + approv_in_adv + loan_amount + loan_type 
          + loan_purpose + Credit_Worthiness + open_credit + business_or_commercial 
          + rate_of_interest + property_value + credit_type + Credit_Score + LTV 
          + age + Region + income, method="glm", family="binomial")

summary(M1.2)

#after removing the insignificant variables

M1.4 <-train(data=training2, Status ~ Gender + loan_type + loan_purpose 
             + rate_of_interest + property_value + credit_type + LTV 
             + age + income, method="glm", family="binomial")

#_______________________________________________________________________________

#Model 2.2 (imputed outliers)
#create the model using naive bayes

M2.2 <- train(data=training2, Status ~ Gender+approv_in_adv + loan_amount + loan_type 
            + loan_purpose + Credit_Worthiness + open_credit + business_or_commercial 
            + rate_of_interest + property_value +credit_type +Credit_Score + LTV 
            + age + Region + income, method="naive_bayes")
#_______________________________________________________________________________

#Model 3.2 (imputed outliers)
#create the model using decision tree
#creating the model with criterion as information gain

M3.2 <- train(Status ~ Gender+approv_in_adv + loan_amount + loan_type 
            + loan_purpose + Credit_Worthiness + open_credit + business_or_commercial 
            + rate_of_interest + property_value + credit_type + Credit_Score + LTV 
            + age + Region + income, data = training2, method = "rpart",parms = list(split = "information"))

# plot decision tree
rpart.plot(M3.2$finalModel)

#_______________________________________________________________________________

#Model 4.2 (imputed outliers)
#create the model using decision tree
#creating the model with criterion as gini index

M4.2 <- train(Status ~ Gender+approv_in_adv + loan_amount + loan_type 
            + loan_purpose + Credit_Worthiness + open_credit + business_or_commercial 
            + rate_of_interest + property_value +credit_type +Credit_Score + LTV 
            + age + Region + income, data = training2, method = "rpart")

# plot decision tree
rpart.plot(M4.2$finalModel)
#_______________________________________________________________________________

#Model 5.2 (imputed outliers)
#create the model using random forest

M5.2 <- train(Status ~ Gender + approv_in_adv + loan_amount + loan_type 
            + loan_purpose + Credit_Worthiness + open_credit 
            + business_or_commercial + rate_of_interest + property_value 
            + credit_type + Credit_Score + LTV + age + Region 
            + income, data = training2, method = "rf")

#M5.2 output
M5.2
M5.2$finalModel
#_______________________________________________________________________________

# prediction for test data

predStatus1.2<-predict(M1.2, newdata = testing2)
predStatus1.4<-predict(M1.4, newdata = testing2)
predStatus2.2<-predict(M2.2, newdata = testing2)
predStatus3.2<-predict(M3.2, newdata = testing2)
predStatus4.2<-predict(M4.2, newdata = testing2)
predStatus5.2<-predict(M5.2, newdata = testing2)

#fitness metrics for validation
confusionMatrix(predStatus1.2, testing2$Status)
confusionMatrix(predStatus1.4, testing2$Status)
confusionMatrix(predStatus2.2, testing2$Status)
confusionMatrix(predStatus3.2, testing2$Status)
confusionMatrix(predStatus4.2, testing2$Status)
confusionMatrix(predStatus5.2, testing2$Status)

#_______________________________________________________________________________





