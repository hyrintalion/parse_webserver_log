Task
1. Write a program that:
a. Receives a log file as an argument (webserver.log is provided) e.g.: ./<parse> webserver.log
b. Returns the following:
> list of webpages with most page views ordered from most pages views to less page views e.g.:
/home 90 visits /index 80 visits etc...

> list of webpages with most unique page views also ordered e.g.:
/about/2 8 unique views /index 5 unique views etc...

Solution

For running the tests provided, you will need the Rspec gem. Open a terminal window and run the following command to install rspec:

`gem install rspec`

For running the scrypt open a terminal window and run the following command to install rspec

`./parse.rb webserver.log`

