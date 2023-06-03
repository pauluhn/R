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
