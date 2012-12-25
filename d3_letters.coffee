update = (svg, data) ->
  # DATA JOIN
  # Join new data with old elements, if any.
  text = svg.selectAll("text")
    .data(data, (d) -> d)

  console.log(text)

  # UPDATE
  # Update old elements as needed.
  text.attr("class", "update")
    .transition()
      .duration(750)
      .attr("x", (d, i) -> i * 32)

  # ENTER
  # Create new elements as needed.
  text.enter().append("text")
      .attr("class", "enter")
      .attr("dy", ".35em")
      .text((d) -> d)
      .attr("x", (d, i) -> i * 32)
      .attr("y", -60)
      .style("fill-opacity", 1e-6)
    .transition()
      .duration(750)
      .attr("y", 0)
      .style("fill-opacity", 1)


  # EXIT
  # Remove old elements as needed.
  text.exit()
      .attr("class", "exit")
    .transition()
      .duration(750)
      .attr("y", 60)
      .style("fill-opacity", 1e-6)
      .remove()

# Shuffles the input array.
shuffle = (array) ->
  m = array.length
  while m
    i = Math.floor(Math.random() * m--)
    t = array[m]
    array[m] = array[i]
    array[i] = t

  array;


$ ->
  alphabet = "abcdefghijklmnopqrstuvwxyz".split("")

  width = 960
  height = 500

  svg = d3.select("body")
    .append("svg")
      .attr("width", width)
      .attr("height", height)
    .append("g")
      .attr("transform", "translate(32, #{ (height / 2) })")

  # The initial display.
  update(svg, alphabet)

  # Grab a random sample of letters from the alphabet, in alphabetical order.
  setInterval(
    () ->
      newData = shuffle(alphabet)
        .slice(0, Math.floor(Math.random() * 26))
        .sort()
      console.log(newData)
      update(svg, newData)
    1000)
