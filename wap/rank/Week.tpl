<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <title>厦门大学校园微信周排行榜</title>
  <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7; IE=EmulateIE9">
  <meta http-equiv="content-script-type" content="text/javascript">
  <meta name="viewport" content="width=device-width,initial-scale=1"/>
  
  <link href="../templates/wap/css/rank.css" rel="stylesheet">
</head>
<body>
  <div class="rich_media">
    <div class="rich_media_inner">
      <div class="rich_media_area_primary">
        <header>
          <h1 class="rich_media_title text-center">厦门大学校园微信周排行榜</h1>
        </header>
        <div class="rich_media_content">
          <div>
            <form class="text-center">
              <div class="form-group half">
                <label for="date">时间段</label>
                <select class="form-control" id="datepicker">
                  <option value="{$date_1}" selected="selected">{$date_1}</option>
                  <option value="{$date_2}">{$date_2}</option>
                  <option value="{$date_3}">{$date_3}</option>
                </select>
              </div>
              <div class="form-group half">
                <label for="category">分类</label>
                <select class="form-control category">
                  <option value="16282" selected="selected">厦大微信总榜</option>
                  <option value="1">行政机构</option>
                  <option value="2">学生社团</option>
                  <option value="3">学生组织</option>
                  <option value="4">自媒体</option>   
                </select>
              </div>
            </form><br/>
            <form class="text-center">
              <div class="form-group">
                <input type="button" name="rank_week" class="btn btn-primary" id="ranks" value="周排行">
              </div>
              <div class="form-group">
                <input type="button" name="rank_week" class="btn btn-primary" id="articles" value="周热文">
              </div>
            </form><br/>
          </div>
          <div class="text-center" id="end_date">
            <p>以下内容为{$rank_data.start_date}发布，截至{$rank_data.end_date}的统计数据</p>
          </div>
          <div>
            <table class="text-center">
              <tbody id="detail">
                <tr><td></td><td>公众号</td><td>发布</td><td>总阅读数</td><td>赞数</td><td>综合指数</td></tr>
                  {foreach $rank_data as $rank_row}
                    {if is_array($rank_row)}
                      <tr>
                      {foreach $rank_row as $key2 => $rank_content}
                        {if $key2 eq 'wx_nickname'}
                          <td><a href="rank?wx_name={$rank_row.wx_name}">{$rank_content}</a></td>
                        {elseif $key2 eq 'wx_name'}
                        {else}
                          <td>{$rank_content}</td>
                        {/if}
                      {/foreach}
                      </tr>
                    {/if}
                  {/foreach}
                </tbody>  
              </table>
            </div>
            <div id="hot_articles_all">
            </div>
            <div id="template" style="display:none;">
            <div class="msg_list">
              <div class="msg_list_bd">
                <div class="msg_wrapper">
                  <p class="msg_author"></p>
                  <div class="msg_inner_wrapper news_box">
                    <div class="msg_item multi_news">
                      <a class="msg_cover">                   
                        <div class="msg_cover">
                          <img style="visibility: visible !important;" >
                        </div>                       
                        <div class="msg_title_bar">
                          <h4 class="msg_title"></h4>
                        </div>                        
                      </a>  
                    </div>
                    <div class="msg_item_ft">
                          <div class="left form-group posttime"></div>
                          <div class="right form-group">
                            <i class="form-group">阅读数 </i>
                            <span class="readnum"> </span>
                            <i class="heart form-group"></i>
                            <span class="likenum"></span>
                          </div>
                        </div>                    
                  </div>
                </div>
              </div>
            </div> 
          </div>
          </div>
          <div class="footer">
            <hr>
            <div class="wrapper">
              <div class="credits">
                <p>Designed and built with all the love in the world by the Nova Studio.</p>
                <div class="crew"></div>
              </div>
              <div class="copyrights">
                <p>©<a href="http://wechatyiban.xmu.edu.cn/wap/joinus.html">Nova Studio</a>&nbsp;{$year}.All rights reserved.</p>
              </div>
            </div>
        </div>
      </div>
    </div>
  </div>

<script src="../templates/wap/js/jquery.min.js"></script>
<script src="../templates/wap/js/rank.js"></script>

</body>
</html>