Chart.js

#It can draw gantt image now!
=======
*Simple HTML5 Charts using the canvas element* [chartjs.org](http://www.chartjs.org)

Sample
-------
请下载Chart.min.js, test.js, test.html到本地同一目录下，然后打开test.html即可查看效果

How to use
-------
使用方式同Chart.js一样：
```html

    <canvas id="myChart1" width="800" height="400"></canvas>

    var ctx1 = document.getElementById("myChart1").getContext("2d");
    var myNewChart = new Chart(ctx1).Gantt(data);
```
**数据结构**
```js 
var data = {
  start: "2014-01-20",
  totalWeeks: 7,
  tasks: [{
    name: "Today I need go to school",
    from: 0,
    to: 4
  },
  {
    name: "界面设计",
    from: 4,
    to: 7
  },
  {
    name: "数值分析",
    from: 3,
    to: 5
  },
  {
    name: "数值分析",
    from: 5,
    to: 7
  }
}
````



Documentation
-------
You can find documentation at [chartjs.org/docs](http://www.chartjs.org/docs).

License
-------
Chart.js was taken down on the 19th March. It is now back online for good and IS available under MIT license.

Chart.js is available under the [MIT license] (http://opensource.org/licenses/MIT).
