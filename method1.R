#package "parallel" is required for this method.
#method1 is to distribute 81 CSV files to some nodes and open the whole file.
#After returning a list of all the arrival delay time, use R to compute some statistics.
#Usage: method1(cores), where cores specifies the number of help nodes.

method1=function(cores=32) {
 delays=mclapply(1:81, function(i) read.csv(files[i])[[ind1[i]]], mc.cores=cores, mc.preschedule=F)
 delays=unlist(delays)
 funs=c(mean=mean, sd=sd, median=median)
 sapply(funs, function(f) f(delays, na.rm=T))
}
