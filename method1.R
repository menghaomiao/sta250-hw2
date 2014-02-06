#method1 is to distribute those files to some nodes and open the whole file.
#After returning a list of all the arrival delay time, use R to compute some statistics.

library(parallel)
files=list.files()[1:81]
first=sapply(1:81, function(i) readLines(files[i], 1))
ind1=sapply(1:81, function(i) which(strsplit(first, ',')[[i]] %in% c('ArrDelay', '"ARR_DELAY"')))
method1=function(cores=32) {
 delays=mclapply(1:81, function(i) read.csv(files[i])[[ind1[i]]], mc.cores=cores, mc.preschedule=F)
 delays=unlist(delays)
 funs=c(mean=mean, sd=sd, median=median)
 sapply(funs, function(f) f(delays, na.rm=T))
}
tm1=system.time(ans1<-method1())