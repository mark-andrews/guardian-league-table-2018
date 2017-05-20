The Guardian University League Tables 2018 provide ratings of all undergraduate degrees in all UK universities. The landing page for the tables is [here](https://www.theguardian.com/education/ng-interactive/2017/may/16/university-league-tables-2018). On [this page](https://www.theguardian.com/education/2016/may/23/methodology-behind-the-guardian-university-guide-2017), they provide a link to a downloadable spreadsheet. However, I've had some trouble with the link to the spreadsheet. Initially, (when I tried on May17) the link did not work at all; it just linked back to the page itself. A few days later (on May 20), the link did resolve to a google docs page. However, that page was just a spreadsheet viewer and it was not possible to download this sheet and so it was not any more useful than the html based tables on the Guardian website itself. After changing the query string at the end of the URL, it redirected me to [here](https://docs.google.com/spreadsheets/d/1P1AiFGB5UFO0v26Ufe_3YNOT4lISK6DAaC8dvDRiVzs/edit#gid=1544561606), and from there I was able to download a .xls sheet of the tables. Just in case any more trouble with these links occur, I have put a copy of this spreadsheet in this directory.

* The file is 'Guardian University Guide 2018.xlsx'.
* Its sha1sum hash is `eee95e7d17172e3818e9ee33632e499f8bd8b5db`

The `.xls` sheet was transformed into a *tidy* data frame and this is `glt2018.Rda`. This code for this data tidying can be found in the RMarkdown document `process.Rmd`.


