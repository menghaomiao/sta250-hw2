#Package "AirlineDelays" is needed for this method.
#method4 use C code to get delay table then use arrstat function to compute statistics.
#Usage: method4(cores), where cores is the number of help nodes.

method4=function(cores=32) {
 t=data.frame(0, 0)
 cl=makeCluster(cores, 'FORK')
 nt=clusterApplyLB(cl, 1:81, function(i) as.data.frame(as.table(getDelayTable(files[i]))))
 stopCluster(cl)
 for (i in 1:81) {
  t=merge(t, nt[[i]], by.x=names(t)[1], by.y=names(nt[[i]])[1], all=T, sort=F)
  t[is.na(t)]=0
  t[2]=t[2]+t[3]
  t[3]=NULL
 }
 arrdelay=as.integer(t[[1]])
 freq=t[[2]]
 arrstat(arrdelay, freq)
}
