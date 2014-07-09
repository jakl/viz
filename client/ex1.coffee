Template.ex1.rendered = ->
  d3.selectAll("circle").attr "r", ->
    @getAttribute "data-value"
