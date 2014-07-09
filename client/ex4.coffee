# Create axis
Template.ex4.rendered = ->
  main = ->
    width = window.innerWidth - 30
    height = window.innerHeight - 30

    svg = d3.select("svg").attr("width", width).attr("height", height)
    $('circle').remove()
    $('g').remove()

    d3.json 'ex2.json', (data)->

      xScale = d3.scale.linear()
        .range [0, width]
        .domain d3.extent(data, (d)-> d.x)

      yScale = d3.scale.linear()
        .range [0, height]
        .domain d3.extent(data, (d)-> d.y)

      xAxis = d3.svg.axis()
        .scale(xScale)
        .orient('bottom')

      yAxis = d3.svg.axis()
        .scale(yScale)
        .orient('right')

      svg
        .selectAll('circle')
        .data(data)
        .enter()
        .append('circle')
          .attr 'cx', (d)-> xScale d.x
          .attr 'cy', (d)-> yScale d.y
          .attr 'r', (d)-> d.z

      svg.append('g')
        .attr('class', 'x axis')
        .call(xAxis)

      svg.append('g')
        .attr('class', 'y axis')
        .call(yAxis)

  $(window).resize(main)
  main()
