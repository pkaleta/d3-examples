(function() {

  $(function() {
    var matrix, td, tr;
    matrix = [[11975, 5871, 8916, 2868], [1951, 10048, 2060, 6171], [8010, 16145, 8090, 8045], [1013, 990, 940, 6907]];
    tr = d3.select("body").append("table").selectAll("tr").data(matrix).enter().append("tr");
    return td = tr.selectAll("td").data(function(d) {
      return d;
    }).enter().append("td").text(function(d) {
      return d;
    });
  });

}).call(this);
