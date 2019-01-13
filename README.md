# Dollr

Inspired in the sudden skyrocketting (+300% in 7 days) of the USD price related to the VES and the burden that represents looking for the rate manually I developed this R script to save some minutes of my time every week.

This script only depends (as of now) in [rtweet](https://airtmrates.com/), I intend to keep the dependencies to a minimum while maybe adding more sources in the future.

## Usage

Add this script to yout `PATH` and call it from the terminal, the optional argument identifies the source of the rate. If you give a non recognized source it displays a help message.

Example:

` dollr.r twitter `

The current supported sources of information are:

* `twitter`: Retrieves the rate from the last @MonitorDolarVe tweet. This is the default and may require your permission to use the twitter api.
* `airtm`: Gets all the USD/VES rates from [airtmrates.io](https://airtmrates.com/). **WIP**.

