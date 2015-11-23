getwd()g
dir_share = "//home//saratkiran//Desktop//CS6890//pde//pde"
path = "/home/saratkiran/Desktop/CS6890/pde/pde/"
out_dir =  "//home//saratkiran//Desktop//CS6890//output//pde"
setwd(dir_share)
getwd()
filenames <- list.files(path=".",pattern="*.csv")
filenames
count = 0
for(i in filenames){
      i
       filepath <- file.path(path,paste(i))
       file_name = substr(filenames,1,3)
       jdt.code <- read.csv(filepath,header = T, row.names = 1,sep = ";")
       file_name <- jdt.code[ , -which(names(jdt.code) %in% c("majorBugs","criticalBugs","highPriorityBugs","nonTrivialBugs"))]
       jdt.cor = cor(file_name,method = "spearman")
      jdt.cor.bugs = jdt.cor["bugs",]
      print(filenames)
      if (i == "bug-metrics.csv"){
        jdt.sort = sort(jdt.cor.bugs, decreasing = T)[2:3]
      }
      else{
      jdt.sort = sort(jdt.cor.bugs, decreasing = T)[2:6]
      }
      setwd(out_dir)
      save = paste("top_",i,sep ="")
      write.csv(jdt.sort , file = save)
      
      setwd(dir_share)
      
      jdt.names = names(jdt.sort)
      jdt.total = file_name[,jdt.names]
      count = count + 1;
      if (count == 1){
        jdt.final = jdt.total
      }
      else{
        jdt.temp = jdt.final
        jdt.final = cbind(jdt.temp,jdt.total)
      }

}
jdt.final.cor = cor(jdt.final,method = "spearman")
setwd(out_dir)
write.csv(jdt.final.cor , file = "pde.csv")

