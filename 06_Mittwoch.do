*use "D:/Studium/01_Oldenburg/Lehre/Datensaetze/ZA5250_v2-0-0.dta"

df <- data.frame(var1 = ,
                 var2 = c(2,4,7,6))
df
library(ggplot2)
ggplot(df, aes(x = var1, y = var2)) + 
  geom_point(size = 2) + 
  ggthemes::theme_stata() +
  scale_y_continuous(breaks = seq(0,8,2)) +
  scale_x_continuous(breaks = seq(0,8,2)) 

df$mean <- mean(df$var2)
df

ggplot(df, aes(x = var1, y = var2)) + 
  geom_point(size = 3) + 
  ggthemes::theme_stata() +
  scale_y_continuous(breaks = seq(0,8,2)) +
  scale_x_continuous(breaks = seq(0,8,2)) +
  geom_hline(aes(yintercept = mean), color = "grey50", size = .75, linetype = "dashed") +
  geom_label(aes(y = 4, x = 5), label = "mean = 4.75", color = "grey30")

# vohergesagte Werte einzeichnen
ggplot(df, aes(x = var1, y = var2)) + 
  geom_point(size = 3) + 
  ggthemes::theme_stata() +
  scale_y_continuous(breaks = seq(0,8,2)) +
  scale_x_continuous(breaks = seq(0,8,2)) +
  geom_hline(aes(yintercept = mean), color = "grey50", size = .75, linetype = "dashed") +
  geom_point(aes(x = var1, y = mean), color = "darkorange", size = 3) 

df$m_residuen <- df$var2 - df$mean
df
ggplot(df, aes(x = var1, y = var2)) + 
  geom_point(size = 3) + 
  ggthemes::theme_stata() +
  scale_y_continuous(breaks = seq(0,8,2)) +
  scale_x_continuous(breaks = seq(0,8,2)) +
  geom_hline(aes(yintercept = mean), color = "grey50", size = .75, linetype = "dashed") +
  geom_point(aes(x = var1, y = mean), color = "darkorange", size = 3) +
  geom_segment(aes(x = var1, xend = var1, y = var2, yend = mean), 
               color = "red", size = .65, linetype = "dotted") 

df
sum(df$m_residuen)
sum(df$m_residuen[df$m_residuen<0])
sum(df$m_residuen[df$m_residuen>0])

df
df$m_residuen2 <- df$m_residuen^2 
df
sum(df$m_residuen2)

m1 <- lm(var2~ var1, data = df)  

lm(var2~ var1, data = df)  
m1 <- lm(var2~ var1, data = df)  

ggplot(df, aes(x = var1, y = var2)) + geom_point(size = 2) + 
  ggthemes::theme_stata() +
  geom_hline(aes(yintercept = mean), color = "grey50", size = .75, linetype = "dashed") +
  scale_y_continuous(breaks = seq(0,8,2)) +
  scale_x_continuous(breaks = seq(0,8,2)) +
  geom_point(aes(x = var1, y = mean), col = "darkorange", size = 2) +
  geom_segment(aes(x = var1, xend = var1, y = var2, yend = mean), 
               color = "red", size = .65, linetype = "dotted")  +
  geom_smooth(method = "lm", color = "darkblue" , se = FALSE) 

df

m1$fitted.values

m1

df$lm_vorhersagen <- m1$fitted.values
df

ggplot(df, aes(x = var1, y = var2)) + geom_point(size = 3) + ggthemes::theme_stata() +
  scale_y_continuous(breaks = seq(0,8,2)) +
  scale_x_continuous(breaks = seq(0,8,2)) +
  geom_hline(aes(yintercept = mean), color = "grey50", size = .75, linetype = "dashed") +
  geom_point(aes(x = var1, y = mean), col = "darkorange", size = 3) +
  geom_segment(aes(x = var1, xend = var1, y = var2, yend = mean), color = "red", size = .65, linetype = "dotted")  +
  geom_smooth(method = "lm", color = "darkblue" , se = FALSE) +
  geom_point(aes(x = var1, y = lm_vorhersagen), color = "dodgerblue3", size = 3)

df$var2 - df$lm_vorhersagen

m1$residuals

df$lm_residuen <- m1$residuals
df

ggplot(df, aes(x = var1, y = var2)) + geom_point(size = 3) + theme_minimal() +
  geom_hline(aes(yintercept = mean), color = "grey50", size = .75, linetype = "dashed") +
  geom_point(aes(x = var1, y = mean), col = "darkorange", size = 3) +
  geom_segment(aes(x = var1, xend = var1, y = var2, yend = mean), color = "red", size = .65, linetype = "dotted")  +
  geom_smooth(method = "lm", color = "darkblue" , se = FALSE) +
  geom_point(aes(x = var1, y = lm_vorhersagen), color = "dodgerblue3", size = 3) +
  geom_segment(aes(x = var1, xend = var1, y = var2, yend = lm_vorhersagen), color = "dodgerblue3", size = .65, linetype = 1) 

df$lm_residuen2 <- df$lm_residuen^2
df
sum(df$m_residuen2)
sum(df$lm_residuen2)

sum(df$m_residuen2)-sum(df$lm_residuen2)

( sum(df$m_residuen2)-sum(df$lm_residuen2) )/sum(df$m_residuen2)

## df2 <- data.frame(var1 = c(12,10,24,28,23) ,
##                   var2 = c(17,16, 3, 5, 8))

## # Arbeitsverzeichnis in den Ordner mit dem Datensatz setzen:
## setwd("C:/Lehre")
## a16 <- read.csv("allbus2016.csv", sep = ";", header = T) # einlesen

a16$age[a16$age<0] <- NA
a16$inc[a16$inc<0] <- NA

a16 <- na.omit(a16)

a16f <- a16[a16$sex == 2 & a16$work == 1,] # base R
a16f <- filter(a16, sex == 2, work == 1) # dplyr

a16f <- a16f[,c("age","inc")] # base R
a16f <- select(a16f, age, inc) # dplyr

## head(a16f)
## View(a16f)
