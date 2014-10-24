$(function() {
  var drawPieChart, pie_graph_data;
  drawPieChart = (function() {
    function drawPieChart(options) {
      this.options = options;
      this.init();
    }

    drawPieChart.prototype.refreshTimeoutIdx = 0;

    drawPieChart.prototype.init = function() {
      var data, redrawFunc, wrapWidth, _i, _len, _ref;
      $('#' + this.options['render-to']).html('<canvas></canvas>');
      wrapWidth = $('#' + this.options['render-to']).width();
      if (wrapWidth < this.options['width']) {
        this.options['width'] = wrapWidth;
      }
      this.canvas = $('#' + this.options['render-to'] + ' canvas')[0];
      this.context = this.canvas.getContext('2d');
      this.canvas.style.background = this.options['background-color'];
      this.canvas.width = this.options['width'];
      this.canvas.height = this.options['height'];
      this.centerX = this.canvas.width / 2;
      this.centerY = this.canvas.height / 2;
      this.r = 40;
      this.context.lineWidth = this.options['line-width'];
      this.context.font = this.options['font-size'] + ' ' + this.options['font-family'];
      _ref = this.options['datas'];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        data = _ref[_i];
        this.drawPie(data);
      }
      redrawFunc = this;
      return $(window).resize(function() {
        var refreshTimeoutIdx;
        clearTimeout(refreshTimeoutIdx);
        return refreshTimeoutIdx = setTimeout(function() {
          return redrawFunc.init();
        }, 500);
      });
    };

    drawPieChart.prototype.drawPie = function(data) {
      var endAngle, startAngle;
      startAngle = 1.5 * Math.PI;
      endAngle = (1.5 - data['value'] / 100 * 2) * Math.PI;
      this.context.beginPath();
      this.context.arc(this.centerX, this.centerY, this.r, startAngle, endAngle, true);
      this.context.strokeStyle = data['line-color'];
      this.context.stroke();
      this.context.fillStyle = pie_graph_data['font-color'];
      this.context.fillText(data['value'] + '%', this.centerX + 10, this.centerY - this.r + 5);
      return this.r = this.r + 20;
    };

    return drawPieChart;

  })();
  pie_graph_data = {
    'render-to': 'statistics-pie-chart',
    'width': 340,
    'height': 260,
    'background-color': '#1f1f1f',
    'line-width': 15,
    'font-family': 'Open Sans',
    'font-size': '12px',
    'font-color': '#ffffff',
    'responsive': true,
    'datas': [
      {
        'value': 55,
        'line-color': '#636f80'
      }, {
        'value': 60,
        'line-color': '#fa6f57'
      }, {
        'value': 50,
        'line-color': '#009be0'
      }, {
        'value': 30,
        'line-color': '#1ab1aa'
      }
    ]
  };
  return new drawPieChart(pie_graph_data);
});
