# A Shiny app and R code for viewing the Guardian's university league tables 2018

The shiny app allows you to view the distribution of the values the individual
factors (like teaching satisfaction, graduate prospects, etc) that make up the
aggregate scores. These can e grouped either subject or by insitution.

The data used in this demo was provided by the Guardian and was downloaded from
[here](https://docs.google.com/spreadsheets/d/1P1AiFGB5UFO0v26Ufe_3YNOT4lISK6DAaC8dvDRiVzs/edit#gid=1544561606).
A copy of this `.xls` sheet is available [here]('data/Guardian University Guide 2018.xlsx').

The `.xls` sheet was transformed into a *tidy* data frame and this is available [here]('data/glt2018.Rda'). This code for this data tidying can be found [this]('data/process.Rmd') RMarkdown document.

### Author 
Mark Andrews. Twitter: [@xmjandrews](https://twitter.com/xmjandrews)

