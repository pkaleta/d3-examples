MIN_VAL = 10
MAX_VAL = 90
t = 0
v = 50
w = 20
h = 80

randomWalk = () ->
  time: t++
  value: ~~Math.max(MIN_VAL, Math.min(MAX_VAL, v + 10 * (Math.random() - .5)))


x = d3.scale.linear()
      .domain([0, 1])
      .range([0, w])

y = d3.scale.linear()
      .domain([0, 100])
      .rangeRound([0, h])

update = (chart, data) ->
  rects = chart.selectAll("rect")
    .data(data, (d) -> d.time)

  rects.enter()
    .insert("rect", "line")
      .attr("x", (d, i) -> x(i + 1))
      .attr("y", (d) -> h - y(d.value) - .5)
      .attr("width", w)
      .attr("height", (d) -> y(d.value))
    .transition()
      .duration(1000)
      .attr("x", (d, i) -> x(i))

  rects.transition()
    .duration(1000)
      .attr("x", (d, i) -> x(i))

  rects.exit()
    .transition()
      .duration(1000)
      .attr("x", x(i - 1))
    .remove()

$ ->
  data = (randomWalk() for i in d3.range(40))

  chart = d3.select("body").append("svg")
    .attr("class", "chart")
    .attr("width", w * data.length)
    .attr("height", h)

  chart.selectAll("rect")
    .data(data)
    .enter().append("rect")
      .attr("x", (d, i) -> x(i))
      .attr("y", (d) -> h - y(d.value) - .5)
      .attr("width", w)
      .attr("height", (d) -> y(d.value))

  chart.append("line")
    .attr("x1", 0)
    .attr("y1", h)
    .attr("x2", w * data.length)
    .attr("y2", h)
    .style("stroke", "#000");

  setInterval(
    () ->
      data.shift()
      data.push(randomWalk())
      update(chart, data)
    , 1500)