#Human Activity Recognition Using Smartphones Data Set

##Description of Experiment and Data

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, the researchers captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

##Description of Variables

The subject id and activity variables can be understood intuitively. 

The accelerometer and gyroscope measurement variable names have as many as seven components indicating what and how they were measured:

1) "t" or "f"
     The "t" at the beginning of each acceleration and measurement variable name simply denotes that the measurements are time domain signals. An "f" at the beginning of the variable name indicates that a Fast Fourier Transform (FFT) was applied to the signal.
     
2) "Acc" or "Gyro" 
    "Acc" or "Gyro" in the variable names indicates whether the measurement was taken by the accelerometer or the gyroscope. 
    
3) "Body" or "Gravity"  
    The acceleration signal was separated into body and gravity signals using a low pass filter. The "Body" and "Gravity" segments of the variable names indicate which signal measurement the variable contains.
    
4) "Jerk"    
    The body linear acceleration and angular velocity were derived in time to obtain Jerk signals-- indicated by "Jerk" in the variable names. 
    
5) "Mag"
     The magnitude of the three-dimensional signals were calculated using the Euclidean norm, indicated by "Mag" in the variable names.

6) "Mean" or "Std"
    "mean" and "std" mean that these statistics were estimated for the signal.

7) "X", "Y", or "Z" 
    "X" "Y", or "Z" indicate denote 3-axial signals. 

##Data Transformations 

To form the data frame for analysis 6 files were merged. These included three separate files for both test and training: one containing subject id numbers, one containing acceleration and velocity
measurements, and one containing the subjects activity at the time of
the measurement. I excluded the inertial signals files. The final data frame is in the long form.

Once the test and training dataframes were merged into one, the acceleration and velocity measurements that were mean or standard deviations were extracted from the data frame to form a new, smaller,
data frame. The criterion for doing so was to select only those variables that ended with "mean()" or "std()".

There were no NA values in this data set. 
