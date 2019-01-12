#! /usr/bin/Rscript
# Get the parallel USD/VES rate from @MonitorDolarVe
#
# This script depends on the following packages:
#   rtweet

cmdargs <- commandArgs(trailingOnly=TRUE)

if (length(cmdargs) == 0) {
    cmdargs <- "twitter"
}

if (cmdargs[1] == "twitter") {
    # @MonitorDolarVe
    write("Retreiving @MonitorDolarVe tweets.", stdout())
    tw <- rtweet::get_timeline("MonitorDolarVe")
    dolar <- gsub(
        "^.*(Promedio general = .+BsS).*$",
        "\\1",
        tw[grep("^Dólar paralelo", tw$text),][[1, "text"]]
    )
    write(dolar, stdout())

} else {
    # Help Message
    help_msg <- paste(
        "Retreive from the internet the current USD/VES price",
        "Usage: dollar [SOURCE]",
        "Example: dollar airtm\n",
        "The current supported SOURCE values are:",
        "\ttwitter\tGets the price from the last @MonitorDolarVe tweet. (The default)",
        "\tAny other value will return this help message",
        sep = "\n"
    )
    write(help_msg, stdout())

}
