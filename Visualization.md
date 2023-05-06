# ggplot2

**g**rammar of **g**raphics

```
library(tidyverse)  # ggplot is part of tidyverse
library(ggplot2)    # load just ggplot2 instead of entire tidyverse
```

### additional libraries
```
library(ggthemes)   # additional themes
library(ggrepel)    # geometry that repels labels
library(gridExtra)  # grid of plots

library(dslabls)
ds_theme_set()      # theme by dslabs
```

### create
```
ggplot(data = x)
ggplot(x)
x |> ggplot(aes(x=a, y=b, color=c, group=d))
```

### layers
|layer|notes|
|-|-|
|`geom_point(x, y)`|scatterplot|
|`geom_histogram(binwidth=1, fill="blue", col="black")`|histogram, bin width of 1, blue bars with black outline|
|`geom_density(fill="blue")`|smooth density plot|
|`geom_qq()`|quantile-quantile plot|
|`geom_label(x, y, label)`||
|`geom_text(x, y, label)`||
|`geom_abline(slope, intercept)`|single line|
|`scale_x_log10()` <br> `scale_y_log10()`|log10 scale|
|`xlab("text")` <br> `ylab("text")`|axis label|
|`ggtitle("text")`|plot title|
|`grid.arrange()`|grid of plots, `gridExtra`|
