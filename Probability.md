# Probability

### Libraries

```
library(gtools) # programming tools
```

# Commands

|command|notes|
|-|-|
|`rep(x, y)`|replicate values in `x` by `y` times|
|`sample(x, y)`|random sample from `x` picking `y` times _without_ replacement|
|`sample(x, y, replace=TRUE)`|random sample _with_ replacement|
|`replicate(x, expr)`|repeated evaluation of `expr` - _wrapper for `sapply`_, see [Basics](Basics.md)|
|`set.seed(x)` <br> `set.seed(x, sample.kind="Rounding")`|random number generator seed <br> `sample.kind="Rounding"` will set R `3.6+` behavior to `3.5`|
|`paste(x, y)`|joins `x` and `y` with a _space_|
|`expand.grid(a=x, b=y)`|creates data frame with columns `a` and `b` <br> from all combinations of `x` and `y`|
|`permutations(n, r)`|`r` items from set of `n` options, order matters, `gtools`|
|`combinations(n, r)`|`r` items from set of `n` options, order _does not_ matter, `gtools`|
