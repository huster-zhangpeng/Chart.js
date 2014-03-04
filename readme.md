Chart.js

#I want to let it can draw gantt picture.
=======
*Simple HTML5 Charts using the canvas element* [chartjs.org](http://www.chartjs.org)

<div>
    <canvas id="myChart1" width="800" height="400"></canvas>
<script type="text/javascript">
var data = {
  start: "2014-01-20",
  totalWeeks: 7,
  tasks: [{
    name: "Go to school",
    from: 0,
    to: 4
  },
  {
    name: "界面设计",
    from: 4,
    to: 6
  },
  {
    name: "数值分析",
    from: 5,
    to: 7
  },
  {
    name: "关卡设计",
    from: 4,
    to: 6
  }],
  pieData: [{
    value: 30,
    color:"#F38630"
  },
  {
    value : 50,
    color : "#E0E4CC"
  },
  {
    value : 100,
    color : "#69D2E7"
  }]
};
var ctx1 = document.getElementById("myChart1").getContext("2d");
var myNewChart = new Chart(ctx1).Gantt(data);
</script>
</div>

Documentation
-------
You can find documentation at [chartjs.org/docs](http://www.chartjs.org/docs).

License
-------
Chart.js was taken down on the 19th March. It is now back online for good and IS available under MIT license.

Chart.js is available under the [MIT license] (http://opensource.org/licenses/MIT).
