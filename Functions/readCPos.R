### read country position


Cpos <- read.csv(file="Data/Position.csv")
Cpos <- Cpos[complete.cases(Cpos),]

### clean country name
Cpos$name <- unlist(lapply(Cpos$name,function(x){ifelse("Myanmar [Burma]"== as.character(x),"Myanmar",as.character(x)) }))
Cpos$name <- unlist(lapply(Cpos$name,function(x){ifelse("Macedonia [FYROM]"== as.character(x),"Macedonia",as.character(x)) }))


