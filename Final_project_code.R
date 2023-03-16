## BIOST 537
## Final Project
## 2023 March

#Importing Libraries
library(survival)
library(flexsurv)
library(survMisc)
library(muhaz)
library(dplyr)

#Importing dataset
setwd("/Users/______/Documents/UW/2023 - Winter Quarter 2/BIOST 537/data")
bmt <- read.csv("bmt.csv")

##------------------------------------------------------------------------------
## Question 1
#Median Survival Time (Days)
s.bmt = with(bmt, Surv(tdfs, deltadfs)) 
sfit.bmt = survfit(s.bmt ~ 1, data=bmt, conf.type = "log-log", conf.int=0.9) 
summary(sfit.bmt)$table

#Figure 1: Kaplan-Meier
plot(sfit.bmt, lwd = 1.5,
     ylab="Disease-Free Survival Probability",
     xlab="Time until relapse, death or end of study (in days)",
     col = "darkgreen")
summary(sfit.bmt, times=730)

#Figure 2: N-A Cum Hazard
plot(sfit.bmt, fun="cumhaz", lwd=1.5,
     xlab="Time until relapse, death or end of study (in days)",
     ylab="Cumulative Hazard",
     col = "darkblue")

##------------------------------------------------------------------------------
## Question 2
#Assessing distribution of continuous variables
hist(bmt$age)
hist(bmt$donorage)
hist(bmt$waittime)

#Patient's sex
table(bmt$male, bmt$disgroup) 
prop.table(table(bmt$male, bmt$disgroup), margin = 2)

table(bmt$male, bmt$fab)
prop.table(table(bmt$male, bmt$fab), margin = 2)

#Patient's CMV
table(bmt$cmv, bmt$disgroup)
prop.table(table(bmt$cmv, bmt$disgroup), margin = 2)

table(bmt$cmv, bmt$fab)
prop.table(table(bmt$cmv, bmt$fab), margin = 2)

#Donor's sex
table(bmt$donormale, bmt$disgroup) 
prop.table(table(bmt$donormale, bmt$disgroup), margin = 2)

table(bmt$donormale, bmt$fab) 
prop.table(table(bmt$donormale, bmt$fab), margin = 2)

#Donor's CMV
table(bmt$donorcmv, bmt$disgroup)
prop.table(table(bmt$donorcmv, bmt$disgroup), margin = 2)

table(bmt$donorcmv, bmt$fab)
prop.table(table(bmt$donorcmv, bmt$fab), margin = 2)

#MTX
table(bmt$mtx, bmt$disgroup)
prop.table(table(bmt$mtx, bmt$disgroup), margin = 2)

table(bmt$mtx, bmt$fab)
prop.table(table(bmt$mtx, bmt$fab), margin = 2)

#Patient's age
bmt %>% filter(fab == "0") %>% summarize(n(), mean(age), sd(age))
bmt %>% filter(fab == "1") %>% summarize(n(), mean(age), sd(age))
bmt %>% filter(disgroup == "1") %>% summarize(n(), mean(age), sd(age))
bmt %>% filter(disgroup == "2") %>% summarize(n(), mean(age), sd(age))
bmt %>% filter(disgroup == "3") %>% summarize(n(), mean(age), sd(age))

#Donor's age
bmt %>% filter(fab == "0") %>% summarize(n(), mean(donorage), sd(donorage))
bmt %>% filter(fab == "1") %>% summarize(n(), mean(donorage), sd(donorage))
bmt %>% filter(disgroup == "1") %>% summarize(n(), mean(donorage), sd(donorage))
bmt %>% filter(disgroup == "2") %>% summarize(n(), mean(donorage), sd(donorage))
bmt %>% filter(disgroup == "3") %>% summarize(n(), mean(donorage), sd(donorage))

#Wait time
bmt %>% filter(fab == "0") %>% summarize(n(), median(waittime), IQR(waittime))
bmt %>% filter(fab == "1") %>% summarize(n(), median(waittime), IQR(waittime))
bmt %>% filter(disgroup == "1") %>% summarize(n(), median(waittime), IQR(waittime))
bmt %>% filter(disgroup == "2") %>% summarize(n(), median(waittime), IQR(waittime))
bmt %>% filter(disgroup == "3") %>% summarize(n(), median(waittime), IQR(waittime))

##------------------------------------------------------------------------------
## Question 3
#Testing Individual Characteristics
#fab
cox.fit.fab = coxph(s.bmt~as.factor(fab), data=bmt) 
summary(cox.fit.fab, conf.int = 0.9)

#disgroup
cox.fit.dis = coxph(s.bmt~as.factor(disgroup), data=bmt)
summary(cox.fit.dis, conf.int = 0.9)

#donormale
cox.fit.dmale = coxph(s.bmt~donormale, data=bmt) 
summary(cox.fit.dmale, conf.int = 0.9)

#donorage
cox.fit.dage = coxph(s.bmt~donorage, data=bmt)
summary(cox.fit.dage, conf.int = 0.9)

#donorcmv
cox.fit.dc = coxph(s.bmt~donorcmv, data=bmt)
summary(cox.fit.dc, conf.int = 0.9)

#male
cox.fit.male = coxph(s.bmt~male, data=bmt) 
summary(cox.fit.male, conf.int = 0.9)

#age
cox.fit.age = coxph(s.bmt~age, data=bmt)
summary(cox.fit.age, conf.int = 0.9)

#cvm
cox.fit.cmv = coxph(s.bmt~cmv, data=bmt)
summary(cox.fit.cmv, conf.int = 0.9)

#waittime
cox.fit.wt = coxph(s.bmt~waittime, data=bmt)
summary(cox.fit.wt, conf.int = 0.9)

#mtx
cox.fit.mtx = coxph(s.bmt~mtx, data=bmt)
summary(cox.fit.mtx, conf.int = 0.9)

#Full model
cox.fit = coxph(s.bmt~as.factor(fab)+as.factor(disgroup)+donormale+donorage+donorcmv+waittime+age+male+cmv+mtx, data=bmt)
summary(cox.fit)

#Testing ANOVA - Individual Characteristics (Testing MTX)
fit1 <- coxph(s.bmt~as.factor(fab) + as.factor(disgroup) + mtx, data=bmt)
fit2 <- coxph(s.bmt~as.factor(fab) + as.factor(disgroup), data=bmt) anova(fit1, fit2)

#Testing ANOVA - All Baseline Characteristics
#Full model
fit3 <- coxph(s.bmt~as.factor(fab)+as.factor(disgroup)+donormale+donorage+donorcmv+wa ittime+age+male+cmv+mtx, data=bmt)

#Removing individual variables
#Removed MTX
fit4 <- coxph(s.bmt~as.factor(fab)+as.factor(disgroup)+donormale+donorage+donorcmv+wa ittime+age+male+cmv, data=bmt)
anova(fit3, fit4)

#Removed MTX; Patient: CMV Status
fit5 <- coxph(s.bmt~as.factor(fab)+as.factor(disgroup)+donormale+donorage+donorcmv+wa
              ittime+age+male, data=bmt)
anova(fit3, fit5)

#Removed MTX; Patient: CMV Status & Sex
fit6 <- coxph(s.bmt~as.factor(fab)+as.factor(disgroup)+donormale+donorage+donorcmv+wa
              ittime+age, data=bmt)
anova(fit3, fit6)

#Removed MTX; Patient: CMV Status, Sex & Age
fit7 <- coxph(s.bmt~as.factor(fab)+as.factor(disgroup)+donormale+donorage+donorcmv,
              data=bmt)
anova(fit3, fit7)

#Removed MTX; Patient: CMV Status, Sex & Age; Donor: CMV Status
fit8 <- coxph(s.bmt~as.factor(fab)+as.factor(disgroup)+donormale+donorage,
              data=bmt)
anova(fit3, fit8)

#Removed MTX; Patient: CMV Status, Sex & Age; Donor: CMV Status, Age
fit9 <- coxph(s.bmt~as.factor(fab)+as.factor(disgroup)+donormale, data=bmt) 
anova(fit3, fit9)

#Removed MTX; Patient: CMV Status, Sex & Age; Donor: CMV Status, Age, Sex
fit10 <- coxph(s.bmt~as.factor(fab)+as.factor(disgroup), data=bmt) 
anova(fit3, fit10)

#Removed MTX; Patient: CMV Status, Sex & Age; Donor: CMV Status, Age & Sex; Disease Group
fit11 <- coxph(s.bmt~as.factor(fab), data=bmt)
anova(fit3, fit11)

#Removed MTX; Patient: CMV Status, Sex & Age; Donor: CMV Status, Age & Sex; Disease Group; Disease Subtype
fit12 <- coxph(s.bmt~1, data=bmt)
anova(fit11, fit12)

##------------------------------------------------------------------------------
## Question 4
#Creating time-varying variable of effect of aGVHD
gvhd_tvc <- tmerge( data1 = bmt, data2 = bmt,
                    id = id,
                    death = event(ts, deltaa),
                    tx.tv = tdc(ta)
)
#Cox Proportional Hazard Model
surv.gvhd <- with(gvhd_tvc, Surv(tstart, tstop, deltas)) mod1 <- coxph(surv.gvhd ~ deltaa, data = gvhd_tvc) 
summary(mod1, conf.int = 0.9)

#Separating by aGVHD indicator
profile1 <- data.frame(deltaa = 0) profile2 <- data.frame(deltaa = 1)

#Figure 3: Kaplan-Meier - Plotting by aGVHD indicator
plot(survfit(mod1, newdata = profile1), col = "red",
     lwd = 1.5,
     conf.int = FALSE,
     xlab = "Follow-up time",
     ylab = "Survival Probability") 
lines(survfit(mod1, newdata = profile2), col = "blue", lwd = 1.5, conf.int = FALSE)

legend("topright",
       legend = c("No aGVHD", "aGVHD"),
       col = c("red", "blue"), lty = rep(1, 2), lwd = rep(2,2),
       bty = "n")

#Creating new time-varying variable
gvhd_rel <- gvhd_tvc <- tmerge(
        data1 = bmt,
        data2 = bmt,
        id = id,
        death = event(tdfs, deltaa),
        tx.tv = tdc(ta)
)

#Cox Proportional Hazard Model using new indicator
surv.rel <- with(gvhd_rel, Surv(tstart, tstop, deltar)) 
mod2 <- coxph(surv.rel ~ deltaa, data = gvhd_rel) 
summary(mod2, conf.int = 0.9)

#Figure 4: Kaplan-Meier - Plotting by aGVHD indicator
plot(survfit(mod2, newdata = profile1), col = "red",
     lwd = 1.5, conf.int = FALSE, xlab = "Follow-up time", ylab = "Risk of Relapse")
lines(survfit(mod2, newdata = profile2),
      col = "blue", lwd = 1.5,
      conf.int = FALSE)
legend("topright",
       legend = c("No aGVHD","aGVHD"),
       col = c("red", "blue"), lty = rep(1, 2), lwd = rep(2,2),
       bty = "n")
##------------------------------------------------------------------------------
## Questin 5
#Creating a new dataset with just patients with aGHVD
bmt5<- bmt %>% subset(deltaa== 1)

#Survival object with new dataset
surv.gvhd1 <- with(bmt5, Surv(tdfs, deltadfs))
modall <- coxph(surv.gvhd1 ~ donormale + donorage + donorcmv + waittime + age + male + cmv +
                mtx + as.factor(fab) + as.factor(disgroup), data = bmt5)
summary(modall, conf.int = 0.9)
##------------------------------------------------------------------------------
## Questin 6
#New survival object to assess time from transplant to dev of aGVHD
meth_surv <- with(bmt, Surv(ta, deltaa))
mod3 <- coxph(meth_surv ~ mtx + tp + disgroup + age + male + cmv
              + donorage + donormale + donorcmv, data = bmt) summary(mod3, conf.int = 0.9)
meth_gvhd <- survfit(meth_surv ~ mtx, data = bmt)

#Figure 5: Kaplan-Meier - Based on hx of methotrexate use
plot(meth_gvhd,
     col = c("red", "blue"),
     xlab = "Time from transplant", ylab = "Probability of aGVHD", lwd = 1.5)
legend("bottomright",
       legend = c("No Methotrexate", "Methotrexate"), col = c("red", "blue"), lty = rep(1, 2),
       lwd = rep(2,2),
       bty = "n")
##------------------------------------------------------------------------------
## Questin 7
#Time-varying variable
recovery_tvc <- tmerge(
        data1 = bmt,
        data2 = bmt,
        id = id,
        death = event(ts, deltap),
        tx.tv = tdc(tp)
)
#Survival object
surv.recovery <- with(recovery_tvc, Surv(tstart, tstop, deltas)) 
mod7_1 <- coxph(surv.recovery ~ deltap, data = recovery_tvc) 
summary(mod7_1, conf.int = 0.9)

#Separating by platelet levels
profile1 <- data.frame(deltap = 0)
profile2 <- data.frame(deltap = 1)

#Figure 6: Kaplan-Meier - Based on platelet levels
plot(survfit(mod7_1, newdata = profile1),
     col = "red", lwd = 1.5,
     conf.int = FALSE,
     xlab = "Follow-up time",
     ylab = "Survival Probability")
lines(survfit(mod7_1, newdata = profile2), col = "blue",
      lwd = 1.5,
      conf.int = FALSE)
legend("topright",
       legend = c("no recovery", "recovery"),
       col = c("red", "blue"), lty = rep(1, 2), lwd = rep(2,2),
       bty = "n")

#Time varying variable
recovery_rel <- tmerge(
        data1 = bmt,
        data2 = bmt,
        id = id,
        death = event(tdfs, deltap),
        tx.tv = tdc(tp))

#Survival Object
surv.rel <- with(recovery_rel, Surv(tstart, tstop, deltar)) 
mod7_2 <- coxph(surv.rel ~ deltap, data = recovery_rel) 
summary(mod7_2, conf.int = 0.9)

# Figure 7: KM
plot(survfit(mod7_2, newdata = profile1),
     col = "red", lwd = 1.5,
     conf.int = FALSE,
     xlab = "Follow-up time",
     ylab = " Risk of Relapse")
lines(survfit(mod7_2, newdata = profile2),
      col = "blue",
      lwd = 1.5,
      conf.int = FALSE)
legend("topright",
       legend = c("no recovery", "recovery"),
       col = c("red", "blue"),
       lty = rep(1, 2),
       lwd = rep(2,2),
       bty = "n")
