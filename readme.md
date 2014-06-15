
The run_analysis.R script works as follows
1. The original raw files (excluding the Inertial Signals) are combined to create a single file.  This single file contains rows for the training and test data, and columns for the subject, activity, and feature measurements.
2. Measurements for the mean value (as signified by mean() in the variable name) and standard deviation (as signified by std() in the variable name) are retained.  This excludes the separate weighted average of the frequency components (as signified by meanFreq() in the variable name).
3. Meaningful labels are created for each activity
4. The variable names are recoded to be more explanatory
5. A new tidy dataset is created, containing a mean value for each combination of subject and activity on each of the retained measurements.

The new dataset conforms to tidy data principles as 
1. Each variable (average mean value and average standard deviation) forms a column
2. Each observation (combination of subject and activity) forms a row
3. We have a single table containing this data

The variable names are descriptive as they explain the original measurement, and the statistic applied to this measurement (e.g. mean, standard deviation).  All measurement variables contain the average value for the given subject and activity for the given measurement.