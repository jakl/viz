# Create line chart
Template.ex5.rendered = ->
  main = ->
    width = window.innerWidth - 30
    height = window.innerHeight - 30

    svg = d3.select("svg").attr("width", width).attr("height", height)
    $('circle').remove()
    $('g').remove()

    format = d3.time.format("%d %b %Y")

    d3.svg.line()
      .x (d)-> xScale(+d.key)
      .y (d)-> yScale(d.values)

    d3.text "followers.tsv", (data) ->
      data = d3.tsv.parseRows(data).map (row) ->
        day: Math.round(+row[0] / (60 * 60 * 24))
        followers: 1

      data = d3.nest().key (d) -> d.day
        .rollup (followers) -> followers.length
        .entries(data)

      data = data.map (d) ->
        key: +d.key
        values: d.values
      .sort (a, b) -> a.key - b.key

      xScale = d3.scale.linear()
        .range [0, width]
        .domain d3.extent(data, (d)-> +d.key)

      yScale = d3.scale.linear()
        .range [0, height]
        .domain d3.extent(data, (d)-> d.values)

      xAxis = d3.svg.axis()
        .scale(xScale)
        .orient('bottom')
        .tickFormat (d)-> format new Date(d * 60 * 60 * 24 * 1000)

      yAxis = d3.svg.axis()
        .scale(yScale)
        .orient('right')

      svg.append('g')
        .attr('class', 'x axis')
        .call(xAxis)

      svg.append('g')
        .attr('class', 'y axis')
        .call(yAxis)

      svg.append('path')
        .attr('class', 'line')
        .attr('d', line)

  $(window).resize(main)
  main()
