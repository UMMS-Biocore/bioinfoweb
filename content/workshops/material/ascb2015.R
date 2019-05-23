#Tip: To run any line in RStudio you can use Ctrl+Enter or Command+Enter.
#To use any package in R, we need to load its library first.To run DESeq2 
#you just need to type the following.
library("DESeq2")

source("/mnt/galaxy/galaxy-app/ascb/funcs.R")

#1. Reading the data.
# We already made gene quantifications and merged expected counts into 
# a single table. Here we prepared another table using whole reads 
# (not only using reduced reads) to give you an idea about the complete 
# picture of DESeq analysis.

file <- "/mnt/galaxy/galaxy-app/ascb/data.tsv"

#1. Read the data with row.names. We have the gene names in the 
# first column in this table. When we set row.names=1 It will remove 
# the first column from the data and put them to the row name section.

rsem <- read.table(file,sep="\t", header=TRUE, row.names=1)

#2. Creating the data structure for DESeq Analysis, we need to select 
# the columns that we are going to use in the analysis. Here we are 
# going to use experiment and control data that will be 6 columns. 
# Here in this step make sure to include the columns you want to use in 
# your analysis.
columns <- c("exper_rep1","exper_rep2","exper_rep3",
             "control_rep1","control_rep2","control_rep3")

data <- data.frame(rsem[, columns])

#3. Scatter plots are a key approach to assess differences between conditions. 
# We plot the average expression value (counts or TPMs for example) of 
# two conditions.First calculate the average reads per gene. To find the 
# average we sum experiments per gene and divide it to the number of replicas

# In this case we will divide the sum to 3. We will calculate the average for 
# control libraries too. After that, we are ready to merge  the average values 
# from experiment and control to create a two column  data structure using the 
# cbind function that merges tables.

avgall<-cbind(rowMeans(data[c("exper_rep1","exper_rep2","exper_rep3")]), 
              rowMeans(data[c("control_rep1","control_rep2","control_rep3")]))

# We can also change the column names using colnames function.

colnames(avgall)<-c("Treat", "Control")

#4.There are several packages in R that can be used to 
# generate scatter plots. The same plot can be generated using 
# the ggplot package.

plotScatter(avgall, x="Treat",  y="Control", color="black")

#5. In Eukaryotes only a subset of all genes are expressed in 
# a given cell. Expression is therefore a bimodal distribution, 
# with non-expressed genes having counts that result from experimental 
# and biological noise. It is important to filter out the genes 
# that are not expressed before doing differential gene expression. 

# You can decide which cutoff separates expressed vs non-expressed 
# genes by looking your histogram we created.

# In our case a total sum of 10 counts separates well expressed 
# from non-expressed genes

sumd <- rowSums(data)
hist(log10(sumd), breaks=100)
abline(v=1)

#To make all to all scater plot, use the function below
all2all(data)

######################################
## LETS START DESeq ANALYSIS
######################################
#
#6. The goal of Differential gene expression analysis is to find 
# genes or transcripts whose difference in expression, when accounting 
# for the variance within condition, is higher than expected by chance. 

# The first step is to indicate the condition that each column (experiment) 
# in the table represent. 

# Here we define the correspondence between columns and conditions. 
# Make sure the order of the columns matches to your table.

columns
conds <- factor( c("Control","Control", "Control",
                   "Treat", "Treat","Treat") )

# DESeq will compute the probability that a gene is differentially
# expressed (DE) for ALL genes in the table. It outputs both a
# nominal and a multiple hypothesis corrected p-value (padj).
# Because we are testing DE for over 20,000 genes, we do need to correct
# for multiple hypothesis testing. To find genes that are significantly
# DE, we select the ones has lower padj values and higher fold changes and 
# visualize them on our scatter plot with different  color.
# padj values are corrected p-values which are multiplied by the number
# of comparisons. Here we are going to use 0.01 for padj value
# and > 1 log2foldchange.  (1/2 < foldChange < 2)

de_res <- runDESeq(data, columns, conds,  padj=0.01, log2FoldChange=1, non_expressed_cutoff=10)

overlaid_data <- overlaySig(avgall, de_res$res_selected)

#7. Make ggplot and overlay the significantly DE genes in the scatter plot 
#Option 1. put selected gene names to the plot
text_data<-overlaid_data[c("Fgf21", "Syngr1", "Elf1"),]
text_data<-overlaid_data[rownames(de_res$res_selected[de_res$res_selected$padj < 10e-40,]),]
text_data<-overlaid_data[rownames(de_res$res_detected[de_res$res_detected$log2FoldChange < -2 & de_res$res_detected$padj < 10e-40,]),]
plotOverlaidData(overlaid_data, text_data, x="Treat", y="Control", label="rownames(text_data)")



#8. The Second way to visualize it, we use MA plots.
# For MA Plot there is another builtin function that you can use.
DESeq2::plotMA(de_res$res_detected,ylim=c(-2,2),main="DESeq2");


#9. The third way of visualizing the data is making a Volcano Plot.
# Here on the x axis you have log2foldChange values and y axis you 
# have your -log10 padj values. To see how significant genes are 
# distributed. Highlight genes that have an absolute fold change > 2 
# and a padj < 0.01
volcanoPlot(de_res,  padj=0.01, log2FoldChange=1)

#10. The forth way of visualizing the data that is widely used in this 
# type of analysis is clustering and Heatmaps.
sel_data<-data[rownames(de_res$res_selected),]


# Scaling the value using their mean centers can be good it the data is 
# uniformely distributed in all the samples.
ld <- log2(sel_data+0.1)

#Step1. Scale the data
cldt <- scale(t(ld), center=TRUE, scale=TRUE);

# We can define different distance methods to calculate the distance
# between samples. Here we focus on euclidean distance and correlation
#Step2a. Euclidean distance
distance<-dist(cldt, method = "euclidean")
plot(hclust(distance, method = "complete"),
     main="Euclidean", xlab="")
cld<-t(cldt)

#Step3a. The heatmap
plotHeatmap(method="euclidean", cld)

#Step2b. Correlation as a distance
cld<-t(cldt)
dissimilarity <- 1-cor(cld)
# We define it as distance. This will create a square matrix that
# will include the dissimilarites between samples.
distance <- as.dist(dissimilarity)
# To plot only the cluster you can use the command below
plot(hclust(distance, method = "complete"),
     main="1-cor", xlab="")

#Step3b. The heatmap
plotHeatmap(method="cor", cld)

#Alternative: Use the selected data with normalization and see the difference in the heatmap
norm_data<-getNormalizedMatrix(sel_data, method="TMM") 
ld <- log2(norm_data+0.1)

#Step1. Scale the data
cldt <- scale(t(ld), center=TRUE, scale=TRUE);
cld<-t(cldt)
#Step3a. The heatmap for eaclidean
plotHeatmap(method="euclidean", cld)
#Step3b. The heatmap for correlation
plotHeatmap(method="cor", cld)





