a <- seq(min(my_data), max(my_data), length = 100)    # define range of values spanning the dataset
cdf_function <- function(x) {    # computes prob. for a single value
  mean(my_data <= x)
}
cdf_values <- sapply(a, cdf_function)
plot(a, cdf_values)

# calculate the mean and standard deviation manually
average <- sum(x)/length(x)
SD <- sqrt(sum((x - average)^2)/length(x))

p <- 1-pnorm(7*12, 69, 3)
N <- round(p * 10^9)


library(dplyr)
library(ggplot2)
library(dslabs)
data(gapminder)
## fill out the missing parts in filter and aes
gapminder %>% filter(year==2012 & continent=="Africa") %>%
  ggplot(aes(fertility, life_expectancy, color=region)) +
  geom_point()

df <- gapminder %>%
  filter(year==2012 & continent=="Africa") %>%
  filter(fertility <= 3 & life_expectancy >= 70) %>%
  select(country, region)

tab <- gapminder %>%
  filter(year >= 1960 & year <= 2010) %>%
  filter(country %in% c("Vietnam", "United States"))

p <- tab %>%
  ggplot(aes(year, life_expectancy, color=country)) +
  geom_line()

daydollars <- gapminder %>% 
  mutate(dollars_per_day=gdp/population/365) %>%
  filter(continent == "Africa" & year==2010 & !is.na(dollars_per_day))

daydollars %>%
  ggplot(aes(dollars_per_day)) +
  geom_density() +
  scale_x_continuous(trans="log2")

gapminder %>% 
  mutate(dollars_per_day=gdp/population/365) %>%
  filter(continent == "Africa" & year %in% c(1970, 2010) & !is.na(dollars_per_day)) %>%
  ggplot(aes(dollars_per_day)) +
  geom_density() +
  scale_x_continuous(trans="log2") +
  facet_grid(. ~ year)

gapminder %>% 
  mutate(dollars_per_day=gdp/population/365) %>%
  filter(continent == "Africa" & year %in% c(1970, 2010) & !is.na(dollars_per_day)) %>% 
  ggplot(aes(dollars_per_day, fill=region)) +
  geom_density(position="stack", bw=0.5) +
  scale_x_continuous(trans="log2") +
  facet_grid(. ~ year)

gapminder_Africa_2010 <- gapminder %>% 
  mutate(dollars_per_day=gdp/population/365) %>%
  filter(continent == "Africa" & year==2010 & !is.na(dollars_per_day))
gapminder_Africa_2010 %>%
  ggplot(aes(dollars_per_day, infant_mortality, color=region)) +
  geom_point()

gapminder_Africa_2010 %>%
  ggplot(aes(dollars_per_day, infant_mortality, color=region)) +
  geom_point() +
  scale_x_continuous(trans="log2")

gapminder_Africa_2010 %>%
  ggplot(aes(dollars_per_day, infant_mortality, color=region, label=country)) +
  geom_point() +
  scale_x_continuous(trans="log2") +
  geom_text()

gapminder %>% 
  mutate(dollars_per_day=gdp/population/365) %>%
  filter(continent == "Africa" & year %in% c(1970, 2010) & !is.na(dollars_per_day) & !is.na(infant_mortality)) %>% 
  ggplot(aes(dollars_per_day, infant_mortality, color=region, label=country)) +
  geom_text() +
  scale_x_continuous(trans="log2") +
  facet_grid(year ~ .)

library(dplyr)
library(ggplot2)
library(dslabs)
dat <- us_contagious_diseases %>%
  filter(year == 1967 & disease=="Measles" & !is.na(population)) %>% mutate(rate = count / population * 10000 * 52 / weeks_reporting)
state <- dat$state 
rate <- dat$count/(dat$population/10000)*(52/dat$weeks_reporting)
state <- reorder(state, rate)
levels(state)

dat <- us_contagious_diseases %>% filter(year == 1967 & disease=="Measles" & count>0 & !is.na(population)) %>%
  mutate(rate = count / population * 10000 * 52 / weeks_reporting) %>%
  mutate(state = reorder(state, rate))
dat %>% ggplot(aes(state, rate)) +
  geom_bar(stat="identity") +
  coord_flip()

murders %>% mutate(rate = total/population*100000) %>%
  group_by(region) %>%
  summarize(avg = mean(rate)) %>%
  mutate(region = factor(region)) %>%
  ggplot(aes(region, avg)) +
  geom_bar(stat="identity") +
  ylab("Murder Rate Average")

murders %>% mutate(rate = total/population*100000) %>%
  mutate(region = reorder(region, rate, FUN=median)) %>%
  ggplot(aes(region, rate)) +
  geom_boxplot() +
  geom_point()

library(dplyr)
library(ggplot2)
library(RColorBrewer)
library(dslabs)
data(us_contagious_diseases)

the_disease = "Measles"
dat <- us_contagious_diseases %>% 
  filter(!state%in%c("Hawaii","Alaska") & disease == the_disease) %>% 
  mutate(rate = count / population * 10000) %>% 
  mutate(state = reorder(state, rate))

dat %>% ggplot(aes(year, state, fill = rate)) + 
  geom_tile(color = "grey50") + 
  scale_x_continuous(expand=c(0,0)) + 
  scale_fill_gradientn(colors = brewer.pal(9, "Reds"), trans = "sqrt") + 
  theme_minimal() + 
  theme(panel.grid = element_blank()) + 
  ggtitle(the_disease) + 
  ylab("") + 
  xlab("")

library(dplyr)
library(ggplot2)
library(dslabs)
library(RColorBrewer)
data(us_contagious_diseases)

the_disease = "Measles"
dat <- us_contagious_diseases %>%
  filter(!state%in%c("Hawaii","Alaska") & disease == the_disease) %>%
  mutate(rate = count / population * 10000) %>%
  mutate(state = reorder(state, rate))

avg <- us_contagious_diseases %>%
  filter(disease==the_disease) %>% group_by(year) %>%
  summarize(us_rate = sum(count, na.rm=TRUE)/sum(population, na.rm=TRUE)*10000)

dat %>% ggplot() +
  geom_line(aes(year, rate, group = state),  color = "grey50", 
            show.legend = FALSE, alpha = 0.2, size = 1) +
  geom_line(mapping = aes(year, us_rate),  data = avg, size = 1, color = "black") +
  scale_y_continuous(trans = "sqrt", breaks = c(5,25,125,300)) + 
  ggtitle("Cases per 10,000 by state") + 
  xlab("") + 
  ylab("") +
  geom_text(data = data.frame(x=1955, y=50), mapping = aes(x, y, label="US average"), color="black") + 
  geom_vline(xintercept=1963, col = "blue")

library(dplyr)
library(ggplot2)
library(dslabs)
library(RColorBrewer)
data(us_contagious_diseases)

us_contagious_diseases %>% filter(state=="California") %>% 
  group_by(year, disease) %>%
  summarize(rate = sum(count)/sum(population)*10000) %>%
  ggplot(aes(year, rate)) + 
  geom_line()

us_contagious_diseases %>% 
  filter(!is.na(population)) %>%
  group_by(year, disease) %>%
  summarize(rate = sum(count)/sum(population)*10000) %>%
  ggplot(aes(year, rate, color=disease)) + 
  geom_line()

options(digits = 3)    # report 3 significant digits
library(tidyverse)
library(titanic)

titanic <- titanic_train %>%
  select(Survived, Pclass, Sex, Age, SibSp, Parch, Fare) %>%
  mutate(Survived = factor(Survived),
         Pclass = factor(Pclass),
         Sex = factor(Sex))

titanic %>% group_by(Sex) %>%
  ggplot(aes(Age, ..count.., color=Sex)) +
  geom_density() #+
  #facet_grid(Sex ~ .)

params <- titanic %>%
  filter(!is.na(Age)) %>%
  summarize(mean = mean(Age), sd = sd(Age))
titanic %>% 
  ggplot(aes(sample=Age)) +
  geom_qq(dparams=params) +
  geom_abline()

titanic %>% group_by(Sex, Survived) %>%
  ggplot(aes(Survived, fill=Sex)) +
  geom_bar()#position=position_dodge())

titanic %>% 
  ggplot(aes(Age, ..count.., fill=Survived)) +
  geom_density(alpha=0.2)

titanic %>%
  filter(Fare > 0) %>% group_by(Survived) %>%
  ggplot(aes(Fare, 0, color=Survived)) +
  geom_boxplot() +
  scale_x_continuous(trans="log2") +
  geom_point(position="jitter", alpha=0.2)

titanic %>%
  ggplot(aes(Pclass, fill=Survived)) +
  geom_bar()
titanic %>%
  ggplot(aes(Pclass, fill=Survived)) +
  geom_bar(position = position_fill())
titanic %>%
  ggplot(aes(Survived, fill=Pclass)) +
  geom_bar(position = position_fill())

titanic %>% 
  ggplot(aes(Age, ..count.., fill=Survived)) +
  geom_density(alpha=0.2) +
  facet_grid(Sex ~ Pclass)


library(tidyverse)
library(dslabs)
data(stars)
options(digits = 3) 

stars |>
  #head() |>
  #filter(temp < 5000 & magnitude < 0) |>
  #select(magnitude) |> #num
  #select(temp) |> #int
  ggplot(aes(temp, magnitude, color=type)) +
  #geom_density()
  geom_point() +
  scale_y_reverse() +
  scale_x_log10() +
  scale_x_reverse() +
  #geom_label_repel()
  scale_color_manual(values = c("#000000", "#AAAAAA", "#0022BB", "#22BB00", "#CCCCCC", "#CC00CC", "#CCCC00", "#00CCCC", "#CC0000", "#888888"))


library(tidyverse)
library(dslabs)
data(temp_carbon)
data(greenhouse_gases)
data(historic_co2)

temp_carbon |>
  #filter(!is.na(carbon_emissions)) |>
  filter(!is.na(temp_anomaly)) |>
  filter(year %in% c(1880, 2018))
  #select(year) |>
  #min()
  #max()
p <- temp_carbon |>
  filter(!is.na(temp_anomaly)) |>
  ggplot(aes(year, temp_anomaly)) +
  geom_line()
p <- p + geom_hline(aes(yintercept = 0), col = "blue")
p <- p + ylab("Temperature anomaly (degrees C)") +
  ggtitle("Temperature anomaly relative to 20th century mean, 1880-2018") +
  geom_text(aes(x = 2000, y = 0.05, label = "20th century mean"), col = "blue")
p + geom_line(aes(year, ocean_anomaly), col = "orange") +
  geom_line(aes(year, land_anomaly), col = "red")

greenhouse_gases |>
  ggplot(aes(year, concentration)) +
  geom_line() +
  facet_grid(gas ~ ., scales="free") +
  geom_vline(xintercept = 1850) +
  ylab("Concentration (ch4/n2o ppb, co2 ppm)") +
  ggtitle("Atmospheric greenhouse gas concentration by year, 0-2000")

temp_carbon |>
  filter(!is.na(carbon_emissions)) |>
  ggplot(aes(year, carbon_emissions)) +
  geom_line()
  
co2_time <- historic_co2 |>
  ggplot(aes(year, co2, color=source)) +
  geom_line()
co2_time +
  xlim(-800000,-775000)
co2_time +
  xlim(-375000,-330000)
co2_time +
  xlim(-140000,-120000)
co2_time +
  xlim(-3000,2018)



