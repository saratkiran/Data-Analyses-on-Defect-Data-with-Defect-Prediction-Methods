library(rpart)
library(MASS)
predic = c("lm","rpart","glm.nb")
pred = predic[3]
cval = function (dat, model, predicator, rseed =   0723)
{
  set.seed(rseed)
  fun = match.fun(model)
  mae =  rcor = rep(0,30)
  n= nrow(dat)
  for (i in 1:30)
  {
    test = sample.int(n,n*0.2)
    mod = fun ( predicator, data = dat[-test,] )
    pred = predict (mod,dat[test,])
    actual = dat[test,]$bugs
    mae[i] = mean(abs(pred - actual))
    rcor[i] = cor.test(pred,actual,method = 'spearman')$estimate
  }
  list(avg.mae = mean(mae), avg.rcor = mean(rcor), detail.mae = mae, detail.rcor = rcor)
}

setwd("//home//saratkiran//Desktop//CS6890//output//pde")
path = "/home/saratkiran/Desktop/CS6890/output/pde"
pathname = "//home//saratkiran//Desktop//CS6890//pde//pde"
total_path = "/home/saratkiran/Desktop/CS6890/pde/pde"
filenames <- list.files(path=".",pattern="*.csv")
currentdir = getwd()
setwd("//home//saratkiran//Desktop//CS6890//output")
type_name = paste("pde ",pred," model",sep= "")
write(type_name, "test.csv", append=TRUE)

write("", "test.csv", append=TRUE)
setwd(currentdir)

for(i in filenames){
  filepath <- file.path(path,paste(i))
  file_name = substr(i,1,7)
  print(file_name)
  if(file_name == "top_sin"){
    
    jdt.coders = read.csv(filepath,header = T, row.names = 1,sep = ",")
    print(jdt.coders)
    jdt.namers = row.names(jdt.coders)
    print(jdt.namers)
    
    total.filenames <-list.files(path = "/home/saratkiran/Desktop/CS6890/pde/pde",pattern = "*.csv")
    for(total in total.filenames){
      if(total == "single-version-ck-oo.csv"){
        total.path <- file.path(total_path,paste(total))
        jdt.file = read.csv(total.path,header = T, row.names = 1, sep = ";")
        print(jdt.file)
        for (j in jdt.namers){
          print(j)
          what.pred = paste("bugs ~ ",j,sep ="")
          cval.jdt = cval(jdt.file,pred,what.pred)
          cval.bind = cbind(total,j,cval.jdt$avg.mae,cval.jdt$avg.rcor)
          currentdir = getwd()
          setwd("//home//saratkiran//Desktop//CS6890//output")
          
          csvfile = paste(j,".csv",sep="")
          total.csvfile = paste("pde_",pred,"_",csvfile,sep="")
          write.table(cval.bind,"test.csv",append = TRUE,col.names = FALSE)
          write.csv(cval.jdt,file = total.csvfile)
          setwd(currentdir)
        }
        currentdir = getwd()
        setwd("//home//saratkiran//Desktop//CS6890//output")
        write("", "test.csv", append=TRUE)
        setwd(currentdir)
      }
    }
 }
 if(file_name == "top_bug"){
   
   jdt.coders = read.csv(filepath,header = T, row.names = 1,sep = ",")
   print(jdt.coders)
   jdt.namers = row.names(jdt.coders)
   print(jdt.namers)
   
   total.filenames <-list.files(path = "/home/saratkiran/Desktop/CS6890/pde/pde",pattern = "*.csv")
   for(total in total.filenames){
     if(total == "bug-metrics.csv"){
       total.path <- file.path(total_path,paste(total))
       jdt.file = read.csv(total.path,header = T, row.names = 1, sep = ";")
       for (j in jdt.namers){
         print(j)
         what.pred = paste("bugs ~ ",j,sep ="")
         cval.jdt = cval(jdt.file,pred,what.pred)
         cval.bind = cbind(total,j,cval.jdt$avg.mae,cval.jdt$avg.rcor)
         currentdir = getwd()
         setwd("//home//saratkiran//Desktop//CS6890//output")
         
         csvfile = paste(j,".csv",sep="")
         total.csvfile = paste("pde_",pred,"_",csvfile,sep="")
         write.table(cval.bind,"test.csv",append = TRUE,col.names = FALSE)
         write.csv(cval.jdt,file = total.csvfile)
         setwd(currentdir)
       }
       currentdir = getwd()
       setwd("//home//saratkiran//Desktop//CS6890//output")
       write("", "test.csv", append=TRUE)
       setwd(currentdir)
     }
   }
 }
 
 if(file_name == "top_cha"){
   
   jdt.coders = read.csv(filepath,header = T, row.names = 1,sep = ",")
   print(jdt.coders)
   jdt.namers = row.names(jdt.coders)
   print(jdt.namers)
   
   total.filenames <-list.files(path = "/home/saratkiran/Desktop/CS6890/pde/pde",pattern = "*.csv")
   for(total in total.filenames){
     if(total == "change-metrics.csv"){
       total.path <- file.path(total_path,paste(total))
       jdt.file = read.csv(total.path,header = T, row.names = 1, sep = ";")
       for (j in jdt.namers){
         print(j)
         what.pred = paste("bugs ~ ",j,sep ="")
         cval.jdt = cval(jdt.file,pred,what.pred)
         cval.bind = cbind(total,j,cval.jdt$avg.mae,cval.jdt$avg.rcor)
         currentdir = getwd()
         setwd("//home//saratkiran//Desktop//CS6890//output")
         
         csvfile = paste(j,".csv",sep="")
         total.csvfile = paste("pde_",pred,"_",sep="")
         write.table(cval.bind,"test.csv",append = TRUE,col.names = FALSE)
         write.csv(cval.jdt,file = total.csvfile)
         setwd(currentdir)
       }
       currentdir = getwd()
       setwd("//home//saratkiran//Desktop//CS6890//output")
       write("", "test.csv", append=TRUE)
       setwd(currentdir)
     }
   }
 }
}

