#! /usr/bin/Rscript
# Get the parallel USD/VES rate from airtmrates.io or @MonitorDolarVe
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
    tw <- tw[grep("^Dólar paralelo", tw$text),][1,]
    rate <- gsub(
        "^.*(Promedio general = .+BsS).*$",
        "\\1",
        tw[["text"]]
    )
    when <- as.POSIXlt(tw[["created_at"]], tz = Sys.timezone())
    when <- strftime(when, format = "%H:%M %d/%m/%Y")
    write(sprintf("\"%s\" @ [%s]", rate, when), stdout())

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
