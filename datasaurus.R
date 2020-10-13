## Install relevant packages
# Install TidyTuesday and dplyr packages - the latter subsets data.

library(tidytuesdayR)
library(dplyr)
library(ggplot2)

## Get the data
# Read in with tidytuesdayR package. Install from CRAN via: install.packages("tidytuesdayR"). This loads the readme and all the datasets for the week of interest. Either ISO-8601 date or year/week. works!
  
tuesdata <- tidytuesdayR::tt_load('2020-10-13')
tuesdata <- tidytuesdayR::tt_load(2020, week = 42)
datasaurus <- tuesdata$datasaurus

datasaurus

## Subsetting the dataset 
# To see that the statistics are almost the same, use dplyr to examine the sub-datasets

datasaurus %>% 
  group_by(dataset) %>% 
  summarize(
    mean_x    = mean(x),
    mean_y    = mean(y),
    std_dev_x = sd(x),
    std_dev_y = sd(y),
    corr_x_y  = cor(x, y)
  )

## Plotting the data 

# Using multiple facets
ggplot(datasaurus, aes(x=x, y=y))+
  geom_point()+
  facet_wrap(~dataset)+
  theme_void()+
  theme(plot.title=element_text(face="bold"),
        axis.text.x=element_blank(), axis.title.x=element_blank(), axis.ticks.x=element_blank(),
        axis.text.y=element_blank(), axis.title.y=element_blank(),
        strip.text=element_text(size=12), legend.position = "none")

# Violin plots
ggplot(datasaurus, aes(x=x, y=y))+
  geom_violin(aes(fill=dataset))+
  facet_wrap(~dataset, ncol=3)+
  labs(title="Distorted dozen
       ")+
  labs(caption = "Spot the dinosaur?")+
  scale_fill_manual(values=c("mediumblue", "firebrick", "hotpink1","springgreen4", "turquoise", "lightblue2", "snow4", "plum1", "slateblue1", "yellow","mediumpurple", "orange", "tomato2"))+
  theme_void()+
  theme(plot.title=element_text(face="bold"),
        axis.text.x=element_blank(), axis.title.x=element_blank(), axis.ticks.x=element_blank(),
        strip.text.x=element_blank(),
        axis.text.y=element_blank(), axis.title.y=element_blank(), 
        legend.position = "none")

# Change to pink colors
ggplot(datasaurus, aes(x=x, y=y))+
  geom_violin(aes(fill=dataset),alpha = 0.8, color="grey91")+
  facet_wrap(~dataset, ncol=2)+
  labs(title="Distorted dozen", subtitle="Spot the dinosaur?
       ")+
  scale_fill_manual(values=c("plum1", "deeppink2", "hotpink1","springgreen4","lightpink2", "orchid1", "lightpink", "hotpink2", 
                             "palevioletred1", "orchid2","thistle1", "hotpink3", "lightpink"))+
  theme_void()+
  theme(plot.title=element_text(face="bold", hjust = 0.5),
        plot.subtitle=element_text(size = 12, face="italic", hjust = 0.5),
        axis.text.x=element_blank(), axis.title.x=element_blank(), axis.ticks.x=element_blank(),
        strip.text.x=element_blank(),
        axis.text.y=element_blank(), axis.title.y=element_blank(), 
        legend.position = "none")

dino <-ggplot(datasaurus, aes(x=x, y=y))+
  geom_violin(aes(fill=dataset),color="grey91")+
  facet_wrap(~dataset, ncol=2)+
  labs(title="
  Distorted dozen", subtitle="Spot the dinosaur?
       ")+
  scale_fill_manual(values=c("hotpink1", "hotpink1", "hotpink1","springgreen4","hotpink1", "hotpink1", "hotpink1", "hotpink1", 
                             "hotpink1", "hotpink1","hotpink1", "hotpink1", "hotpink1"))+
  theme_void()+
  theme(plot.title=element_text(face="bold", hjust = 0.5),
        plot.subtitle=element_text(size = 12, face="italic", hjust = 0.53),
        axis.text.x=element_blank(), axis.title.x=element_blank(), axis.ticks.x=element_blank(),
        strip.text.x=element_blank(),
        axis.text.y=element_blank(), axis.title.y=element_blank(), 
        legend.position = "none")

# Export as high resolution tiff
tiff("dino2.tiff", width = 600, height = 2000, res=300)
plot(dino)
dev.off()
