require('./assets/lib/piety')($, document)

## Memory Usage Widget
## By default displays the free Memory, inactive memory and active memory
## Based

## Colors Used by the chart
colors =
  free: '#1d2021'
  inactive: '#458588'
  active: '#fe8019'
  wired_down: '#cc241d'

  ## Another option
  # free: 'rgb(133, 188, 86)'

##  Width of the chart
chartWidth = 15

## Try 'donut'
chartType = 'pie'

refreshFrequency: 2000 # ms

command: """vm_stat | perl -ne '/page size of (\\d+)/ and $size=$1; /Pages\\s+([^:]+)[^\\d]+(\\d+)/ and printf("%s:%i,", "$1", $2 * $size / 1048576);'"""

render: (output) ->
  """
  <div class="mem">
    <span class="chart"></span>
    <span class='number'></span>
  </div>
  """

update: (output, el) ->
  ## Memory object
  mem = {}

  # Output looks similar to this:
  # free:1234,inactive:2345,active:3456
  output.split(',').forEach (item)->
    [key, value] = item.replace(' ', '_').split(':')
    mem[key] = Number(value)

  ## Set text to free + inactive
  $(".mem .number", el).text("  #{mem.free + mem.inactive}mb")

  ## Display active, free, and inactive on the chart
  $(".mem .chart", el).text("#{mem.wired_down},#{mem.active},#{mem.inactive},#{mem.free}").peity chartType,
    fill: [colors.wired_down, colors.active, colors.inactive, colors.free]
    width: chartWidth


style: """
  left: 75px+165px+14px
  top: 20px

  color: #ebdbb2
  font: 12px Hack Nerd Font, monospace, Helvetica Neue, sans-serif
  -webkit-font-smoothing: antialiased

  .number
    vertical-align top

  .chart
    vertical-align top
"""
