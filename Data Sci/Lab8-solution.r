#This will remove (almost) everything in the working environment before you start
rm(list=ls())

#if you set the seed you will get the same results every time, if not, you will get different results every time.
set.seed(123)   #try putting a # in front of this line and run the code a few times to see what happens, then remove the # and run it a few times to see the difference...

#Load the library class
library('class')

#Load the library caret
#The caret library does a lot more than just SVM
#For more details on caret see https://topepo.github.io/caret/index.html
library('caret')

########################################
#       the normalize function         #
########################################

#the normalize function in the range [−1,1] 
normalize <- function(x) {
  num <- x - min(x)
  denom <- max(x) - min(x)
  
  return (2*(num/denom)-1)
}

########################################
#         read in the data             #
########################################

generators <- read.csv('generators.csv')
#some people had problems reading in the generators.csv file in the last lab
#you can try creating a folder on your desktop called Lab4
#one of the following options should work for you (depending on whether you are using mac, Linux or windows) -- let me know if you are still having problems
#generators <- read.csv('~/Desktop/Lab4/generators.csv')
#generators<-read.csv('~\\Desktop\\Lab4\\generators.csv')

#display the generators data
print(head(generators))

########################################
#        normalise the data            #
########################################

#apply the normalize function to the two columns of data in 'generators' that you will use during the training and testing of the SVM
#see ?lapply for an explanation of what lapply does 

generators['RPM'] <- as.data.frame(lapply(generators['RPM'], normalize))
generators['Vibration'] <- as.data.frame(lapply(generators['Vibration'], normalize))

########################################
#     5. Training And Test Sets        #
########################################

#Factors are variables in R which take on a limited number of different values; such variables are often referred to as categorical variables. Since categorical variables enter into models differently than continuous variables, storing data as factors insures that the modelling functions will treat such data correctly.
#Factors in R are stored as a vector of integer values with a corresponding set of character values to use when the factor is displayed. The factor function is used to create a factor. 
table(factor(generators$Status))
generators$Status<-factor(generators$Status,labels=c('faulty','good'))

#The function createDataPartition can be used to create a stratified random sample of the data into training and test sets:
#see ?createDataPartition for more details of the function
inTraining <- createDataPartition(generators$Status, p = .75, list = FALSE)#create a training set with 75% of the date
training <- generators[ inTraining,]#this is the training set
testing  <- generators[-inTraining,]#this is the test set

#For best results the number of instances of both classes needs to be present at more or less the same ratio in your training and test sets. You can check this using summary():

summary(training)
summary(testing)

########################################
#      6. Training a SVM model         #
########################################

#Set up the control parameters for the train function see ?trainControl for more details
#Here we are setting up a 10-fold cross-validation training
ctrl <- trainControl(method = "cv", number = 10, search = "grid", savePred=T)

#The train function uses ctrl to set up a grid of tuning parameters for our SVM
#Here we use a 'svmLinear' Kernel we could also try a 'svmRadial' or 'svmPoly' for example
#see http://topepo.github.io/caret/train-models-by-tag.html#Support_Vector_Machines for a full list of Kernels available
model <- train(training[,2:3], training$Status, method = 'svmLinear', metric = 'Accuracy', trControl = ctrl)

print(model)

# test our model with the independent test set we created earlier
pred <- predict(model,testing[,2:3])

########################################
#        7. Model Evaluation           #
########################################

cm = as.matrix(table(Actual = testing$Status, Predicted = pred))

print("Confusion Matrix")
print(cm)

TP= cm[1,1]
TN= cm[2,2]
FP= cm[2,1]
FN= cm[1,2]

classification_accuracy=(TP+TN)/(TP + TN + FP + FN)
misclassification_rate=(FP + FN)/(TP + TN + FP + FN)

print("classification_accuracy")
print(classification_accuracy)

print("misclassification_rate")
print(misclassification_rate)

TRP=TP/(TP+FN)
TNR=TN/(TN+FP)
FPR=FP/(TN+FP)
FNR=FN/(TP+FN)

precision=TP/(TP+FP)
recall=TP/(TP+FN)

print("precision")
print(precision)

print("recall")
print(recall)

F1_measure =2*(precision*recall)/(precision+recall)

print("F1_measure")
print(F1_measure)



########################################
#        average class accuracy        #
########################################

#The arithmetic mean average class accuracy is calculated as: 1/(the number of levels that the target feature can assume -- in this case 2) * the sum of the recall achieved for each level  (see your book for a full explanation: Ch 8 section 8.4.2.3 Average Class Accuracy)

#calculate recall for the first level
recall_l1=TP/(TP+FN)

#calculate recall for the second level
recall_l2=TN/(TN+FP)

average_class_accuracy_am = 1/2 * (recall_l1 + recall_l2)

print("average_class_accuracy_am")
print(average_class_accuracy_am)

#The harmonic mean average class accuracy (see your book for a full explanation: Ch 8 section 8.4.2.3 Average Class Accuracy)
average_class_accuracy_hm = 1/( 1/2 * (1/recall_l1 + 1/recall_l2) )

print("average_class_accuracy_hm")
print(average_class_accuracy_hm)

##################################################
# 8. Compare performance of SVM to KNN #
##################################################

#See if you can improve the performance by changing the value of k. 
#We can use a loop to find the best value of k between 0 and 10
#To decide which is "best" we need to decide which performance measure to use
#In this case I am using the arithmetic mean average class accuracy (average_class_accuracy_am)
#I am calculating the average_class_accuracy_am for each value of k and saving it to a vector and then plotting the result

accuracy <- rep(0, 10)
k <- 1:10
for(x in k){

	generators_pred <- knn(train = training[,2:3], test = testing[,2:3], cl = training$Status, k=x)
	cm = as.matrix(table(Actual = testing$Status, Predicted = generators_pred))

	TP= cm[1,1]
	TN= cm[2,2]
	FP= cm[2,1]
	FN= cm[1,2]

	#calculate recall for the first level
	recall_l1=TP/(TP+FN)
	#calculate recall for the second level
	recall_l2=TN/(TN+FP)
	average_class_accuracy_am = 1/2 * (recall_l1 + recall_l2)

	accuracy[x] <- average_class_accuracy_am
}

plot(k, accuracy, type = 'b')

########################################
# 9. KNN Model Evaluation with k = 10  #
########################################
print("KNN Model Evaluation with k = 10")
generators_pred <- knn(train = training[,2:3], test = testing[,2:3], cl = training$Status, k=10)
cm = as.matrix(table(Actual = testing$Status, Predicted = generators_pred))

print("Confusion Matrix")
print(cm)

TP= cm[1,1]
TN= cm[2,2]
FP= cm[2,1]
FN= cm[1,2]

classification_accuracy=(TP+TN)/(TP + TN + FP + FN)
misclassification_rate=(FP + FN)/(TP + TN + FP + FN)

print("classification_accuracy")
print(classification_accuracy)

print("misclassification_rate")
print(misclassification_rate)

TRP=TP/(TP+FN)
TNR=TN/(TN+FP)
FPR=FP/(TN+FP)
FNR=FN/(TP+FN)

precision=TP/(TP+FP)
recall=TP/(TP+FN)

print("precision")
print(precision)

print("recall")
print(recall)


F1_measure =2*(precision*recall)/(precision+recall)

print("F1_measure")
print(F1_measure)


########################################
#        average class accuracy        #
########################################

#The arithmetic mean average class accuracy is calculated as: 1/(the number of levels that the target feature can assume -- in this case 2) * the sum of the recall achieved for each level  (see your book for a full explanation: Ch 8 section 8.4.2.3 Average Class Accuracy)

#calculate recall for the first level
recall_l1=TP/(TP+FN)

#calculate recall for the second level
recall_l2=TN/(TN+FP)

average_class_accuracy_am = 1/2 * (recall_l1 + recall_l2)

print("average_class_accuracy_am")
print(average_class_accuracy_am)

#The harmonic mean average class accuracy (see your book for a full explanation: Ch 8 section 8.4.2.3 Average Class Accuracy)
average_class_accuracy_hm = 1/( 1/2 * (1/recall_l1 + 1/recall_l2) )

print("average_class_accuracy_hm")
print(average_class_accuracy_hm)


