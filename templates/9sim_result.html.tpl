<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>{{symbol}} sim result</title>
  <style type="text/css">
  html, body {
    width: 100%;
    height: 100%;
    margin: 0px;
  }

  #chartdiv {
      width: 100%;
      height: 100%;
  }


#chartdiv2 {
  width: 100%;
  height: 500px;
}

#chartdiv3 {
  width: 100%;
  height: 500px;
}


body {
  background-color: #ffffff;
}
body * {
  box-sizing: border-box;
}

.header {
  background-color: #327a81;
  color: white;
  font-size: 1.5em;
  padding: 1rem;
  text-align: center;
  text-transform: uppercase;
}

img {
  border-radius: 50%;
  height: 60px;
  width: 60px;
}

.table-users {
  border: 1px solid #327a81;
  border-radius: 10px;
  box-shadow: 3px 3px 0 rgba(0, 0, 0, 0.1);
  max-width: calc(100% - 2em);
  margin: 1em auto;
  overflow: hidden;
  width: 800px;
}

table {
  width: 100%;
}
table td, table th {
  color: #2b686e;
  padding: 10px;
}
table td {
  text-align: left;
  vertical-align: middle;
}
table td:last-child {
  font-size: 0.95em;
  line-height: 1.4;
  text-align: left;
}
table th {
  background-color: #daeff1;
  font-weight: 300;
}
table tr:nth-child(2n) {
  background-color: white;
}
table tr:nth-child(2n+1) {
  background-color: #edf7f8;
}

@media screen and (max-width: 700px) {
  table, tr, td {
    display: block;
  }

  td:first-child {
    position: absolute;
    top: 50%;
    -webkit-transform: translateY(-50%);
            transform: translateY(-50%);
    width: 100px;
  }
  td:not(:first-child) {
    clear: both;
    margin-left: 100px;
    padding: 4px 20px 4px 90px;
    position: relative;
    text-align: left;
  }
  td:not(:first-child):before {
    color: #91ced4;
    content: '';
    display: block;
    left: 0;
    position: absolute;
  }
  td:nth-child(2):before {
    content: 'Name:';
  }
  td:nth-child(3):before {
    content: 'Email:';
  }
  td:nth-child(4):before {
    content: 'Phone:';
  }
  td:nth-child(5):before {
    content: 'Comments:';
  }

  tr {
    padding: 10px 0;
    position: relative;
  }
  tr:first-child {
    display: none;
  }
}
@media screen and (max-width: 500px) {
  .header {
    background-color: transparent;
    color: white;
    font-size: 2em;
    font-weight: 700;
    padding: 0;
    text-shadow: 2px 2px 0 rgba(0, 0, 0, 0.1);
  }

  img {
    border: 3px solid;
    border-color: #daeff1;
    height: 100px;
    margin: 0.5rem 0;
    width: 100px;
  }

  td:first-child {
    background-color: #c8e7ea;
    border-bottom: 1px solid #91ced4;
    border-radius: 10px 10px 0 0;
    position: relative;
    top: 0;
    -webkit-transform: translateY(0);
            transform: translateY(0);
    width: 100%;
  }
  td:not(:first-child) {
    margin: 0;
    padding: 5px 1em;
    width: 100%;
  }
  td:not(:first-child):before {
    font-size: .8em;
    padding-top: 0.3em;
    position: relative;
  }
  td:last-child {
    padding-bottom: 1rem !important;
  }

  tr {
    background-color: white !important;
    border: 1px solid #6cbec6;
    border-radius: 10px;
    box-shadow: 2px 2px 0 rgba(0, 0, 0, 0.1);
    margin: 0.5rem 0;
    padding: 0;
  }

  .table-users {
    border: none;
    box-shadow: none;
    overflow: visible;
  }
}



  </style>
</head>
<body>
<script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
<script src="https://www.amcharts.com/lib/3/serial.js"></script>
<script src="https://www.amcharts.com/lib/3/amstock.js"></script>
<script src="https://d3js.org/d3.v4.min.js"></script>
<script src="https://www.amcharts.com/lib/3/plugins/export/export.min.js"></script>
<script src="https://www.amcharts.com/lib/4/core.js"></script>
<script src="https://www.amcharts.com/lib/4/charts.js"></script>
<script src="https://www.amcharts.com/lib/4/themes/animated.js"></script>
<link rel="stylesheet" href="https://www.amcharts.com/lib/3/plugins/export/export.css" type="text/css" media="all" />
<h2 style="color: #2e6c80; text-align: center;">Candelstick and Stock Events
</h2>
<div id="chartdiv"></div>
<h2 style="color: #2e6c80; text-align: center;">Buy &amp; Hold&nbsp; &nbsp; VS&nbsp; &nbsp;Strategy</h2>
<div id="chartdiv2"></div>
<h2 style="color: #2e6c80; text-align: center;">Quantum performance</h2>
<div id="chartdiv3"></div>

  <script>
var withData = function (data, trades, options) {
data=data.reverse();
close_ref=data[0].close;
data = data.map(function (d) {
  d.date = new Date(d.time)
  if (typeof d.bollinger === 'object') {
    d.upperBound=d.bollinger.upperBound
    d.midBound=d.bollinger.midBound
    d.lowerBound=d.bollinger.lowerBound
  }
  d.close_norm=d.close/close_ref
  return d
})


rem_index=[];

trades = trades.map(function (t,index) {

  t.date = new Date(t.time)
  if (t.side === "buy") {
    t.arrows="arrowUp";
    t.background="#00CC00"
  }
  if (t.side === "sell") {
    t.arrows="arrowDown";
    t.background="#ff0000"
  }
  if (t.time===null) {
      rem_index.push(index)
   }


  return t
})

rem_index.reverse().forEach(function(element) {
  trades.splice(element,1);
  });

trades = trades.map(function (t,index) {

    t.open=t.price;
    t.close=t.price;
    t.high=t.price;
    t.low=t.price;
    t.volume=0;
    // t.upperBound=t.price;
    // t.midBound=t.price;
    // t.lowerBound=t.price;
    return t
  })
  console.log(trades)

var data_trades = data.concat(trades);
console.log(data_trades)
init_currency=[];init_asset=[];init_currency[0]=10000;init_asset[0]=1;
var i;stock_Events=[];graph_realcapital=[];graph_quantum=[]
for (i = 0; i < trades.length; i++) {
  stock_Events.push ({
    "date": trades[i].date,
    "type": trades[i].arrows,
    "backgroundColor": trades[i].background,
    "graph": "g1",
    "description": trades[i].id
  });
if (trades[i].side==="buy") {
  stepC_c= -1*parseFloat(trades[i].value)
  stepC_a= parseFloat(trades[i].size)
}
if (trades[i].side==="sell") {
  stepC_c= parseFloat(trades[i].value)
  stepC_a= -1*parseFloat(trades[i].size)
}
if (i===0) {
  init_asset[i]=init_asset[0]
  init_currency[i]=init_currency[0]
  realcapital= (init_asset[i]*data[i].close+init_currency[i])/(init_asset[0]*data[0].close+init_currency[0])
  } else {
    init_asset[i]=init_asset[i-1]+stepC_a
    init_currency[i]=init_currency[i-1]+stepC_c
    realcapital= (init_asset[i]*trades[i].price+init_currency[i])/(init_asset[0]*data[0].close+init_currency[0])
    }
  graph_realcapital.push ({
      "value":realcapital,
      "date": trades[i].date
    })

  if (trades[i].profit !==null) {
    graph_quantum.push ({
        "id":trades[i].id,
        "profit":trades[i].profit
      })
      }
}

var chart = AmCharts.makeChart( "chartdiv", {
  "type": "stock",
  "theme": "light",
  //"dataDateFormat" : "YYYY-MM-DD",
  "categoryAxesSettings": {
    "minPeriod": "mm"
  },

  "dataSets": [ {
    "fieldMappings": [ {
      "fromField": "open",
      "toField": "open"
    }, {
      "fromField": "close",
      "toField": "close"
    }, {
      "fromField": "high",
      "toField": "high"
    }, {
      "fromField": "low",
      "toField": "low"
    }, {
      "fromField": "volume",
      "toField": "volume"
    }, {
      "fromField": "upperBound",
      "toField": "upperBound"
    },{
      "fromField": "lowerBound",
      "toField": "lowerBound"
    } ,{
      "fromField": "midBound",
      "toField": "midBound"
    } ],

    "color": "#7f8da9",
    "dataProvider": data_trades,
//    "title": "BTC-EUR",
    "categoryField": "date",
    "stockEvents": stock_Events


  }

],


  "panels": [ {
      "title": "Value",
      "showCategoryAxis": false,
      "percentHeight": 70,
      "recalculateToPercents":"never",
      // "valueAxes": [ {
      //   "dashLength": 5
      // } ],
      //
      // "categoryAxis": {
      //   "dashLength": 5
      // },

      "stockGraphs": [ {
        "id": "g1",
        "balloonText": "Open:<b>[[open]]</b><br>Low:<b>[[low]]</b><br>High:<b>[[high]]</b><br>Close:<b>[[close]]</b><br>",
        "closeField": "close",
        "fillColors": "#56d317",
        "highField": "high",
        "lineColor": "#000000",
        "lineAlpha": 1,
        "lowField": "low",
        "fillAlphas": 0.9,
        "negativeFillColors": "#ff0000",
        "negativeLineColor": "#000000",
        "openField": "open",
        "title": "Price:",
        "type": "candlestick",
        // "valueField": "high",
        // "comparable": true,
        // "compareField": "open2"
      },
      {
        "id": "g2",
        "bullet": "round",
        "bulletBorderAlpha": 1,
        "bulletColor": "#00FF00",
        "bulletSize": 5,
        "hideBulletsCount": 50,
        "lineThickness": 1,
        "title": "media",
        "useLineColorForBulletBorder": true,
        "lineColor": "#f44242",
        "valueField": "midBound"
      },{
        "id": "g3",
        "bullet": "round",
        "bulletBorderAlpha": 1,
        "bulletColor": "#00FF00",
        "bulletSize": 5,
        "hideBulletsCount": 50,
        "lineThickness": 2,
        "title": "upperBound",
        "useLineColorForBulletBorder": true,
        "lineColor": "#426ed1",
        "valueField": "upperBound"
      },{
        "id": "g4",
        "bullet": "round",
        "bulletBorderAlpha": 1,
        "bulletColor": "#00FF00",
        "bulletSize": 5,
        "hideBulletsCount": 50,
        "lineThickness": 2,
        "title": "lowerBound",
        "useLineColorForBulletBorder": true,
        "lineColor": "#426ed1",
        "valueField": "lowerBound"
      },
      {
        "id": "fromGraph",
        "lineAlpha": 0,
        "fillColors": "#91b3ff",
        "showBalloon": false,
        "valueField": "lowerBound",
        "fillAlphas": 0
        },{
        "fillAlphas": 0.2,
        "fillColors": "#91b3ff",
        "fillToGraph": "fromGraph",
        "lineAlpha": 0,
        "showBalloon": false,
        "valueField": "upperBound"
        },
        {
          "id": "g5",
          "bullet": "round",
          "bulletBorderAlpha": 1,
          "bulletColor": "#00FF00",
          "bulletSize": 5,
          "hideBulletsCount": 50,
          "lineThickness": 2,
          "title": "open2",
          "useLineColorForBulletBorder": true,
          "lineColor": "#426ed1",
          "valueField": "open2"
          }
      ],

      "stockLegend": {
        "valueTextRegular": "[[value]]",
        "valueWidth": 140
      //   "periodValueTextComparing": "[[percents.value.close]]%"
      }
    },

    {
      "title": "Volume",
      "percentHeight": 30,
      "marginTop": 1,
      "showCategoryAxis": true,
      "valueAxes": [ {
        "dashLength": 5
      } ],

      "categoryAxis": {
        "dashLength": 5
      },

      "stockGraphs": [ {
        "valueField": "volume",
        "type": "column",
        "showBalloon": false,
        "fillAlphas": 1
      } ],

      "stockLegend": {
        "markerType": "none",
        "markerSize": 0,
        "labelText": "",
        "periodValueTextRegular": "[[value.close]]"
      }
    }
  ],

  "chartScrollbarSettings": {
    "graph": "g1",
    "graphType": "line",
    "usePeriod": "hh"
  },
  // "dataSetSelector": {
  //   "position": "left"
  // },
  "periodSelector": {
    "position": "top",
    "dateFormat": "YYYY-MM-DD JJ:NN",
    "inputFieldWidth": 150,
    "periods": [ {
      "period": "hh",
      "count": 1,
      "label": "1 hour"

    }, {
      "period": "hh",
      "count": 2,
      "label": "2 hours"
    }, {
      "period": "hh",
      "count": 5,
      "label": "5 hour"
    }, {
      "period": "hh",
      "count": 12,
      "label": "12 hours"
    }, {
      "period": "MAX",
      "label": "MAX",
      "selected": true
    } ]
  }
} );


// Themes begin
am4core.useTheme(am4themes_animated);
// Themes end

// Create chart instance
var chart = am4core.create("chartdiv2", am4charts.XYChart);

// Add data
//chart.data = data;



// Create axes
var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());

// Create series
var series = chart.series.push(new am4charts.LineSeries());
series.dataFields.valueY = "close_norm";
series.dataFields.dateX = "date";
series.tooltipText = "{value}"
series.strokeWidth = 2;
series.minBulletDistance = 15;
series.data = data;
series.name = "Buy & Hold";


// Drop-shaped tooltips
series.tooltip.background.cornerRadius = 20;
series.tooltip.background.strokeOpacity = 0;
series.tooltip.pointerOrientation = "vertical";
series.tooltip.label.minWidth = 40;
series.tooltip.label.minHeight = 40;
series.tooltip.label.textAlign = "middle";
series.tooltip.label.textValign = "middle";

// Make bullets grow on hover
var bullet = series.bullets.push(new am4charts.CircleBullet());
bullet.circle.strokeWidth = 2;
bullet.circle.radius = 4;
bullet.circle.fill = am4core.color("#fff");

var bullethover = bullet.states.create("hover");
bullethover.properties.scale = 1.3;

// Make a panning cursor
chart.cursor = new am4charts.XYCursor();
chart.cursor.behavior = "panXY";
chart.cursor.xAxis = dateAxis;
chart.cursor.snapToSeries = series;


// Create series
var series2 = chart.series.push(new am4charts.LineSeries());
series2.dataFields.valueY = "value";
series2.dataFields.dateX = "date";
series2.tooltipText = "{value}"
series2.strokeWidth = 2;
series2.minBulletDistance = 15;
series2.data = graph_realcapital;
series2.name = "Strategy";

// Create vertical scrollbar and place it before the value axis
chart.scrollbarY = new am4core.Scrollbar();
chart.scrollbarY.parent = chart.leftAxesContainer;
chart.scrollbarY.toBack();

// Create a horizontal scrollbar with previe and place it underneath the date axis
chart.scrollbarX = new am4charts.XYChartScrollbar();
chart.scrollbarX.series.push(series);
chart.scrollbarX.parent = chart.bottomAxesContainer;

chart.events.on("ready", function () {
  dateAxis.zoom({start:0.79, end:1});


  // Add legend
  chart.legend = new am4charts.Legend();
  chart.legend.position = "top";


  chart.dateFormatter.dateFormat = "d MMM, yyyy";
});



// Themes begin
am4core.useTheme(am4themes_animated);
// Themes end

// Create chart instance
var chart = am4core.create("chartdiv3", am4charts.XYChart);

// Add data
chart.data = graph_quantum;

// Use only absolute numbers
//chart.numberFormatter.numberFormat = "#.#s";

// Create axes
var categoryAxis = chart.yAxes.push(new am4charts.CategoryAxis());
categoryAxis.dataFields.category = "id";
categoryAxis.renderer.grid.template.location = 0;
categoryAxis.renderer.inversed = true;

var valueAxis = chart.xAxes.push(new am4charts.ValueAxis());
valueAxis.extraMin = 0.1;
valueAxis.extraMax = 0.1;
valueAxis.renderer.minGridDistance = 40;
valueAxis.renderer.ticks.template.length = 5;
valueAxis.renderer.ticks.template.disabled = false;
valueAxis.renderer.ticks.template.strokeOpacity = 0.4;



var win = chart.series.push(new am4charts.ColumnSeries());
win.dataFields.valueX = "profit";
win.dataFields.categoryY = "id";
win.clustered = false;

var winLabel = win.bullets.push(new am4charts.LabelBullet());
winLabel.label.text = "{valueX}";
winLabel.label.hideOversized = false;
winLabel.label.truncate = false;
winLabel.label.horizontalCenter = "left";
winLabel.label.dx = 10;




}
  </script>
  <script>
{{code}}
withData(data, trades, options)
  </script>

  <div  class="table-users">
     <div class="header">STATISTICS</div>

     <table cellspacing="0">


        <tr>
           <td>End balance:</td>
           <td><script>document.write("test");</script></td>
        </tr>

        <tr>
           <td>End balance:</td>
           <td><script>document.write("test");</script></td>
        </tr>

        
     </table>
  </div>
  <pre><code>{{output}}</code></pre>
</body>
</html>
