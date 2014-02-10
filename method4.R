#Package "AirlineDelays" is needed for this method.
#method4 use C code to get delay table then use arrstat function to compute statistics.
#Usage: method4(cores), where cores is the number of help nodes.

method4=function(cores=32) {
 f=sapply(files, list)
 t=getDelayTable_thread(f, ind2-1, cores)
 arrdelay=as.integer(names(t))
 freq=as.integer(t)
 arrstat(arrdelay, freq)
}
