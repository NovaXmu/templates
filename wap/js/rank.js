$(document).ready(function() {

    $("input:button[name='rank_day'],input:button[name='rank_week']").click(function() {

        var type = $(this).attr('id');
        var gid = $('select.category').val();
        var datepicker = $('#datepicker').val();
        var result = '';
        var if_week = '0';

        if ($(this).attr('name') == 'rank_week') {
            if_week = '1';
        };
        $.getJSON("rank", {
            type: type,
            gid: gid,
            date: datepicker,
            page: '1',
            end: if_week
        },
        function(data) {
            $('#end_date').html("<p>以下内容为" + data['start_date'] + "发布，截至" + data['end_date'] + "的统计数据</p>");
            if (type == 'ranks') {
                result += "<tr><td></td><td>公众号</td><td>发布</td><td>总阅读数</td><td>赞数</td><td>综合指数</td></tr>";
                $.each(data,
                function(k, row) {
                    if ((k != 'start_date') && (k != 'end_date')) {
                        result += '<tr>';
                        $.each(row,
                        function(k1, v1) {
                            if (k1 == 'wx_nickname') {
                                result += "<td><a href=\"rank?wx_name=" + row['wx_name'] + "\">" + v1 + "</a></td>";
                            } else if (k1 == 'wx_name') {} else {
                                result += '<td>' + v1 + '</td>';
                            };
                        });
                        result += '</tr>';
                    };
                });
                $("#detail").html(result);
                $("#hot_articles_all").html('');
            } else if (type == 'articles') {
                result += "<div class=\"hot_articles\">";
                htmlTemp = $("textarea").value;
                                    
                $.each(data,
                function(k , row) {
                    
                  if ((k != 'start_date') && (k != 'end_date')) {

                    var msg = $("#template").clone();
                    msg.find(".msg_author").text(row.wx_nickname);
                    msg.find("a").attr("href",row.url);
                    msg.find(".msg_title").text(row.title);
                    msg.find(".msg_cover").attr("href",row.url);
                    msg.find("img").attr("href",row.url);
                    msg.find("img").attr("src",row.picurl);
                    msg.find(".posttime").text(row.posttime);
                    msg.find(".readnum").text(row.readnum);
                    msg.find(".likenum").text(row.likenum);

                    result += msg.html();
                    
                    };
                });

                result += "</div><br/><div class=\"text-right\"><input type=\"button\" page='1' id=\"more\" value=\"加载更多\"></div>";
                $("#detail").html('');
                $("#hot_articles_all").html(result);
            }
            //热视预留
            else {

            };
        });
    });
    $("body").on("click", "input[id='more']",
    function() {

        var datepicker = $('#datepicker').val();
        var gid = $('select.category').val();
        var page = $("input[id='more']").attr('page');
        var if_week = '0';
        var result = '';

        page = parseInt(page) + 1;
        $("input[id='more']").attr('page', page);
        if ($("input:button[id='articles']").attr('name') == 'rank_week') {
            if_week = '1';
        };
        $.getJSON("rank", {
            type: 'articles',
            gid: gid,
            date: datepicker,
            page: page,
            end: if_week
        },
        function(data) {
            $('#end_date').html("<p>以下内容为" + data['start_date'] + "发布，截至" + data['end_date'] + "的统计数据</p>");
            result += "<div class=\"hot_articles\">";
            if(data[0] == undefined){
              $('#more').val('木有了~');
              $('#more').attr("id" , 'last');
            };
            $.each(data,
            function(k, row) {
                if ((k != 'start_date') && (k != 'end_date')) {
                    
                    var msg = $("#template").clone();
                    msg.find(".msg_author").text(row.wx_nickname);
                    msg.find("a").attr("href",row.url);
                    msg.find(".msg_title").text(row.title);
                    msg.find(".msg_cover").attr("href",row.url);
                    msg.find("img").attr("href",row.url);
                    msg.find("img").attr("src",row.picurl);
                    msg.find(".posttime").text(row.posttime);
                    msg.find(".readnum").text(row.readnum);
                    msg.find(".likenum").text(row.likenum);

                    result += msg.html();
                };
            });
            result += "</div><br/>";
            $("#more").parent().before(result);
        });
    });
});