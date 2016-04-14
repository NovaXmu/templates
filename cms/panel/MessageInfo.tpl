<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>留言板电脑端</title>
	<link type="text/css" rel="stylesheet" href="css/bootstrap.css">
  <link type="text/css"  rel="stylesheet" href="css/css1.css">
	<script type="text/javascript" src="js/jquery-1.11.3.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript" src="js/js1.js"></script>
<style>
#btn-mes{
  width:100px;
}
tbody tr th button{
  margin-right:10px;

}

</style>
<script type="text/javascript">
  
</script>
</head>
<body> 

      <div class="row" style="margin-bottom:30px">
           <div class="btn btn-primary" id="all-message">全部留言</div>
           <div class="btn btn-danger" id="no-message">未处理留言</div>
      </div>
      <div class="row" id="row-1">
      
              <div class="panel panel-primary">
                  <div class="panel-heading">留言板(全部留言)</div>
                  <div class="panel-body">
                      <table class="table table-striped table-bordered table-hover">
                         <thead>
                           <tr>
                             <th>留言标识</th>
                             <th>留言类型</th>
                             <th>留言内容</th>
                             <th>关注度</th>
                             <th>留言创建时间</th>
                             <th>留言最后更新</th>
                             <th>是否已处理</th>
                             <th>留言者的联系方式</th>
                           
                           </tr>
                         </thead>
                         <tbody id="tr-container">
                           
                         </tbody>
                       </table>
                  </div>
                  <div class="panel-footer">版本所有:易班</div>
              </div>
      </div>
      <div class="row" id="row-2" >
              <div class="panel panel-danger">
                  <div class="panel-heading">留言板(未处理留言)</div>
                  <div class="panel-body">
                      <table class="table table-striped table-bordered table-hover">
                         <thead>
                           <tr>
                             <th>留言标识</th>
                             <th>留言类型</th>
                             <th>留言内容</th>
                             <th>关注度</th>
                             <th>留言最后更新</th>  
                             <th>留言者的联系方式</th>
                             <th>管理员选择处理留言</th>
                           </tr>
                         </thead>
                         <tbody>
                        
                       
                         </tbody>
                       </table>
                  </div>
                  <div class="panel-footer">版本所有:易班</div>
              </div>
      </div>
</body>

</html>