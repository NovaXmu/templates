<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>网络文化节 | 热度榜</title>
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">

    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>

    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="http://cdn.bootcss.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
</head>
<body style="background-color: #131313;">
<div class="container">
    <div class="row text-center" style="color: red;">
        <h1>校园网络文化节<br>实时热度排行</h1>
    </div>
    <div class="row">
        <table class="table table-responsive">
            <tbody id="list" style="color: #9d9d9d;">

            </tbody>
        </table>
    </div>
</div>

<script type="text/javascript">

$.ajax({
    url: '/rollcall/api/data',
    dataType: 'json',
    success: function(data){
        if (data.errno != 0) {
            return ;
        };
        list = data.data;

        var array = []
        for(k in list){
            array.push({
                name:k,
                count: list[k].count
            });
        }
        array = array.sort(function(a,b){
            return b.count - a.count;
        })
        var html = '';
        var rank = 1;
        for(i in array) {
            html += '<tr><td>第'+rank+'名</td><td style="color: #0af;">'+array[i].name+'</td><td>'+array[i].count+'人</td></tr>';
            rank++;
        }
        $('tbody#list').html(html);
    }
});

</script>
</body>
</html>
