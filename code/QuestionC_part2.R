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
# total.single.names = c("adsjh","asdsd")
setwd("//home//saratkiran//Desktop//CS6890//output//pde")
path = "/home/saratkiran/Desktop/CS6890/output/pde"
pathname = "//home//saratkiran//Desktop//CS6890//pde//pde"
total_path = "/home/saratkiran/Desktop/CS6890/pde/pde"
filenames <- list.files(path=".",pattern="*.csv")
currentdir = getwd()
setwd("//home//saratkiran//Desktop//CS6890//output")
type_name = paste("pde top All ",pred," model",sep= "")
write(type_name, "test.csv", append=TRUE)

write("", "test.csv", append=TRUE)
setwd(currentdir)
print(filenames)
for(i in filenames){
  filepath <- file.path(path,paste(i))
  file_name = substr(i,1,7)
  print(file_name)
  if(file_name == "top_sin"){
    
    jdt.coders = read.csv(filepath,header = T, row.names = 1,sep = ",")
    print(jdt.coders)
    jdt.namers = row.names(jdt.coders)
    print(jdt.namers)
    top2_sin <- c(jdt.namers[1],jdt.namers[2])
#     total.single.names = c(total.single.names, temp)
    
#     top.names = paste(jdt.namers[1]," + ",jdt.namers[2],sep="")
    total.filenames <-list.files(path = "/home/saratkiran/Desktop/CS6890/pde/pde",pattern = "*.csv")
    for(total in total.filenames){
      if(total == "single-version-ck-oo.csv"){
        total.path <- file.path(total_path,paste(total))
        jdt.file = read.csv(total.path,header = T, row.names = 1, sep = ";")
        jdt.half.single = jdt.file[,c(jdt.namers[1],"bugs")]
        
        jdt.single.frame = jdt.file[,c(jdt.namers[1],jdt.namers[2],"bugs")]
        
        
      }
    }
  }
  if(file_name == "top_bug"){
    
    jdt.coders = read.csv(filepath,header = T, row.names = 1,sep = ",")
    print(jdt.coders)
    jdt.namers = row.names(jdt.coders)
    print(jdt.namers)
    top2_bug<- c(jdt.namers[1],jdt.namers[2])
#     total.single.names = c(total.single.names,temp)
#     top.names = paste(jdt.namers[1]," + ",jdt.namers[2],sep="")
    total.filenames <-list.files(path = "/home/saratkiran/Desktop/CS6890/pde/pde",pattern = "*.csv")
    for(total in total.filenames){
      if(total == "bug-metrics.csv"){
        total.path <- file.path(total_path,paste(total))
        jdt.file = read.csv(total.path,header = T, row.names = 1, sep = ";")
        jdt.half.bug = jdt.file[,c(jdt.namers[1],"bugs")]
        jdt.bug.frame = jdt.file[,c(jdt.namers[1],jdt.namers[2])]
      }
    }
  }
  
  if(file_name == "top_cha"){
    
    jdt.coders = read.csv(filepath,header = T, row.names = 1,sep = ",")
    print(jdt.coders)
    jdt.namers = row.names(jdt.coders)
    print(jdt.namers)
    top2_cha <- c(jdt.namers[1],jdt.namers[2])
#     total.single.names = c(total.single.names,temp)
#     top.names = paste(jdt.namers[1]," + ",jdt.namers[2],sep="")
    
    total.filenames <-list.files(path = "/home/saratkiran/Desktop/CS6890/pde/pde",pattern = "*.csv")
    for(total in total.filenames){
      if(total == "change-metrics.csv"){
        total.path <- file.path(total_path,paste(total))
        jdt.file = read.csv(total.path,header = T, row.names = 1, sep = ";")
        jdt.half.change = jdt.file[,c(jdt.namers[1],"bugs")]
        jdt.change.frame = jdt.file[,c(jdt.namers[1],jdt.namers[2])]
      }
    }
    
  }
}

jdt.total.frame = cbind(jdt.bug.frame,jdt.change.frame,jdt.single.frame)
jdt.half.frame = cbind(jdt.half.bug,jdt.half.change,jdt.half.single)
predic.names = c(top2_bug,top2_cha,top2_sin)

View(predic.names)
what.pred.half = paste("bugs ~ ",predic.names[1]," + ",predic.names[3]," + ",predic.names[5],sep ="")
what.pred.full = paste("bugs ~ ",predic.names[1]," + ",predic.names[2]," + ",predic.names[3]," + ", predic.names[4]," + ",predic.names[5]," + ",predic.names[6],sep ="")

cval.jdt.half = cval(jdt.half.frame,pred,what.pred.half)
cval.jdt.full = cval(jdt.total.frame,pred,what.pred.full)
cval.bind.half = cbind("all files",top.names.half,cval.jdt.half$avg.mae,cval.jdt.half$avg.rcor)
cval.bind.full = cbind("all files",top.names.full,cval.jdt.full$avg.mae,cval.jdt.full$avg.rcor)
currentdir = getwd()
setwd("//home//saratkiran//Desktop//CS6890//output")
 

 write.table(cval.bind.half,"test.csv",append = TRUE,col.names = FALSE)
  write("", "test.csv", append=TRUE)
write.table(cval.bind.full,"test.csv",append = TRUE,col.names = FALSE)
write("", "test.csv", append=TRUE)

 setwd(currentdir)

