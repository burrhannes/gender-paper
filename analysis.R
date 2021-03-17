#' Analysis Script of Workshop Data attracting girls 
#' to Computer Science
#' 
#' @author: Johannes Burr
#'
#'

csv = read.csv("Form.csv")

# cols = list("time", "group", "age", "lieblingsfach", "parents_jobs", )

# structurize the df into:
#less important
personal_infos = csv[,1:6]
stereotypes = csv[,23:34]
girlsboys = csv[,35:48]

#main variables
df = csv[,7:22]

cols = c("informatik_pre", "informatik_post", "studieren_pre", 
            "studieren_post", "geeignet_pre", "geeignet_post",
            "grund_pre", "grund_post", "compsci_pre", "compsci_post",
         "compsci_stud_pre", "compsci_stud_post", 
         "compsci_geeignet_pre", "compsci_geeignet_post")

colnames(df) = cols


age = personal_infos[,3]

mean(age)
median(age)
table(age)
sqrt(var(age))

# we want to compare pre and post measures to estimate the treatment effect
# naively, we could use t-tests, which require normally distributed data,
# which seems to be given visually, but they also require _numerical_ data
# because the constructs are measured with only one item, they are ordinal
# Let's be correct and use the adequate Wilcoxon rangsum test

# metrisch: R
# ordinal:  1 2 3..6

wilcox.test(df$studieren_pre,df$studieren_post,
              alternative="two.sided",
              paired=TRUE, # paired bc each girl answered twice! => more power
              conf.int=TRUE
              )
# CI = [1.00 ; 2.00] highly signicificant

wilcox.test(df$informatik_pre,df$informatik_post,
            alternative="two.sided",
            paired=TRUE, # paired
            conf.int=TRUE)

# CI [1.50 ; 2.00] # highly significant

wilcox.test(df$geeignet_pre,df$geeignet_post,
            alternative="two.sided",
            paired=TRUE, 
            conf.int=TRUE)

# CI [1.499 ; 2.00] highly significant

wilcox.test(df$compsci_pre,df$compsci_post,
            alternative="two.sided",
            paired=TRUE, 
            conf.int=TRUE)
# CI [2.00; 3.00] # highly significant




wilcox.test(df$compsci_stud_pre,df$compsci_stud_post,
            alternative="two.sided",
            paired=TRUE, 
            conf.int=TRUE)
# CI [2.00; 2.50] # highly significant

wilcox.test(df$compsci_geeignet_pre,df$compsci_geeignet_post,
            alternative="two.sided",
            paired=TRUE, 
            conf.int=TRUE)
# CI [1.50; 2.50] # highly significant

# great news: every measure is significant! The workshop was effective!


#--------------------------------------
#' interesting question: is the effect even stronger on the computer science
#' measure? seems plausible for me, bc the girls have no prior knowledge, ergo
#' no stereotype about this name, so new info should shape it rapidly
#' 

informatik_pre =   df$informatik_pre  + df$studieren_pre + df$geeignet_pre
informatik_post =  df$informatik_post + df$studieren_post + df$geeignet_post
info_delta = informatik_post - informatik_pre

compsci_pre = df$compsci_pre + df$compsci_stud_pre + df$compsci_geeignet_pre
compsci_post = df$compsci_post + df$compsci_stud_post + df$compsci_geeignet_post
comp_delta = compsci_post - compsci_pre

mean(info_delta)
mean(comp_delta)


mean(informatik_pre)
mean(informatik_post)

mean(compsci_pre)
mean(compsci_post)

#vor allem vorher weniger vo

t.test(info_delta,comp_delta,
       mu=0, paired=TRUE, var.equal=FALSE)

# ----------------------------------------------------------------

lieblingsfach = csv[,4]

table(unlist(strsplit(lieblingsfach, ",")))

#' Mathe: 14+4+1+1 = 20
#' Chemie: 4+1+2 = 7
#' Bio: 3
#' Physik: 7
#' Informatik: 6 (vielleicht danach?)
#' Sprachen: 12
#' Sport 2
#' Kunst 3
#' 


# -----------------------------------------------
# inspecting the stereotypes questions regarding an informatics job

# mirros the values of a scale
change_scale <- function(x){

    if (x==1){ x<- 6  }
    else if (x==2){ x<- 5  }
    else if (x==3){ x<- 4  }
    else if (x==4){ x<- 3  }
    else if (x==5){ x<- 2  }
    else if (x==6){ x<- 1  }
    
    else{print("unexpected values")}

    return(x)
}

# inverting the scale of "Informatiker arbeiten mit Menschen"
# because it is the only positively framed question
people_pre = sapply(stereotypes[,7], change_scale)
people_post = sapply(stereotypes[,8], change_scale)

stereotypes[,7] = people_pre
stereotypes[,8] = people_post

# attention! altered data!
# now higher scores correspond to a more negative view of the 
# job of an informatics person

# seperating pre and post measures

stereotype_pre = matrix(NA,nrow=42,ncol=6)
stereotype_post = matrix(NA,nrow=42,ncol=6)
k = 1
j = 1
for (i in 1:12){
  if (i%%2 != 0){
    stereotype_pre[,k] = stereotypes[,i]
    k = k +1
  }
  else{
    stereotype_post[,j] = stereotypes[,i]
    j = j+1
  }
  
}

pre = rowMeans(stereotype_pre)
post = rowMeans(stereotype_post)

t.test(pre,post,
       mu=0, paired=TRUE,conf.level = 0.95)

# significant => stereotypes were broken


