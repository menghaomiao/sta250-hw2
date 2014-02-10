#Package "parallel" is needed for this method.
#method3 is an improvement of method2. It can pipe data into R either by the whole file or by block.
#delaytable() is the function to get delay tables. Argument "open" specify how it reads data.
#After getting all the delay tables, method3 use arrstat function to compute statistics.
#Usage: method3(cores, open, blocksize, max), cores is the number of nodes, max is the range of the table.
#If open='r', then shell read data in block and blocksize specifies how many lines it reads.

delaytable=function(i, open, blocksize, max) {
 if (open=='r') {
  t=table(factor(levels=-max:max))
  con=pipe(command1[i], open='r')
  repeat {
   d=scan(con, nmax=blocksize, quiet=T)
   if (length(d)==0) {break}
   nt=table(factor(d, levels=-max:max))
   t=t+nt
  }
 } else {
  con=pipe(command1[i])
  d=scan(con)
  t=table(factor(d, levels=-max:max))
 }
 close(con)
 return(t)
}
method3=function(cores=32, open='', blocksize=10000, max=2880) {
 cl=makeCluster(cores, 'FORK')
 t=clusterApplyLB(cl, 1:81, function(i) delaytable(i, open, blocksize, max))
 stopCluster(cl)
 t=Reduce('+', t)
 freq=as.integer(t)
 arrdelay=as.integer(names(t))[freq!=0]
 freq=freq[freq!=0]
 arrstat(arrdelay, freq)
}
