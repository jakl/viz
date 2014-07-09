# Create a scale for width and height normalization
Template.ex3.rendered = ->
  main = ->
    width = window.innerWidth - 30
    height = window.innerHeight - 30

    svg = d3.select("svg").attr("width", width).attr("height", height)
    $('circle').remove()

    d3.json 'ex2.json', (data)->

      xScale = d3.scale.linear()
        .range [0, width]
        .domain d3.extent(data, (d)-> d.x)

      yScale = d3.scale.linear()
        .range [0, height]
        .domain d3.extent(data, (d)-> d.y)

      svg
        .selectAll('circle')
        .data(data)
        .enter()
        .append('circle')
        .attr 'cx', (d)-> xScale d.x
        .attr 'cy', (d)-> yScale d.y
        .attr 'r', (d)-> d.z

  $(window).resize(main)
  main()
