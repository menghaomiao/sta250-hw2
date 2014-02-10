#Please run this script before implementing any methods!
#Warnings: please change your working dictionary to where your Airline CSV files stored before running it!
#Also ensure that your working dictionary ONLY has those 81 CSV files!
#This script is for some global variables which will be used in the following methods.

files=list.files()[1:81]
first=sapply(1:81, function(i) readLines(files[i], 1))
ind1=sapply(1:81, function(i) which(strsplit(first, ',')[[i]] %in% c('ArrDelay', '"ARR_DELAY"')))
ind2=c(rep(15, 21), rep(45, 60))
command1=paste0('cut -f', ind2, ' -d, ', files, ' | tail -n +2')
