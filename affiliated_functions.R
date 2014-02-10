#Please run this script before implementing method3 and method4!
#arrstat() is a function to give the mean, standard deviation and median given the arrival delay levels and frequencies.

arrstat=function(arrdelay, freq) {
 s=sum(arrdelay*freq)
 sq=sum(arrdelay^2*freq)
 n=sum(freq)
 mu=s/n
 sd=sqrt((sq-s^2/n)/(n-1))
 o=order(arrdelay)
 q=cumsum(freq[o])/n
 if (length(which(q==0.5))>0) {
  pos=which(q==0.5)
  med=(arrdelay[o][pos]+arrdelay[o][pos+1])/2
 } else {
  pos=min(which(q>0.5))
  med=arrdelay[o][pos]
 }
 c(mean=mu, sd=sd, median=med)
}
