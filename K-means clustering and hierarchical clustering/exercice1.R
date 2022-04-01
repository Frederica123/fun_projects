library(tree)

###########
tahoe<-read.csv("Tahoe_Healthcare_Data.csv")
tree_tahoe<-tree(readmit30 ~ . , data = tahoe, split = "deviance",minsize=4,mindev=1e-3)
text(tree_tahoe,pretty=0)
tree_tahoe

#############
cv.tree_tahoe<-cv.tree(tree_tahoe, FUN = prune.tree, K=7)
plot(cv.tree_tahoe)
prune.cv.tree_tahoe = prune.tree(tree_tahoe, best=5)
plot(prune.cv.tree_tahoe)
text(prune.cv.tree_tahoe,pretty=0)
prune.cv.tree_tahoe

#############

# patients without caretacker = patients with comobity score < 121.5 and serverity.score < 31.5

percentage.withoutCareTacker = sum(tahoe$comorbidity.score < 121.5 & tahoe$severity.score < 31.5, na.rm=TRUE)/nrow(tahoe)
percentage.withCareTacker = 1 - percentage.withoutCareTacker

##################

# demographic parity - P(C(X,A) = 1 |A = 1) = P(C(X,A) = 1 |A = 0)
number.females = sum(tahoe$female==1)
number.non_females = sum(tahoe$female==0)

number.females.withCareTacker = sum(predict(prune.cv.tree_tahoe,newdata =tahoe[tahoe$female==1,])>0.15)
number.non_females.withCareTacker = sum(predict(prune.cv.tree_tahoe,newdata =tahoe[tahoe$female==0,])>0.15)

p1 = number.females.withCareTacker / number.females
p0 = number.non_females.withCareTacker / number.non_females

# unawareness - P(C(X, A) = 1) = P(C(X) = 1)

tahoe2 <- tahoe
tahoe2$female <- c(rep(0, nrow(tahoe)))

number.withCareTacker.X_A = sum(predict(prune.cv.tree_tahoe,newdata =tahoe)>0.15)
number.withCareTacker.X = sum(predict(prune.cv.tree_tahoe,newdata = tahoe2)>0.15)


p.XA = number.withCareTacker.X_A / nrow(tahoe)
p.X = number.withCareTacker.X / nrow(tahoe)


