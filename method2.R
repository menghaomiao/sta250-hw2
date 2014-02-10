#Package "parallel" is needed for this method.
#method2 is to use shell to pipe data into R then use R to compute some statistics.
#Usage: method2(cores), where cores specifies the number of help nodes.

method2=function(cores=32) {
 delays=mclapply(1:81, function(i) {
                  con=pipe(command1[i]); on.exit(close(con)); scan(con)
                 }, mc.cores=cores, mc.preschedule=F)
 delays=unlist(delays)
 funs=c(mean=mean, sd=sd, median=median)
 sapply(funs, function(f) f(delays, na.rm=T))
}
