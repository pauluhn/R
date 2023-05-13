`R 4.2.2`

# Packages

### list
`installed.packages()`

### install
- `install.packages("package_name")`
- `install.packages("package_name", dependencies = TRUE)`
- `install.packages(c("package_name", "second_package_name"))` # c() concatenates/combines to create a vector

### load
`library(package_name)`

### should-haves
|package|notes|
|-|-|
|`tidyverse`||
|`dplyr`||







# Basic commands
|command|notes|
|-|-|
|`ls()`|list workspace variables|
|`?ls`|show help|
|`options(digits = 3)`|report 3 significant digits for all answers|5
|`args(ls)`|function arguments|
|`class(x)`|object type (see #object-type)|
|`str(x)`|object structure|
|`head(x)`|show first six lines|
|`names(x)`|object variable names|
|`identical(x, y)`|compare if two objects are identical|
|`apply`||
|`sapply`||
|`tapply`||
|`mapply`||
|`split`||
|`cut`||
|`quantile(x, q)`|quantiles given probabilities|
|`quantile(x, seq(0.01, 0.99, 0.01))`|percentiles <br> access using `percentiles[names(percentiles) == "25%"]`|
|`summary(x)`|quartiles, min and max|
|`reduce`||
|`unique`|like a `set`|
|`scale(x)`|convert to standard units|
|`round(x)`|rounding|

### normal distribution
|command|notes|
|-|-|
|`pnorm(a, mean(x), sd(x))`|probability (or quantile) of value `a` in `x`, cdf <br> inverse of qnorm|
|`qnorm(a, mean(x)=0, sd(x)=1`|_value_ of probability `a` in `x` <br> for standard distribution, use default values <br> inverse of pnorm|

```
p <- seq(0.01, 0.99, 0.01)
theoretical_quantiles <- qnorm(p, mean(x), sd(x))
```


### pipe
|command|notes|
|-|-|
|`\|>`|`R 4.1.0+`|
|`%>%`|`tidyverse` package|






# Object types
- data.table - `data.table` package
- tbl - _"tibble"_, `tidyverse` package
- data.frame
- numeric
- character
- logical
- factor
- list
- matrix
- integer is memory-efficient numeric, ie 3L instead of 3

### typecast
- as.character(numeric_value)
- as.numeric(numeric_string)
- as_tibble(my_df), `tidyverse` package








# Data.table

Memory-efficient, update by reference

### create
```
install.packages("data.table")
library(data.table)
my_dt <- setDT(my_df) # data.table <- data.frame
```

### manipulate
|command|notes|
|-|-|
|`my_dt[, c("column1", "column2")]`|select specific columns|
|`my_dt[, .(column1, column2)]`|select specific columns using `.()`|
|`my_dt[, new_column := column1 + column2]`|add/update columns using `:=`|
|`my_dt[, ":="(new_col1 = col1 + col2, new_col2 = rank(col1))]`|add/update multiple columns|
|`my_dt[column1 <= 0.7]`|subset of rows|
|`my_dt[column1 <= 0.7, .(column1, column2)]`|subset of rows with specific columns|
|`my_dt[, .(minimum = min(x), maximum = max(x))]`|create summary data table using `=`|
|`my_dt[x < 1, .(minimum = min(x), maximum = max(x))]`|create summary for subset|
|`my_dt[, .(minimum = min(x), maximum = max(x)), by = y]`|create grouped summary|
|`my_dt[order(column1)]`|sort data table by column, ascending|
|`my_dt[order(-column1)]`|sort data table by column, descending|
|`my_dt[order(column1, decreasing = TRUE)]`|sort data table by column, descending|
|`my_dt[order(column1, column2, etc)]`|sort data table by column1, break tie by column2, etc|






# Tibble

A tibble is a better version of a data frame:
- displays better
- subsets are always tibbles (not vectors)
- shows warnings instead of `NULL`
- can contain lists and functions

### create
```
tibble(names = c("John", "Juan", "Jean", "Yao"), 
       exam_1 = c(95, 80, 90, 85), 
       exam_2 = c(90, 85, 85, 90))
```




# Data.frame

### create
```
x <- c(35, 88, 42, 84, 81, 30)
y <- c("B", "L", "P", "R", "S", "T")
my_df <- data.frame(v1 = x, v2 = y)
```

### commands
|command|notes|
|-|-|
|`my_df$variable_name`|vector of variable_name|
|`my_df[["variable_name"]]`|vector of variable_name|
|`my_df["variable_name"]`|subset of data.frame|
|`with(my_df, plot(variable1, variable2))`|avoid using accessors|
|`nrow(my_df)`|number of rows|
|`summarize(my_df, minimum = min(x)`|create _(tibble)_ data frame with summary, `dplyr`|
|`group_by(my_df, x)`|create grouped _(tibble)_ data frame, `dplyr`|
|`group_by(my_df, x, y)`|create multi-grouped _(tibble)_ data frame, `dplyr`|
|`pull(my_df, x)`|similar to `$`, `dplyr`|
|`.$x`|placeholder for data when piping|

### manipulate
_uses `dplyr` package_
|command|notes|
|-|-|
|`mutate(my_df, new_column = column1 + column2)`|add columns|
|`filter(my_df, column1 <= 0.7)`|subset of rows|
|`select(my_df, column1, column2)`|select specific columns|
|`arrange(my_df, column3)`|sort data frame by column, ascending|
|`arrange(my_df, desc(column3))`|sort data frame by column, descending|
|`arrange(my_df, column3, column4, etc)`|sort data frame by column3, break tie by column4, etc|
|`top_n(my_df, 6, column1)`|like `head`, but uses column to filter (not sorted)|

_skip `my_df` when piping commands_

```
# return the top 10 states ranked by murder rate, sorted by murder rate
murders %>% arrange(desc(rate)) %>% top_n(10)
```



# Vector

### create
```
empty_vector <- vector(length = 5)
```

|command|notes|
|-|-|
|`length(x)`|vector length|
|`nchar(x)`|char vector length|
|`table(x)`|frequency table of counts|
|`prop.table(x)`|frequency table of proportions|
|`sort(x)`|sorted values|
|`order(x)`|sorted indices|
|`rank(x)`|rank of items of original vector, ascending|
|`rank(-x)`|rank of items of original vector, descending|
|`mean(x)`|mean, average|
|`sd(x)`|standard deviation|
|`max(x)`|max value|
|`median(x)`|median value|
|`mad(x)`|median absolute deviation|
|`min(x)`|min value|
|`which.max(x)`|index of max|
|`which.min(x)`|index of min|
|`is.na(x)`|returns logical vector|
|`which(logical)`|returns indicies (avoid long logical vector)|
|`match(x, y)`|returns y indicies that match x|
|`x %in% y`|returns logical vector|

### `match` example
```
# example of same but opposite order
match(c("New York", "Florida", "Texas"), murders$state)
#> [1] 33 10 44
which(murders$state%in%c("New York", "Florida", "Texas"))
#> [1] 10 33 44
```

### vector with names
```
codes <- c(italy = 380, canada = 124, egypt = 818)
```

```
codes <- c("italy" = 380, "canada" = 124, "egypt" = 818)
```

```
codes <- c(380, 124, 818)
country <- c("italy","canada","egypt")
names(codes) <- country
```

|command|notes|
|-|-|
|`class(codes)`|numeric|
|`names(codes)`|italy, canada, egypt|
|`codes[2]`|canada 124|
|`codes[c(1,3)]`|italy 380, egypt 818|
|`codes[1:2]`|italy 380, canada 124|
|`codes["canada"]`|canada 124|
|`codes[c("egypt","italy")]`|egypt 818, italy 380|







# Numeric
|command|notes|
|-|-|
|`1:5`|1, 2, 3, 4, 5|
|`seq(1,5)`|1, 2, 3, 4, 5|
|`seq(1,10,2)`|1, 3, 5, 7, 9|
|`seq(0,100,length.out=5)`|0, 25, 50, 75, 100|






# Factor
|command|notes|
|-|-|
|`levels(x)`|factor levels|
|`nlevels(x)`|number of factor levels|
|`reorder(x, y, FUN=mean)`|reorder factors `x` by values `y` via function `mean`|





# Programming
|command|notes|
|-|-|
|`if (logical) { a } else { b }`||
|`ifelse(logical, a, b)`|works with vectors|
|`any(x)`|works with vectors|
|`all(x)`|works with vectors|
|`for(i in x) { a }`|for-in loop|






# Function
```
my_func <- function(x, v = c(0, 0.5, 1)) { # variable and default values
  r <-  quantile(x, v)
  data.frame(minimum = r[1], median = r[2], maximum = r[3]) # return value
}
```





# Plot
|command|notes|
|-|-|
|`plot(x, y)`|scatterplot|
|`hist(x)`|histogram|
|`boxplot(x~y, data=my_df)`|boxplot|
|`image(matrix)`|colored matrix|
|`line(x, y)`|line graph|
|`abline(intercept, slope)`|single straight line|
