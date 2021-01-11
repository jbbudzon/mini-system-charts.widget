require('./assets/lib/piety')($, document)

## CPU Usage Widget
## Based on https://github.com/Amar1729/nerdbar.widget/blob/master/cpu.coffee

## Colors Used by the chart
colors =
  low: '#689d6a'
  med: '#fe8019'
  high: '#cc241d'
  back: '#1d2021'

##  Width of the chart
chartWidth = 15

## Try 'pie'
chartType = 'donut'

refreshFrequency: 2000 # ms

command: "ESC=`printf \"\e\"`; ps -A -o %cpu | awk '{s+=$1} END {printf(\"%04.1f\",s/8);}'"

render: (output) ->
  """
  <div class="cpu">
    <span class="chart"></span>
    <span class='number'></span>
  </div>
  """

update: (output, el) ->
  cpu = Number(output)
  fill = colors.low

  ## Medium Threshold
  if cpu > 50
    fill = colors.med

  ## High Threshold
  if cpu > 80
    fill = colors.high

  ## Set Text
  $(".cpu .number", el).text("  #{output}%")

  ## Set Chart Data
  $(".cpu .chart", el).text("#{cpu}/100").peity chartType,
    fill: [fill, colors.back]
    width: chartWidth


style: """
  left: 10px+165px+14px
  top: 20px

  color: #ebdbb2
  font: 12px Hack Nerd Font, monospace, Helvetica Neue, sans-serif
  -webkit-font-smoothing: antialiased

  .number
    vertical-align top

  .chart
    vertical-align top
"""
