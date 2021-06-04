

rm(list=ls())
setwd("C:/Users/e.pishva/Dropbox/Intro to R")

load("miRNAdata.Rdata")

res<-matrix(data=NA, nrow=490, ncol= 4)

for (i in 2:491){
  fit<-lm(dat[,i]~dat$Braak)
  res[i-1,]<-summary(fit)$coefficient[2,]
}


colnames(res)<-c("Estimate","SE","t","P")
rownames(res)<-colnames(dat)[2:491]
res.ordered<-res[order(res[,4]),]


head(res.ordered,2)



library(multiMiR)

targets<-get_multimir(url = NULL, org = "hsa", mirna = c("hsa-miR-212-3p","hsa.miR-132-3p") , target = NULL,
                      disease.drug = NULL, table = "validated", predicted.cutoff = NULL,
                      summary = FALSE, add.link = FALSE, use.tibble = FALSE, limit = NULL,
                      legacy.out = FALSE)

res.mirTar<-data.frame(targets@data)
head(res.mirTar)
dim(res.mirTar)

UniqueGens<-unique(res.mirTar$target_entrez)

library(clusterProfiler)
library(org.Hs.eg.db)



KEGG <- enrichKEGG(gene         = UniqueGens,
                   organism     = 'hsa',
                   pvalueCutoff = 0.05)



head(KEGG, 20)


MF <- enrichGO(gene          = UniqueGens,
               universe      = NULL,
               OrgDb         = org.Hs.eg.db,
               ont           = "MF",
               pAdjustMethod = "bonferroni",
               pvalueCutoff  = 0.01,
               qvalueCutoff  = 0.05,
               readable      = TRUE)
head(MF[,1:5],50)
dim(MF)


BP <- enrichGO(gene          = UniqueGens,
               universe      = NULL,
               OrgDb         = org.Hs.eg.db,
               ont           = "BP",
               pAdjustMethod = "bonferroni",
               pvalueCutoff  = 0.01,
               qvalueCutoff  = 0.05,
               readable      = TRUE)
head(BP[,1:5],50)
dim(BP)


library(enrichplot)
barplot(KEGG, showCategory=20) 


CC <- enrichGO(gene          = UniqueGens,
               universe      = NULL,
               OrgDb         = org.Hs.eg.db,
               ont           = "CC",
               pAdjustMethod = "bonferroni",
               pvalueCutoff  = 0.01,
               qvalueCutoff  = 0.05,
               readable      = TRUE)
head(CC[,1:5],50)
dim(CC)



dotplot(KEGG, showCategory=20) + ggtitle("KEGG")
dotplot(MF, showCategory=20) + ggtitle("MF")
dotplot(BP, showCategory=20) + ggtitle("BP")
dotplot(CC, showCategory=20) + ggtitle("CC")
