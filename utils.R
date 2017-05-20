# Utilities for the Guardian league table viewer
get.sorted.subject.list <- function(Df, variable){
  
  sorted.subjects <- Df %>% 
    group_by(subject) %>% 
    summarise_(.dots=list(f=interp(~median(var), 
                                   var=as.name(variable)))) %>%
    arrange(f) %>% 
    select(subject) %>% 
    as.data.frame()
  
  as.character(sorted.subjects[['subject']])
  
}

# The following ggplot theme and the ggplot boxplots below 
# are based on code from percept.R in 
# commit c87abf1a4b524780e3ba8bbffa6d7b0267c28e98
# https://github.com/zonination/perceptions 
# Copyright (c) 2016 Zoni Nation
# Distributed according to MIT License
z_theme <- function() {
  # Generate the colors for the chart procedurally with RColorBrewer
  palette <- brewer.pal("Greys", n=9)
  color.background = palette[2]
  color.grid.major = palette[5]
  color.axis.text = palette[7]
  color.axis.title = palette[7]
  color.title = palette[8]
  # Begin construction of chart
  theme_bw(base_size=9) +
    # Set the entire chart region to a light gray color
    theme(panel.background=element_rect(fill=color.background, color=color.background)) +
    theme(plot.background=element_rect(fill=color.background, color=color.background)) +
    theme(panel.border=element_rect(color=color.background)) +
    # Format the grid
    theme(panel.grid.major=element_line(color=color.grid.major,size=.25)) +
    theme(panel.grid.minor=element_blank()) +
    theme(axis.ticks=element_blank()) +
    # Format the legend, but hide by default
    theme(legend.position="none") +
    theme(legend.background = element_rect(fill=color.background)) +
    theme(legend.text = element_text(size=7,color=color.axis.title)) +
    # Set title and axis labels, and format these and tick marks
    theme(plot.title=element_text(color=color.title, size=20, vjust=1.25)) +
    theme(axis.text.x=element_text(size=10,color=color.axis.text)) +
    theme(axis.text.y=element_text(size=10,color=color.axis.text)) +
    theme(axis.title.x=element_text(size=12,color=color.axis.title, vjust=0)) +
    theme(axis.title.y=element_text(size=12,color=color.axis.title, vjust=1.25))
}


boxplot.by.subject <- function(Df, variable, ylab, title, y.min=0, y.max=100, y.step=10){
  
  Df$subject <- factor(Df$subject, 
                       levels=get.sorted.subject.list(Df, variable))
  
  ggplot(Df, aes_string('subject', variable))+
    geom_boxplot(aes(fill=subject),alpha=.5)+
    geom_jitter(aes(color=subject),size=0.5, alpha=.2)+
    coord_flip()+
    guides(fill=FALSE,color=FALSE)+
    xlab("Subject")+
    ylab(ylab)+
    z_theme()+
    scale_y_continuous(breaks=seq(y.min, y.max, y.step))+
    ggtitle(title)
  
}

get.sorted.institution.list <- function(Df, variable){
  
  sorted.institutions <- Df %>% 
    group_by(institution) %>% 
    summarise_(.dots=list(f=interp(~median(var), 
                                   var=as.name(variable)))) %>%
    arrange(f) %>% 
    select(institution) %>% 
    as.data.frame()
  
  as.character(sorted.institutions[['institution']])
  
}

boxplot.by.institution <- function(Df, variable, ylab, title, y.min=0, y.max=100, y.step=10){
  
  Df$institution <- factor(Df$institution, 
                           levels=get.sorted.institution.list(Df, variable))
  
  ggplot(Df, aes_string('institution', variable))+
    geom_boxplot(aes(fill=institution),alpha=.5)+
    geom_jitter(aes(color=institution),size=0.5, alpha=.2)+
    coord_flip()+
    guides(fill=FALSE,color=FALSE)+
    xlab("Institution")+
    ylab(ylab)+
    z_theme()+
    theme(axis.text.y=element_text(size=8))+
    scale_y_continuous(breaks=seq(y.min, y.max, y.step))+
    ggtitle(title)
  
}
