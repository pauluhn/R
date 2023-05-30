# ggplot2

**g**rammar of **g**raphics

```
library(tidyverse)  # ggplot is part of tidyverse
library(ggplot2)    # load just ggplot2 instead of entire tidyverse
```

### additional libraries
```
library(ggthemes)     # additional themes
library(ggrepel)      # geometry that repels labels
library(gridExtra)    # grid of plots
library(geomtextpath) # geometry for text along a path

library(dslabls)
ds_theme_set()        # theme by dslabs
```

### create
```
ggplot(data = x)
ggplot(x)
x |> ggplot(aes(x=a, y=b, color=c, group=d, weight=e))

# using computed variables
x |> ggplot(aes(x=a, y=..count..))
```

### layers
|layer|notes|
|-|-|
|`geom_point(x, y)`|scatterplot|
|`geom_point(position="jitter")` <br> `geom_jitter()`|jittered scatterplot|
|`geom_line(x, y)`|lineplot|
|`geom_bar(x, y)`|barplot|
|`geom_histogram(binwidth=1, fill="blue", col="black")`|histogram, bin width of 1, blue bars with black outline|
|`geom_density(fill="blue")`|smooth density plot|
|`geom_density(position="stack")`|stacked density plot|
|`geom_qq()`|quantile-quantile plot|
|`geom_boxplot()`|boxplot|
|`geom_label(x, y, label)`||
|`geom_text(x, y, label)`||
|`geom_textpath()`|text along a path, `geomtextpath`|
|`geom_vline(xintercept)` <br> `geom_hline(yintercept)` <br> `geom_abline(slope, intercept)`|single line|
|`scale_x_continuous(trans="log2")` <br> `scale_y_continuous(trans="log2")`|log2 scale|
|`scale_x_log10()` <br> `scale_y_log10()`|log10 scale|
|`xlab("text")` <br> `ylab("text")`|axis label|
|`ggtitle("text")`|plot title|
|`theme(legend.position="none")`|hide legend|
|`theme(axis.text.x=element_text(angle=90, hjust=1))`|rotate text, set justification|
|`grid.arrange()`|grid of plots, `gridExtra`|
|`facet_grid(a ~ b)`|multiple side-by-side plots faceted by variables `a` and `b`|
|`facet_grid(. ~ a)` <br> `facet_grid(a ~ .)`|plots faceted by only variable `a`|
|`facet_wrap(~ a)`|plots faceted by only variable `a` <br> wrapping onto multiple rows|
|`..count..`|access computed variables using pairs of `..`|
|`scale_color_manual(values)`|use custom color, _see below_|
|`xlim(a, b)` <br> `ylim(c, d)`|zooming with clipping|

### custom colors
```
scale_color_manual(values = c("#000000", "#AAAAAA", "#0022BB", "#22BB00", "#CCCCCC", "#CC00CC", "#CCCC00", "#00CCCC", "#CC0000", "#888888"))
```
