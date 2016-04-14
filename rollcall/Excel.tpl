<table>
    <tr>
        <th colspan="4">{$name}签到表</th>
    </tr>
    <tr>
        <th>学号</th>
        <th>签到时间</th>
    </tr>
    {foreach $list as $item}
    <tr>
        <td>{$item['num']}</td>
        <td>{$item['time']}</td>
    </tr>
    {/foreach}
</table>
