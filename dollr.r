#! /usr/bin/Rscript
# Get the parallel USD/VES rate from airtmrates.com
#
# This script depends on the following packages:
#   knitr

cmdargs <- commandArgs(trailingOnly=TRUE)

if (length(cmdargs) == 0) {
    cmdargs <- "airtm"
}

init <- function(msg) write(sprintf("Fetching %s\n", msg), stdout())

if (cmdargs[1] == "airtm") {
    init("airtmrates' rates.")

    rt <- read.csv("https://airtmrates.com/rates")
    rt <- rt[grep("VES", rt$Code), c("Method", "Rate", "Buy", "Sell")]
    write_rate <- function(rate = rt) {
        write(knitr::kable(rate, row.names = FALSE), stdout()) 
    }

    when <- strftime(Sys.time(), format = "%H:%M %d/%m/%Y")

} else {
    # Help Message
    if (cmdargs[1] != "help") {
        write(sprintf("Unrecognized argument \"%s\"\n", cmdargs[1]), stdout())
    }
    cmdargs <- "help"
    help_msg <- paste(
        "Retreive from the internet the current USD/VES price",
        "Usage: dollar [SOURCE]",
        "Example: dollar airtm\n",
        "The current supported SOURCE values are:",
        "\tairtm\tGets the price from airtmrates.com (The default)",
        "\ttwitter\tGets the price from the last @MonitorDolarVe tweet.",
        "\tAny other value will return this help message",
        sep = "\n"
    )
    write(help_msg, stdout())

}

if (cmdargs != "help") {
    write(sprintf("USD/VES rates @ [%s]\n", when), stdout())
    write_rate()

}
