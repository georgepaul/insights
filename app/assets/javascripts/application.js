// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

  function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Ticker', 'Total Mentions', 'Unique Mentions', '@Beginning' , '@End'],
          ['ATWT', 1000, 400, 200,678],
          ['MDMN', 1170, 460, 250,675],
          ['TSNP', 660, 1120, 300,567],
          ['BORK', 1030, 540, 350,567]
        ]);

        var options = {
          chart: {
            title: 'Ticker By Mentions',
            subtitle: 'Ticker Metrics by mentions',
          },
          bars: 'horizontal', // Required for Material Bar Charts.
          hAxis: {format: 'decimal'},
          height: 400,
          colors: ['#1b9e77', '#d95f02', '#3b5998','#777777']
        };

        var chart = new google.charts.Bar(document.getElementById('chart_div'));

        chart.draw(data, google.charts.Bar.convertOptions(options));

        var btns = document.getElementById('btn-group');

        btns.onclick = function (e) {

          if (e.target.tagName === 'BUTTON') {
            options.hAxis.format = e.target.id === 'none' ? '' : e.target.id;
            chart.draw(data, google.charts.Bar.convertOptions(options));
          }
        }
      }