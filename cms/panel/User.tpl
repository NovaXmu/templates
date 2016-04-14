<div class="row">
  <h4>用户管理
    <p style="float: right; margin-left: 10px;">厦大绑定数:&nbsp;&nbsp;<span class="label label-success">{$linkCount['xmuLinkCount']}</span></p>
    <p style="float: right; margin-left: 10px;">易班绑定数:&nbsp;&nbsp;<span class="label label-success">{$linkCount['yibanLinkCount']}</span></p>
    <p style="float: right; margin-left: 10px;">总绑定数:&nbsp;&nbsp;<span class="label label-success">{$linkCount['totalLinkCount']}</span></p>
  </h4>
</div>
<div class="row">
  <p>最新十位绑定用户:</p>
</div>
<div class="row">
  <table class="table table-hover">
    <thead>
      <tr>
        <th>Nova ID</th>
        <th>学号</th>
        <th>绑定时间</th>
        <th>易班 ID</th>
        <th>易班绑定时间</th>
      </tr>
    </thead>
    <tbody class="table-striped">
      {foreach $users as $user}
        <tr class="">
          <td>{$user.id}</td>
          <td>{$user.xmu_num}</td>
          <td>{$user.xmu_linkTime}</td>
          <td>{$user.yiban_uid}</td>
          <td>{$user.yiban_linkTime}</td>
        </tr>
      {/foreach}
    </tbody>
  </table>
</div>
