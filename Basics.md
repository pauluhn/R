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
|`args(ls)`|function arguments|
|`class(x)`|object type (see #object-type)|
|`str(x)`|object structure|
|`head(x)`|show first six lines|
|`names(x)`|object variable names|
|`identical(x, y)`|compare if two objects are identical|

### pipe
|command|notes|
|-|-|
|`\|>`|`R 4.1.0+`|
|`%>%`|`tidyverse` package|






# Object types
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
|`nrow(my_df)`|number of rows|

### manipulate
_uses `dplyr` package_
|command|notes|
|-|-|
|`mutate(my_df, new_column=column1+column2)`|add columns|
|`filter(my_df, logical)`|subset of rows|
|`select(my_df, column1, column2)`|select specific columns|

_skip `my_df` when piping commands_






# Vector
|command|notes|
|-|-|
|`length(x)`|vector length|
|`table(x)`|frequency table|
|`sort(x)`|sorted values|
|`order(x)`|sorted indices|
|`rank(x)`|rank of items of original vector, ascending|
|`rank(-x)`|rank of items of original vector, descending|
|`max(x)`|max value|
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
