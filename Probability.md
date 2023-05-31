# Probability

# Commands

|command|notes|
|-|-|
|`rep(x, y)`|replicate values in `x` by `y` times|
|`sample(x, y)`|random sample from `x` picking `y` times _without_ replacement|
|`sample(x, y, replace=TRUE)`|random sample _with_ replacement|
|`replicate(x, expr)`|repeated evaluation of `expr` - _wrapper for `sapply`_, see [Basics](Basics.md)|
|`set.seed(x)` <br> `set.seed(x, sample.kind="Rounding")`|random number generator seed <br> `sample.kind="Rounding"` will set R `3.6+` behavior to `3.5`|
