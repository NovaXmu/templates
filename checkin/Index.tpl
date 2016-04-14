<!-- 签到页 -->
<!DOCTYPE html>
<html lang="zh-cn">
<head>
	{include file="common/CommonHead.tpl"}
	<link rel="stylesheet" href="{$base}checkin/css/index.css"></head>
<body>
	<div id="isChecked" style="display:none">{nocache}{$isChecked}{/nocache}</div>
	<div id="stdNum" style="display:none">{nocache}{$num}</div>
	{include file="common/Header.tpl"}
	<div id="content">
		<div class="wrapper checked-in auto">
			<h2 class="title">签到成功</h2>
			<div class="icon">
				<img src="{$base}common/img/success.png"></div>
			<p>
				您是今天第
				<span class="emph order">{$order|default:""}</span>
				位签到者
			</p>
			<p>
				您本月已累计签到
				<span class="emph monthCount">{$count|default:""}{/nocache}</span>
				天
			</p>
			{if $pay ge '0'}
			<p>
				恭喜您获得
				<span class="emph pay">{$pay}{/nocache}</span>
				网薪
			</p>
			<div style="text-align:center;" class="btn-view">
				<button type="button" style="background-color:#046D22;font-size:20px;height:50px;border-style:double"
				onclick="viewMoney()">领取网薪</button>
			</div>
			{/if}
			
		</div>
		<div class="unchecked">
			<div class="wrapper main">
				<h2 class="title">每日签到</h2>
				<div class="question" title="{$id}">
					<p>
						【{if $questionType eq '0'}问题
						   {elseif $questionType eq '1'}问卷
						   {else}{/if}】{$content}
					</p>
					<form>
						{foreach $option as $each}
						<div class="option">
							<input type="{$optionType}" name="option" id="{cycle name="radio" values='No1,No2,No3,No4'}" value={$each.key}>
							<label for="{cycle name="label" values='No1,No2,No3,No4'}">{$each.value}</label>
							<br/>
						</div>
						{/foreach}
					</form>
				</div>
				<div class="button">点击签到</div>
			</div>
			<div class="wrapper checked-in" style="display:none">
				<div id="question" style="display:none">
					<div id="replyRight">
						<h2 class="title">答对啦</h2>
						<div class="icon">
							<img src="{$base}checkin/img/right.png"></div>
					</div>
					<div id="replyWrong">
						<h2 class="title">好遗憾,</h2>
						<h2 class="title">
							正确答案是
							<span class='right'></span>
						</h2>
						<div class="icon">
							<img src="{$base}checkin/img/wrong.png"></div>
					</div>
					<div class="wrapper remark" {if $remark == ''}style="display:none"{/if}>
						<p>{$content}</p>
						<p>正确答案：{$remark}</p>
					</div>
				</div>
				<div id="questionnaire" style="text-align:center">
					<canvas id="analysePie" width="200" height="200"></canvas>
				</div>

				<p>
					您是今天第
					<span class="emph order"></span>
					位签到者
				</p>
				<p>
					您本月已累计签到
					<span class="emph monthCount"></span>
					天
				</p>
				<p>
				    恭喜您获得 
				    <span class="emph pay"></span>
				    网薪
				</p>
				<div style="text-align:center;" class="btn-view"><button type="button" style="background-color:#046D22;font-size:20px;height:50px;border-style:double"
				onclick="viewMoney()">领取网薪</button></div>
			</div>
		</div>

		<!--<div class="wrapper remark" {if $remark == ''}style="display:none"{/if}>
			<p>{$remark}</p>
		</div>-->
	</div>
	{include file="common/Footer.tpl"}
	<script type="text/javascript" src="{$base}checkin/js/Chart.js"></script>
	<script type="text/javascript" src="{$base}common/js/WeixinApi.js?v=1"></script>
	<script type="text/javascript" src="{$base}checkin/js/index.js?v=1"></script>
</body>
</html>