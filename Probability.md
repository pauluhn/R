# Probability

### libraries

```
library(gtools) # programming tools
```

# Commands

|command|notes|
|-|-|
|`rep(x, y)`|replicate values in `x` by `y` times|
|`sample(x, y)`|random sample from `x` picking `y` times _without_ replacement|
|`sample(x, y, replace=TRUE)`|random sample _with_ replacement|
|`sample(x, y, replace=TRUE, prob=z)`|random sample _with_ replacement using `z` weights|
|`replicate(x, expr)`|repeated evaluation of `expr` - _wrapper for `sapply`_, see [Basics](Basics.md)|
|`set.seed(x)` <br> `set.seed(x, sample.kind="Rounding")`|random number generator seed <br> `sample.kind="Rounding"` will set R `3.6+` behavior to `3.5`|
|`paste(x, y)`|joins `x` and `y` with a _space_|
|`expand.grid(a=x, b=y)`|creates data frame with columns `a` and `b` <br> from all combinations of `x` and `y`|
|`permutations(n, r)` <br> `permutations(n, r, v)`|`r` items from set of `n` options, order matters, `gtools` <br> `v` is source vector with default `1:n`|
|`combinations(n, r)` <br> `combinations(n, r, v)`|`r` items from set of `n` options, order _does not_ matter, `gtools` <br> `v` is source vector with default `1:n`|
|`dnorm(x)` <br> `dnorm(x, mean=0, sd=1)`|density normal distribution of `x` <br> for _non-z-scores_, set `mean` and `sd`|
|`pnorm(q)` <br> `pnorm(q, mean=0, sd=1)`|probability density normal distribution of `q` <br> see [Basic Normal Distribution](Basics.md#normal-distribution)|
|`qnorm(p)` <br> `qnorm(p, mean=0, sd=1)`|quantile normal distribution of `p`|
|`rnorm(n)` <br> `rnorm(n, mean=0, sd=1)`|random vector of length `n` generated using `mean`/`sd`|

also see [Basic Commands](Basics.md#basic-commands), [Basic Programming](Basics.md#programming)

# Cookbook

### deck of cards

```
suits <- c("Diamonds", "Clubs", "Hearts", "Spades")
numbers <- c("Ace", "Deuce", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King")
deck <- expand.grid(number = numbers, suit = suits)
deck <- paste(deck$number, deck$suit)
```

### natural 21

```
aces <- paste("Ace", suits)
facecard <- c("King", "Queen", "Jack", "Ten")
facecard <- expand.grid(number = facecard, suit = suits)
facecard <- paste(facecard$number, facecard$suit)

hands <- combinations(52, 2, v=deck) # all possible hands

# probability of a natural 21 given that the ace is listed first in `combinations`
mean(hands[,1] %in% aces & hands[,2] %in% facecard)

# probability of a natural 21 checking for both ace first and ace second
mean((hands[,1] %in% aces & hands[,2] %in% facecard)|(hands[,2] %in% aces & hands[,1] %in% facecard))
```

### monty hall problem

```
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
```
