use "https://github.com/filius23/Stata_Skript/raw/master/regression_bsp.dta", clear
list
reg var2 var1
* Scatter mit Regressionsgerade
graph twoway (scatter var2 var1) (lfit var2 var1)

* mittelwert berechnen
egen mean_var2 = mean(var2)
list


----echo=F---------------------------------------------------------------------------------------------------------------------------------------
df$mean_var2 <- mean(df$var2)
df


---- out.width = "80%",fig.height= 4.5, echo=F, fig.align="center"-------------------------------------------------------------------------------
ggplot(df, aes(x = var1, y = var2)) + 
  geom_point(size = 3) + 
  ggthemes::theme_stata() +
  scale_y_continuous(breaks = seq(0,8,2)) +
  scale_x_continuous(breaks = seq(0,8,2)) +
  geom_hline(aes(yintercept = mean_var2), color = "grey50", size = .75, linetype = "dashed") +
  geom_label(aes(y = 4, x = 5), label = "mean = 4.75", color = "grey30")


---- out.width = "80%",fig.height= 4.5, echo=F, fig.align="center"-------------------------------------------------------------------------------
ggplot(df, aes(x = var1, y = var2)) + 
  geom_point(size = 3) + 
  ggthemes::theme_stata() +
  scale_y_continuous(breaks = seq(0,8,2)) +
  scale_x_continuous(breaks = seq(0,8,2)) +
  geom_hline(aes(yintercept = mean_var2), color = "grey50", size = .75, linetype = "dashed") +
  geom_point(aes(x = var1, y = mean_var2), color = "darkorange", size = 3) 


gen m_abw = var2 - mean_var2

list


---- echo = F------------------------------------------------------------------------------------------------------------------------------------
df$m_abw <- df$var2 - df$mean
df


---- out.width = "80%",fig.height= 4.5, echo=F, fig.align="center"-------------------------------------------------------------------------------
ggplot(df, aes(x = var1, y = var2)) + 
  geom_point(size = 3) + 
  ggthemes::theme_stata() +
  scale_y_continuous(breaks = seq(0,8,2)) +
  scale_x_continuous(breaks = seq(0,8,2)) +
  geom_hline(aes(yintercept = mean_var2), color = "grey50", size = .75, linetype = "dashed") +
  geom_point(aes(x = var1, y = mean_var2), color = "darkorange", size = 3) +
  geom_segment(aes(x = var1, xend = var1, y = var2, yend = mean_var2), 
               color = "red", size = .65, linetype = "dotted") 


---- echo =F-------------------------------------------------------------------------------------------------------------------------------------
df


tabstat m_abw, s(sum)


gen m_abw2 = m_abw^2

tabstat m_abw2, s(sum)

---- echo = F------------------------------------------------------------------------------------------------------------------------------------
df$m_abw2 <- df$m_abw^2 
df


dis 14.75/4


---- echo = F------------------------------------------------------------------------------------------------------------------------------------
m1 <- lm(var2~ var1, data = df)  


reg var2 var1


---- out.width = "80%",fig.height= 4.5, echo=T, fig.align="center" , echo = F,warning=F,message=F------------------------------------------------
ggplot(df, aes(x = var1, y = var2)) + 
  geom_point(size = 2) + 
  ggthemes::theme_stata() +
  geom_hline(aes(yintercept = mean_var2), color = "grey50", size = .75, linetype = "dashed") +
  scale_y_continuous(breaks = seq(0,8,2)) +
  scale_x_continuous(breaks = seq(0,8,2)) +
  geom_hline(aes(yintercept = mean_var2), color = "grey50", size = .75, linetype = "dashed") +
  geom_point(aes(x = var1, y = mean_var2), color = "darkorange", size = 3) +
  geom_segment(aes(x = var1, xend = var1, y = var2, yend = mean_var2), 
               color = "red", size = .65, linetype = "dotted") +
  geom_smooth(method = "lm", color = "darkblue" , se = FALSE) 


reg var2 var1, noheader


gen reg_vohers = 2.1351 + 0.5811 * var1


predict reg_vorhersagen, xb


---- echo=F--------------------------------------------------------------------------------------------------------------------------------------
df$reg_vorhersagen <- m1$fitted.values
df


---- fig.height=3, fig.width=3, echo=T, fig.align="center" , echo = F,warning=F,message=F--------------------------------------------------------
ggplot(df, aes(x = var1, y = var2)) + geom_point(size = 3) + ggthemes::theme_stata() +
  scale_y_continuous(breaks = seq(0,8,2)) +
  scale_x_continuous(breaks = seq(0,8,2)) +
  geom_hline(aes(yintercept = mean_var2), color = "grey50", size = .75, linetype = "dashed") +
  geom_point(aes(x = var1, y = mean_var2), col = "darkorange", size = 3) +
  geom_segment(aes(x = var1, xend = var1, y = var2, yend = mean_var2), color = "red", size = .65, linetype = "dotted")  +
  geom_smooth(method = "lm", color = "darkblue" , se = FALSE) +
  geom_point(aes(x = var1, y = reg_vorhersagen), color = "dodgerblue3", size = 3)


gen res = var2 - reg_vorhersagen


reg var2 var1 // zunächst nochmal die regression laufen lassen

predict p_res , residuals

list

---- echo=F--------------------------------------------------------------------------------------------------------------------------------------
df$res <- m1$residuals
df$p_res <- m1$residuals
df
df$p_res <- NULL


---- fig.height=2.75, fig.width=2.75, echo=F, fig.align="center" , eval = T, message=F-----------------------------------------------------------
ggplot(df, aes(x = var1, y = var2)) + geom_point(size = 3) + ggthemes::theme_stata() +
  geom_hline(aes(yintercept = mean_var2), color = "grey50", size = .75, linetype = "dashed") +
  geom_point(aes(x = var1, y = mean_var2), col = "darkorange", size = 3) +
  geom_segment(aes(x = var1, xend = var1, y = var2, yend = mean_var2), color = "red", size = .65, linetype = "dotted")  +
  geom_smooth(method = "lm", color = "darkblue" , se = FALSE) +
  geom_point(aes(x = var1, y = reg_vorhersagen), color = "dodgerblue3", size = 3) +
  geom_segment(aes(x = var1, xend = var1, y = var2, yend = reg_vorhersagen), color = "dodgerblue3", size = .65, linetype = 1) 


gen res2 = res^2

list


---- echo = F------------------------------------------------------------------------------------------------------------------------------------
df$res2 <- df$res^2


---- echo = F------------------------------------------------------------------------------------------------------------------------------------
df


dis 7.5625+0.5625+5.0625+1.5625 // abw2 aus Mittelwertsregel


dis 0.5129657+0.4937911+0.6356830+0.6143170 // res2 aus regressionsmodell


dis 14.75 -  2.256757


dis (14.75 -  2.256757) / 14.75


reg var2 var1

