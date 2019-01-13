#! /usr/bin/Rscript
# Get the parallel USD/VES rate from airtmrates.com or @MonitorDolarVe
# Defaults to AirTM's rate because is faster
#
# This script depends on the following packages:
#   rtweet
#   knitr

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
    write(sprintf("USD/VES rates @ [%s]", when), stdout())
    write(sprintf("%s", rate), stdout())

} else if (cmdargs[1] == "airtm") {
    # AirTM
    write("Retreiving airtmrates' rates.", stdout())
    rates <- read.csv("https://airtmrates.com/rates")
    rates <- rates[grep("VES", rates$Code), c("Method", "Rate", "Buy", "Sell")]
    when <- strftime(Sys.time(), format = "%H:%M %d/%m/%Y")
    write(sprintf("USD/VES rates @ [%s]", when), stdout())
    write(knitr::kable(rates, row.names = FALSE), stdout())

} else {
    # Help Message
    help_msg <- paste(
        "Retreive from the internet the current USD/VES price",
        "Usage: dollar [SOURCE]",
        "Example: dollar airtm\n",
        "The current supported SOURCE values are:",
        "\tairtm\tGets the price from airtmrates.com",
        "\ttwitter\tGets the price from the last @MonitorDolarVe tweet. (The default)",
        "\tAny other value will return this help message",
        sep = "\n"
    )
    write(help_msg, stdout())

}
