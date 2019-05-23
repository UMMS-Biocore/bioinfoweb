library("DESeq2")
library("ggplot2")
library("RColorBrewer")
library("gplots")


#1. Read the data
file<-" /media/workshop_data/transcriptomics/deseq_data.tsv"
rsem<-read.table(file);
head(rsem)


#2. Read the data with header
rsem<- read.table(file,sep="\t", header=TRUE)


#3. Read the data with row.names
rsem<- read.table(file,sep="\t", header=TRUE, row.names=1,
stringsAsFactors = TRUE)


#4. Create data structure for DESeq Analysis
data <- data.frame(rsem[, c("exper_rep1","exper_rep2","exper_rep3",
"control_rep1","control_rep2","control_rep3")])


#5. Make sure all the cells in the table are integer
cols = c(1:6);
data[,cols] = apply(data[,cols], 2,
function(x) as.numeric(as.integer(x)))
#Make a histogram
hist(log(data$exper_rep1), breaks=100)


#6. Make a scatter plot with the averages of the replicas
avgall<-cbind(rowSums(data[1:3])/3, rowSums(data[4:6])/3)
colnames(avgall)<-c("Treat", "Control")


#7. Make a simple scatter plot
plot(avgall)


#8. Hmm!!! The values are ranging from 0 to 800k. So, let's use log2.
plot(log2(avgall))


#9. Let's change the x and y titles
log2vals <- log2(avgall)
colnames(log2vals)<-c("log2(Treat)", "log2(Control)")
plot(log2vals)


#10. Let's make this pretty using ggplot
library("ggplot2")
gdat<-data.frame(avgall)
ggplot() +
geom_point(data=gdat, aes_string(x="Treat", y="Control"),
colour="black", alpha=6/10, size=3) +
scale_x_log10() +scale_y_log10()



######################################
## LETS START DESeq ANALYSIS
######################################
#
#11. Define conditions for each library
conds <- factor( c("Control","Control", "Control",
"Treat", "Treat","Treat") )
colData = as.data.frame((colnames(data)))
colData<-cbind(colData, conds)
colnames(colData) = c("Control","group")
groups = factor(colData[,2])


#12. Filter out the genes if the # of total reads in all libs below 10.
sumd = apply(X=data,MARGIN=1,FUN=sum)
filtd = subset(data, sumd > 10)


#13. Create DESeq data set using prepared table.
dds = DESeqDataSetFromMatrix(countData=as.matrix(filtd),
colData=colData, design = ~ group)


#14. Run DESeq analysis
dds <- DESeq(dds);


#15. Put the results into variable.
res <- results(dds);


#16. Look for the column descriptions in the results
mcols(res, use.names=TRUE)


#17. select only significant ones
f1<-res[!is.na(res$padj) & !is.na(res$log2FoldChange), ]
res_selected<-f1[(f1$padj<0.01 & abs(f1$log2FoldChange)>1),]


#18. Add a legend for all data
Legend<-"All"
gdat1<-cbind(gdat, Legend)
gdat_selected<-gdat[rownames(res_selected),]


#19. Add a legend for only significant ones
Legend<-"Significant"
gdat_selected1<-cbind(gdat_selected, Legend)


#20. Merge selected and all data
gdat2<-rbind(gdat1, gdat_selected1)


#21. Make ggplot
ggplot() +
geom_point(data=gdat2, aes_string(x="Treat", y="Control", colour="Legend"),
alpha=6/10, size=3) +
scale_colour_manual(values=c("All"="darkgrey","Significant"="red"))+
scale_x_log10() +scale_y_log10()


#22. Make MA plot
gdatMA<-gdat2
gdatMA$Treat=gdatMA$Treat+1
gdatMA$Control=gdatMA$Control+1
g<-gdatMA
colnames(g)<-c("M", "A", "Legend")
g$M<-log2(gdatMA$Treat*gdatMA$Control/2)
g$A<-log2(gdatMA$Treat/gdatMA$Control)
g$M <- scale(g$M, center=TRUE, scale=TRUE);
g$A <- scale(g$A, center=TRUE, scale=TRUE);
ggplot() +
geom_point(data=g, aes_string(x="M", y="A", colour="Legend"),
alpha=6/10, size=3) + ylab("Log2 Fold Change (M)") +
xlab("Log2 mean normalized counts (A)") +
scale_colour_manual(values=c("All"="black","Significant"="red"))+
geom_abline(slope=0, linetype=2)


#23. If you want to save as pdf use the command below
ggsave("~/myplot.pdf")


#24. For MA Plot with a function
plotMA(dds,ylim=c(-2,2),main="DESeq2");


#25. For Volcano Plot
##Highlight genes that have an absolute fold change > 2 and a padj < 0.01
res$threshold = as.factor(abs(res$log2FoldChange) > 1 & res$padj < 0.01)
res$log10padj = -log10(res$padj)
dat<-data.frame(cbind(res$log2FoldChange, res$log10padj, res$threshold))
colnames(dat)<-c("log2FoldChange", "log10padj", "threshold")
##Construct the plot object
ggplot(data=dat, aes_string(x="log2FoldChange", y="log10padj",
colour="threshold")) + geom_point(alpha=0.4, size=1.75) +
theme(legend.position = "none") +
xlim(c(-2.5, 2.5)) + ylim(c(0, 15)) +
xlab("log2 fold change") + ylab("-log10 p-value")


#26. Adding more information to a dataset
## You can select the significant genes from the dataset and add their log2foldChange and padj values to the dataset
calc_cols<-[, c("log2FoldChange", "padj")]
f1<-cbind(data[rownames(calc_cols), ], calc_cols)
f1<-f1[!is.na(res$padj), ]
res_selected<-f1[f1$padj<0.01 & abs(f1$log2FoldChange)>1, ]


#27. For heatmap
ld <- log(filtd[rownames(res_selected),]+0.1,base=2)
cldt <- scale(t(ld), center=TRUE, scale=TRUE);


#a. Euclidean distance
distance<-dist(cldt, method = "euclidean")


#b. Correlation between libraries
cld <- t(cldt)
dissimilarity <- 1 - cor(cld)
distance <- as.dist(dissimilarity)


plot(hclust(distance, method = "complete"),
main="1-cor", xlab="")


heatmap.2(cld, Rowv=TRUE,dendrogram="column",
Colv=TRUE, col=redblue(256),labRow=NA,
density.info="none",trace="none");
