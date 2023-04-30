############################################################################

# restart the R session (Menu 'Session' - 'Restart R')

# read in data

load("data_survey_edit.rdata")

############################################################################

# stratified summary statistics / plots

by(dat$age, dat$sex, summary)
by(dat$age, dat$sex, mean)
by(dat$age, dat$sex, sd)

# by() combined with barplot() (PSS = Perceived Stress Scale)

by(dat$pss, dat$marital, mean)

by(dat$pss, dat$marital, mean, na.rm=TRUE)

barplot(by(dat$pss, dat$marital, mean, na.rm=TRUE),
        xlab="Marital Status", ylab="Mean PSS")

# horizontal

par(mar=c(5,9,4,2))

barplot(by(dat$pss, dat$marital, mean, na.rm=TRUE),
        xlab="Mean PSS", horiz=TRUE, las=1)

dev.off()

# if you want to add error bars to such a barplot, see here:
# https://www.r-graph-gallery.com/4-barplot-with-error-bar
# but also read: https://www.data-to-viz.com/caveat/error_bar.html
# barplots with error bars are usually not a good visualization technique

############################################################################

# boxplots
# https://en.wikipedia.org/wiki/Box_plot

boxplot(dat$pss ~ dat$marital)

boxplot(pss ~ marital, data=dat)

boxplot(pss ~ marital, data=dat, xlab="Marital Status", ylab="PSS", pch=19)

boxplot(pss ~ marital, data=dat, xlab="Marital Status", ylab="PSS", pch=19, boxwex=0.6)

# 'boxwex' can be used to adjust the width of the boxes

# horizontal boxplot

par(mar=c(5,9,4,2))

boxplot(pss ~ marital, data=dat,
        xlab="PSS", ylab="", pch=19, horizontal=TRUE, las=1,
        main="Perceived Stress by Marital Status", boxwex=0.6)

# something more colorful

boxplot(pss ~ marital, data=dat, col=rainbow(8),
        xlab="PSS", ylab="", pch=19, horizontal=TRUE, las=1,
        main="Perceived Stress by Marital Status", boxwex=0.6)

dev.off()

############################################################################

# stripchart (also called 'dot plot')
# https://en.wikipedia.org/wiki/Dot_plot_(statistics)

par(mar=c(5,9,4,2))

stripchart(pss ~ marital, data=dat, las=1, method="jitter", jitter=0.2,
           pch=19, cex=0.5, xlab="Perceived Stress Scale")

# combine boxplot with stripchart

boxplot(pss ~ marital, data=dat, col=rainbow(8,alpha=0.2),
        xlab="PSS", ylab="", pch=19, horizontal=TRUE, las=1,
        main="Perceived Stress by Marital Status", boxwex=0.6, range=0)

stripchart(pss ~ marital, data=dat, las=1, method="jitter", jitter=0.2,
           pch=19, cex=0.5, add=TRUE, col=rainbow(8))

dev.off()

############################################################################

# violin plots
# https://en.wikipedia.org/wiki/Violin_plot

# install (if necessary) the 'vioplot' package and load it

if (!suppressWarnings(require(vioplot))) install.packages("vioplot")

library(vioplot)

# violin plots

par(mar=c(5,9,4,2))

vioplot(pss ~ marital, data=dat, horizontal=TRUE, las=1)

vioplot(pss ~ marital, data=dat, horizontal=TRUE, las=1, ylab="")

vioplot(pss ~ marital, data=dat, horizontal=TRUE, las=1,
        col=rainbow(8,alpha=0.2), ylab="")

stripchart(pss ~ marital, data=dat, las=1, method="jitter", jitter=0.2,
           pch=19, cex=0.5, xlab="Perceived Stress Scale", add=TRUE,
           col=rainbow(8))

dev.off()

############################################################################

# beeswarm plots

# install (if necessary) the 'beeswarm' package and load it

if (!suppressWarnings(require(beeswarm))) install.packages("beeswarm")

library(beeswarm)

# beeswarm

par(mar=c(5,9,4,2))

beeswarm(pss ~ marital, data=dat, horizontal=TRUE, las=1,
         xlab="Positive Affect", ylab="")

beeswarm(pss ~ marital, data=dat, horizontal=TRUE, las=1,
         xlab="Positive Affect", ylab="", pch=19, col=rainbow(8))

# combine boxplot with beeswarm

boxplot(pss ~ marital, data=dat, col=rainbow(8,alpha=0.2),
        xlab="PSS", ylab="", pch=19, horizontal=TRUE, las=1,
        main="Perceived Stress by Marital Status", boxwex=0.6, range=0)

beeswarm(pss ~ marital, data=dat, horizontal=TRUE, add=TRUE,
         pch=19, col=rainbow(8), cex=0.5)

dev.off()

############################################################################

# how to control what is shown on the x- and/or y-axis

plot(NA, xlab="Stress", ylab="Positive Affect",
     xlim=c(10,50), ylim=c(10,50), xaxt="n")

# xaxt="n" means: do not add the axis tick marks and numbers
# then we add the axis 'manually' (side=1 means: at the bottom)

axis(side=1, at=c(10,30,50))

# you can also change what text is shown at the tick marks

plot(NA, xlab="Stress", ylab="Positive Affect",
     xlim=c(10,50), ylim=c(10,50), xaxt="n")

axis(side=1, at=c(10,30,50), label=c("Low","Medium","High"))

# use yaxt="n" and axis(side=2, ...) to do the same for the y-axis

# change the type of box that is drawn around a plot

plot(NA, xlab="Stress", ylab="Positive Affect",
     xlim=c(10,50), ylim=c(10,50), bty="l")

plot(NA, xlab="Stress", ylab="Positive Affect",
     xlim=c(10,50), ylim=c(10,50), bty="n")

############################################################################
