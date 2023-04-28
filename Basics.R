a <- 2
b <- -1
c <- -4

(-b+sqrt(b^2-4*a*c))/(2*a)
(-b-sqrt(b^2-4*a*c))/(2*a)

log(1024, base=4)

name <- c("Mandi", "Amy", "Nicole", "Olivia")
distance <- c(0.8, 3.1, 2.8, 4.0) # miles
time <- c(10, 30, 40, 50) # minutes
time <- time/60
speed <- distance/time

murder_rate <- murders$total / murders$population * 100000

murders <- mutate(murders, rate = total/population * 100000, rank = rank(-rate))

mean(na_example, na.rm = TRUE)
sd(na_example, na.rm = TRUE)

ref <- NHANES %>% 
  filter(AgeDecade == " 20-29" & Gender == "female") %>%
  summarize(average=mean(BPSysAve, na.rm=TRUE), standard_deviation=sd(BPSysAve, na.rm=TRUE))

NHANES %>% 
  filter(AgeDecade == " 40-49" & Gender == "male") %>%
  group_by(Race1) %>%
  summarize(average=mean(BPSysAve, na.rm=TRUE), standard_deviation=sd(BPSysAve, na.rm=TRUE)) %>%
  arrange(average)

match(50, heights$height)
heights$sex[1032]
max(heights$height)
sum(!(50:82 %in% heights$height))
heights2 <- heights |> mutate(ht_cm = height * 2.54)
heights2$ht_cm[18]
mean(heights2$ht_cm)
nrow(heights2 |> filter(sex == "Female"))
heights2 |> filter(sex == "Female") |> summarize(avg = mean(ht_cm))

library(dslabs)
data(olive)
head(olive)
plot(olive$palmitoleic, olive$palmitic)
hist(olive$eicosenoic)
boxplot(palmitic~region , data=olive)

library(dslabs)
data(heights)
sum(ifelse(heights$sex == "Female", 1, 2))
mean(ifelse(heights$height > 72, heights$height, 0))
inches_to_ft <- function(x) {
  x/12
}
inches_to_ft(144)
sum(inches_to_ft(heights$height) < 5)

