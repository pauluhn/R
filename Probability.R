cyan <- 3
magenta <- 5
yellow <- 7

p <- cyan / (cyan + magenta + yellow)
p_1 <- cyan / (cyan + magenta + yellow)
p_2 <- (magenta + yellow) / (cyan - 1 + magenta + yellow)
p_2 <- 1 - p_1 # with replacement





compute_prob <- function(n, B = 10000) {
  same_day <- replicate(B, {
    bdays <- sample(1:365, n, replace = TRUE)
    any(duplicated(bdays))
  })
  mean(same_day)
}
exact_prob <- function(n){
  prob_unique <- seq(365, 365-n+1)/365   # vector of fractions for mult. rule
  1 - prod(prob_unique)    # calculate prob of no shared birthdays and subtract from 1
}
n <- seq(1, 60)
# element-wise application of compute_prob to n
prob <- sapply(n, compute_prob)
# applying function element-wise to vector of n values
eprob <- sapply(n, exact_prob)
# plotting Monte Carlo results and exact probabilities on same graph
plot(n, prob)    # plot Monte Carlo results
lines(n, eprob, col = "red")    # add line for exact prob





# This line of example code simulates four independent random games where the Celtics either lose or win. Copy this example code to use within the `replicate` function.
simulated_games <- sample(c("lose","win"), 4, replace = TRUE, prob = c(0.6, 0.4))

# The variable 'B' specifies the number of times we want the simulation to run. Let's run the Monte Carlo simulation 10,000 times.
B <- 10000

# Use the `set.seed` function to make sure your answer matches the expected result after random sampling.
set.seed(1)

# Create an object called `celtic_wins` that replicates two steps for B iterations: (1) generating a random four-game series `simulated_games` using the example code, then (2) determining whether the simulated series contains at least one win for the Celtics.
celtic_wins <- replicate(B, {
  simulated_games <- sample(c("lose","win"), 4, replace = TRUE, prob = c(0.6, 0.4))
  any(simulated_games == "win")
})

# Calculate the frequency out of B iterations that the Celtics won at least one game. Print your answer to the console.
mean(celtic_wins)







B <- 10000
stick <- replicate(B, {
  doors <- as.character(1:3)
  prize <- sample(c("car","goat","goat"))    # puts prizes in random order
  prize_door <- doors[prize == "car"]    # note which door has prize
  my_pick  <- sample(doors, 1)    # note which door is chosen
  show <- sample(doors[!doors %in% c(my_pick, prize_door)],1)    # open door with no prize that isn't chosen
  stick <- my_pick    # stick with original door
  stick == prize_door    # test whether the original door has the prize
})
mean(stick)    # probability of choosing prize door when sticking

switch <- replicate(B, {
  doors <- as.character(1:3)
  prize <- sample(c("car","goat","goat"))    # puts prizes in random order
  prize_door <- doors[prize == "car"]    # note which door has prize
  my_pick  <- sample(doors, 1)    # note which door is chosen first
  show <- sample(doors[!doors %in% c(my_pick, prize_door)], 1)    # open door with no prize that isn't chosen
  switch <- doors[!doors%in%c(my_pick, show)]    # switch to the door that wasn't chosen first or opened
  switch == prize_door    # test whether the switched door has the prize
})
mean(switch)    # probability of choosing prize door when switching






# Assign a variable 'n' as the number of remaining games.
n <- 6
# Assign a variable `outcomes` as a vector of possible game outcomes, where 0 indicates a loss and 1 indicates a win for the Cavs.
outcomes <- c(0, 1) # for Cavs
# Assign a variable `l` to a list of all possible outcomes in all remaining games. Use the `rep` function on `list(outcomes)` to create list of length `n`.
l <- rep(list(outcomes), length.out=n)
# Create a data frame named 'possibilities' that contains all combinations of possible outcomes for the remaining games.
possibilities <- expand.grid(l)
# Create a vector named 'results' that indicates whether each row in the data frame 'possibilities' contains enough wins for the Cavs to win the series.
results <- rowSums(possibilities) >= 4
# Calculate the proportion of 'results' in which the Cavs win the series. Print the outcome to the console.
mean(results)

# The variable `B` specifies the number of times we want the simulation to run. Let's run the Monte Carlo simulation 10,000 times.
B <- 10000
# Use the `set.seed` function to make sure your answer matches the expected result after random sampling.
set.seed(1)
# Create an object called `results` that replicates for `B` iterations a simulated series and determines whether that series contains at least four wins for the Cavs.
results <- replicate(B, {
  sum(sample(c(0, 1), 6, replace=TRUE)) >= 4
})
# Calculate the frequency out of `B` iterations that the Cavs won at least four games in the remainder of the series. Print your answer to the console.
mean(results)

# Let's assign the variable 'p' as the vector of probabilities that team A will win.
p <- seq(0.5, 0.95, 0.025)
# Given a value 'p', the probability of winning the series for the underdog team B can be computed with the following function based on a Monte Carlo simulation:
prob_win <- function(p){
  B <- 10000
  result <- replicate(B, {
    b_win <- sample(c(1,0), 7, replace = TRUE, prob = c(1-p, p))
    sum(b_win)>=4
  })
  mean(result)
}
# Apply the 'prob_win' function across the vector of probabilities that team A will win to determine the probability that team B will win. Call this object 'Pr'.
Pr <- sapply(p, prob_win)
# Plot the probability 'p' on the x-axis and 'Pr' on the y-axis.
plot(p, Pr)

# Given a value 'p', the probability of winning the series for the underdog team B can be computed with the following function based on a Monte Carlo simulation:
prob_win <- function(N, p=0.75){
  B <- 10000
  result <- replicate(B, {
    b_win <- sample(c(1,0), N, replace = TRUE, prob = c(1-p, p))
    sum(b_win)>=(N+1)/2
  })
  mean(result)
}
# Assign the variable 'N' as the vector of series lengths. Use only odd numbers ranging from 1 to 25 games.
N <- seq(1, 25, 2)
# Apply the 'prob_win' function across the vector of series lengths to determine the probability that team B will win. Call this object `Pr`.
Pr <- sapply(N, prob_win)
# Plot the number of games in the series 'N' on the x-axis and 'Pr' on the y-axis.
plot(N, Pr)







nrow(permutations(8, 3))
nrow(permutations(3, 3))
j <- permutations(8, 3)
sum(rowSums(j) == 6) / 336
set.seed(1)
results <- replicate(10000, {
  runners <- c("Jamaica", "Jamaica", "Jamaica", "USA", "Ecuador", "Netherlands", "France", "South Africa")
  medalists <- sample(runners, 3)
  medalists[1] == "Jamaica" & medalists[2] == "Jamaica" & medalists[3] == "Jamaica"
})
mean(results)








6*nrow(combinations(6, 2))*2
6*nrow(combinations(6, 2))*3
6*nrow(combinations(6, 3))*3
f <- function(n) {
  n*nrow(combinations(6, 2))*3
}
sapply(1:12, f)
f <- function(n) {
  6*nrow(combinations(n, 2))*3
}
sapply(2:12, f)







data("esoph")
library(tidyverse)
nrow(esoph)
all_cases <- sum(esoph$ncases)
all_controls <- sum(esoph$ncontrols)
a <- esoph |> filter(alcgp == "120+")
a <- esoph |> filter(alcgp == "0-39g/day")
sum(a$ncases) / (sum(a$ncases) + sum(a$ncontrols))
a <- esoph |> filter(ncases > 0)
b <- a |>  filter(tobgp != "0-9g/day")
sum(b$ncases) / sum(a$ncases)
a <- esoph |> filter(ncontrols > 0)
b <- a |>  filter(tobgp != "0-9g/day")
sum(b$ncontrols) / sum(a$ncontrols)
a <- esoph |> filter(alcgp == "120+")
a <- esoph |> filter(tobgp == "30+")
a <- esoph |> filter(alcgp == "120+" & tobgp == "30+")
a <- esoph |> filter(alcgp == "120+" | tobgp == "30+")
sum(a$ncases) / all_cases
sum(a$ncontrols) / all_controls
(sum(a$ncases) / all_cases) / (sum(a$ncontrols) / all_controls)









female_avg <- 64
female_sd <- 3
pnorm(5*12, female_avg, female_sd)
1-pnorm(6*12, female_avg, female_sd)
pnorm(67, female_avg, female_sd)-pnorm(61, female_avg, female_sd)
female_avg <- 64*2.54
female_sd <- 3*2.54
pnorm(67*2.54, female_avg, female_sd)-pnorm(61*2.54, female_avg, female_sd)
taller <- female_avg+female_sd
shorter <- female_avg-female_sd
pnorm(taller, female_avg, female_sd)-pnorm(shorter, female_avg, female_sd)
male_avg <- 69
male_sd <- 3
qnorm(.99, male_avg, male_sd)






B <- 1000
set.seed(1)
highestIQ <- replicate(B, {
  iqs <- rnorm(10000, 100, 15)
  max(iqs)
})
hist(highestIQ)





# 1-36
set.seed(16)
act_scores <- rnorm(10000, 20.9, 5.7)
mean(act_scores)
sd(act_scores)
sum(act_scores >= 36)
sum(act_scores >= 30)/10000
sum(act_scores <= 10)/10000
#act_scores <- (act_scores - 20.9)/5.7
1-pnorm(2)
2*5.7+20.9
qnorm(.975, 20.9, 5.7)            
cdf <- function(n) {
  pnorm(n, 20.9, 5.7)
}
score <- 1:36
p <- sapply(score, cdf)               
data.frame(score=score, p=p)               
qnorm(.95, 20.9, 5.7)               
p <- seq(0.01, 0.99, 0.01)               
sample_quantiles <- quantile(act_scores, p)               
theoretical_quantiles <- qnorm(p, 20.9, 5.7)              
qqplot(theoretical_quantiles, sample_quantiles)




n <- 1000    # number of roulette players
B <- 10000    # number of Monte Carlo experiments
S <- replicate(B, {
  X <- sample(c(-1,1), n, replace = TRUE, prob = c(9/19, 10/19))    # simulate 1000 spins
  sum(X)    # determine total profit
})
mean(S < 0)    # probability of the casino losing money
library(tidyverse)
s <- seq(min(S), max(S), length = 100)    # sequence of 100 values across range of S
normal_density <- data.frame(s = s, f = dnorm(s, mean(S), sd(S))) # generate normal density for S
data.frame (S = S) %>%    # make data frame of S for histogram
  ggplot(aes(S, ..density..)) +
  geom_histogram(color = "black", binwidth = 10) +
  ylab("Probability") +
  geom_line(data = normal_density, mapping = aes(s, f), color = "blue")






set.seed(1)
green <- 2
black <- 18
red <- 18
p_green <- green / (green + black + red)
p_not_green <- 1 - p_green
a <- 17
b <- -1
X <- sample(c(a,b), 1, prob=c(p_green,p_not_green))
E <- a*p_green + b*p_not_green
SE <- abs(b-a)*sqrt(p_green*p_not_green)
n <- 1000
X <- sample(c(a,b), n, replace=TRUE, prob=c(p_green,p_not_green))
S <- sum(X)
E <- n*(a*p_green + b*p_not_green)
SE <- sqrt(n)*(abs(b-a)*sqrt(p_green*p_not_green))

  





p_green <- 2 / 38
p_not_green <- 1-p_green
n <- 100
avg <- n * (17*p_green + -1*p_not_green)
se <- sqrt(n) * (17 - -1)*sqrt(p_green*p_not_green)
1-pnorm(0, avg, se)
B <- 10000
set.seed(1)
S <- replicate(B, {
  winnings <- sample(c(17,-1), n, replace=TRUE, prob=c(p_green,p_not_green))
  sum(winnings)
})
mean(S)
sd(S)
mean(S>0)
n <- 10000
X <- sample(c(17,-1), n, replace=TRUE, prob=c(p_green,p_not_green))
Y <- mean(X)
avg <- 17*p_green + -1*p_not_green
se <- 1/sqrt(n) * (17 - -1)*sqrt(p_green*p_not_green)
1-pnorm(0, avg, se)
S <- replicate(B, {
  winnings <- sample(c(17,-1), n, replace=TRUE, prob=c(p_green,p_not_green))
  mean(winnings)
})
mean(S)
sd(S)
mean(S>0)




p_correct <- 1/5
p_not_correct <- 1-p_correct
correct <- 1
not_correct <- -.25
correct*p_correct + not_correct*p_not_correct
n <- 44
avg <- n * (correct*p_correct + not_correct*p_not_correct)
se <- sqrt(n) * abs(correct-not_correct)*sqrt(p_correct*p_not_correct)
1-pnorm(8, avg, se)
set.seed(21, sample.kind = "Rounding")
B <- 10000
S <- replicate(B, {
  answers <- sample(c(correct,not_correct), n, replace=TRUE, prob=c(p_correct,p_not_correct))
  sum(answers)
})
mean(S>8)
p_correct <- 1/4
p_not_correct <- 1-p_correct
correct <- 1
not_correct <- 0
n * (correct*p_correct + not_correct*p_not_correct)
p <- seq(0.25, 0.95, 0.05)
F <- function(p) {
  p_correct <- p
  p_not_correct <- 1-p_correct
  n * (correct*p_correct + not_correct*p_not_correct)
}
avg <- sapply(p, F)
F <- function(p) {
  p_correct <- p
  p_not_correct <- 1-p_correct
  sqrt(n) * abs(correct-not_correct)*sqrt(p_correct*p_not_correct)
}
se <- sapply(p, F)
my_df <- data.frame(p=p,avg=avg,se=se)
my_df <- mutate(my_df, pnorm=1-pnorm(35, avg, se))  





p_special <- 5/38
p_not_special <- 1-p_special
special <- 6
not_special <- -1
special*p_special + not_special*p_not_special
(special-not_special)*sqrt(p_special*p_not_special)
n <- 500
(1/sqrt(n)) * (special-not_special)*sqrt(p_special*p_not_special)
avg <- n * (special*p_special + not_special*p_not_special)
se <- sqrt(n) * (special-not_special)*sqrt(p_special*p_not_special)
pnorm(0, avg, se)






n <- 10000
loss_per_foreclosure <- -200000
p_default <- 0.03
set.seed(1)
defaults <- sample(c(0,1), n, replace=TRUE, prob=c(1-p_default,p_default))
S <- sum(defaults) * loss_per_foreclosure
B <- 10000
S <- replicate(B, {
  defaults <- sample(c(0,1), n, replace=TRUE, prob=c(1-p_default,p_default))
  sum(defaults) * loss_per_foreclosure
})
hist(S)
n * (loss_per_foreclosure * p_default)
sqrt(n) * abs(-loss_per_foreclosure) * sqrt((1-p_default)*p_default)
# avg = (x * (1-p_default)) + (loss_per_foreclosure * p_default)
x <- -(loss_per_foreclosure * p_default) / (1-p_default)
x / 180000
z <- qnorm(0.05)
# z = -avg / se
l <- loss_per_foreclosure
p <- p_default
x <- -l*( n*p - z*sqrt(n*p*(1-p)))/ ( n*(1-p) + z*sqrt(n*p*(1-p)))






library(tidyverse)
library(dslabs)
data(death_prob)
df <- filter(death_prob, age==50, sex=="Female")
p <- pull(df, prob)
alive <- 1150
death <- -150000
alive*(1-p) + death*p
abs(alive-death)*sqrt((1-p)*p)
n <- 1000
avg <- n*(alive*(1-p) + death*p)
se <- sqrt(n)*abs(alive-death)*sqrt((1-p)*p)
pnorm(0, avg, se)
df <- filter(death_prob, age==50, sex=="Male")
p <- pull(df, prob)
# avg = n*(premium*(1-p) + death*p) # 700000
avg <- 700000
premium <- ((avg/n) - death*p)/(1-p)
alive <- abs(premium)
se <- sqrt(n)*abs(alive-death)*sqrt((1-p)*p)
pnorm(0, avg, se)
p <- .015
avg <- n*(alive*(1-p) + death*p)
se <- sqrt(n)*abs(alive-death)*sqrt((1-p)*p)
pnorm(0, avg, se)
pnorm(-10^6, avg, se)
p <- seq(.01, .03, .001)
F <- function(p) {
  n*(alive*(1-p) + death*p)
}
avg <- sapply(p, F)
F <- function(p) {
  sqrt(n)*abs(alive-death)*sqrt((1-p)*p)
}
se <- sapply(p, F)
df <- data.frame(p=p,avg=avg,se=se)
df <- mutate(df, pnorm=pnorm(0, avg, se))
p <- seq(.01, .03, .0025)
df <- mutate(df, pnorm=pnorm(-10^6, avg, se))
set.seed(25, sample.kind = "Rounding")
p <- .015
S <- sample(c(alive,death), n, replace=TRUE, prob=c((1-p),p))
sum(S)/10^6
set.seed(27, sample.kind = "Rounding")
B <- 10000
S <- replicate(B, {
  S <- sample(c(alive,death), n, replace=TRUE, prob=c((1-p),p))
  sum(S)
})
mean(S < -10^6)
# z = -avg / se
z <- qnorm(0.05)
l <- death
p <- .015
x <- -l*( n*p - z*sqrt(n*p*(1-p)))/ ( n*(1-p) + z*sqrt(n*p*(1-p)))
x*(1-p) + death*p
n * (x*(1-p) + death*p)
set.seed(28, sample.kind = "Rounding")
S <- replicate(B, {
  S <- sample(c(x,death), n, replace=TRUE, prob=c((1-p),p))
  sum(S)
})
mean(S<0)
set.seed(29, sample.kind = "Rounding")
S <- replicate(B, {
  p <- p + sample(seq(-0.01, 0.01, length = 100), 1)
  S <- sample(c(x,death), n, replace=TRUE, prob=c((1-p),p))
  sum(S)
})
mean(S)
mean(S<0)
mean(S < -10^6)






