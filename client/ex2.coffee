# 1.- Fetch json data from file 'ex2.json' and bind circles to it
# Documentation: https://github.com/mbostock/d3/wiki/Requests#d3_json

Template.ex2.rendered = ->
  svg = d3.select("body").append("svg").attr("width", 800).attr("height", 400)

  d3.json 'ex2.json', (data)->
    svg
      .selectAll('circle')
      .data(data)
      .enter()
      .append('circle')
      .attr('cx', (d)-> d.x)
      .attr('cy', (d)-> d.y)
      .attr('r', (d)-> d.z)
