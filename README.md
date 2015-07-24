Script run_analysis.R

Collates both test and train data from Samsung Galaxy S smartphone accelerometer.

Steps:
Read in raw data on all users and exercises with accelerometer data.

Merge observation exercise ID's (y_train.txt) with exercise descriptions (activity_labels.txt).
Remove column representing ID and rename descriptive column as 'Exercise'.
Repeat the above with the test files.

Take features list with numbers and descriptions. This is done because of duplicates.
Create vector and use vector to rename columns in both train and test data sets.

Column bind train subject data set and train data.
Column bind test subject data and train data.

Row bind both complete train and test sets.

Take relevant columns for mean and standard deviation keeping exercist and subject identifiers.
Melt dataset by Exercise and Subject.
Use dcast to calculate mean for all unique combinations of exercise and subject.
