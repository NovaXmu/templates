<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8" />
    <title>网络文化节 | 实时大屏幕</title>
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">

    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>

    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="http://cdn.bootcss.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

    <link rel="stylesheet" type="text/css" href="{$base}rollcall/temp/css/animate.css">
    <link rel="stylesheet" type="text/css" href="{$base}rollcall/temp/css/rank.css">

</head>
<body>
    <div id="title">
        <h1>厦门大学首届校园网络文化节实时热度排行</h1>
    </div>
    <div class="row">
        <div id="top-rank" class="col-md-5">
            <div class="row">
                <img id="img-1st" class="rank col-md-4" src="{$base}rollcall/temp/img/1st.png">
                <p class="col-md-6" id="first"></p>
            </div>
            <div class="row">
                <img id="img-2nd" class="rank col-md-4" src="{$base}rollcall/temp/img/2nd.png">
                <p class="col-md-6" id="second"></p>
            </div>
            <div class="row">
                <img id="img-3rd" class="rank col-md-4" src="{$base}rollcall/temp/img/3rd.png">
                <p class="col-md-6" id="third"></p>
            </div>
        </div>
        <div id="rank" class="col-md-7">
            <div id="chart"></div>
        </div>
    </div>

</body>

<!-- ECharts单文件引入 -->
<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>

<script type="text/javascript">


var myChart = null;
// 路径配置
require.config({
    paths: {
        echarts: 'http://echarts.baidu.com/build/dist'
    }
});

// 使用
require(
    [
        'echarts',
        'echarts/chart/pie'
    ],
    function(ec) {
        // 基于准备好的dom，初始化echarts图表
        myChart = ec.init(document.getElementById('chart'));

        function update () {
            $.ajax({
                url: '/rollcall/api/data',
                dataType: 'json',
                success: function(data){
                    if (data.errno != 0) {
                        return ;
                    };
                    list = data.data;
                    var option = {
                        title: {
                            text: '实时热点图',
                            textStyle: {
                                color: '#FFFFFF',
                                fontSize: 40
                            },
                            x: 'center'
                        },
                        toolbox: {
                            show: false
                        },
                        calculable: true,
                        series: [{
                            name: '累计人数',
                            type: 'pie',
                            radius: [60, 150],
                            center: ['50%', '60%'],
                            roseType: 'area',
                            x: '50%', // for funnel
                            max: 40, // for funnel
                            sort: 'ascending', // for funnel
                            itemStyle : {
                                normal : {
                                    label : {
                                        textStyle : {
                                            fontSize : 30
                                        }
                                    }
                                }
                            },
                            data: []
                        }]
                    };
                    var array = []
                    for(k in list){
                        array.push({
                            name:k,
                            value: list[k].count
                        });
                    }
                    option.series[0].data = array;
                    myChart.setOption(option, true);

                    //更新排行榜
                    array = array.sort(function(a,b){
                        return b.value - a.value;
                    })
                    $('p#first').html(array[0].name);
                    $('p#second').html(array[1].name);
                    $('p#third').html(array[2].name);
                    setTimeout(update, 5000);
                }
            })
        }
        update();
    }
);

</script>

</html>

