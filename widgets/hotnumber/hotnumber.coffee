class Dashing.Hotnumber extends Dashing.Widget
  @accessor 'current', Dashing.AnimatedValue

  @accessor 'difference', ->
    if @get('last')
      last = parseInt(@get('last'))
      current = parseInt(@get('current'))
      if last != 0
        diff = Math.abs(Math.round((current - last) / last * 100))
        "#{diff}%"
    else
      ""

  @accessor 'arrow', ->
    node = $(@node)
    value = parseInt(@get('current')) - parseInt(@get('last'))
    cool = parseInt node.data "cool"
    warm = parseInt node.data "warm"
    level = switch
      when value <= cool then 0
      when value >= warm then 4
      else 
        bucketSize = (warm - cool) / 3 # Total # of colours in middle
        Math.ceil (value - cool) / bucketSize
    backgroundClass = "hotness#{level}"
    lastClass = @get "lastClass"
    node.toggleClass "#{lastClass} #{backgroundClass}"
    @set "lastClass", backgroundClass    
    if @get('last')
      return 'icon-arrow-right' if parseInt(@get('current')) == parseInt(@get('last'))
      if parseInt(@get('current')) > parseInt(@get('last')) then 'icon-arrow-up' else 'icon-arrow-down'

  onData: (data) ->
    if data.status
      # clear existing "status-*" classes
      $(@get('node')).attr 'class', (i,c) ->
        c.replace /\bstatus-\S+/g, ''
      # add new class
      $(@get('node')).addClass "status-#{data.status}"
