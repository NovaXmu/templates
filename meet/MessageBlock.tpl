<div id="messageBlock" style="display:none;">
	<div class="col-xs-10 col-xs-offset-1 centered message">
		<span></span>
		<textarea></textarea>
	</div>
	<div class="col-xs-10 col-xs-offset-1 centered enter">
		<div class="col-xs-6" onclick="sendMessage(this)" style="border-right-style:solid;">
		发送</div>
		<div class="col-xs-6" onclick="cancel()">取消</div>
	</div>
</div>

<script>
	//# sourceURL=messageBlock.js
	//切换发消息框
	var modal;
	function switchMessage(name, type, id){
		if (modal && modal.state == "opened" && type == 1) {
			name = $(".remodal .nickname").text();
			id = $(".remodal").attr("id");
			modal.close();
		}
		$("#board").hide();
		$("#listBlock").hide();
		$("#messageBlock span").text(name);
		$("#messageBlock").data('id',id);
		$("#messageBlock").data('type',type);
		$("#messageBlock").show();
	}

	//发送消息 type=1私信|2群发活动消息|3群发部落消息
	function sendMessage(){
		var id=$("#messageBlock").data("id");
		var type=$("#messageBlock").data("type");
		var data={
			'to':id,
			'content':$("#messageBlock textarea").val()
		};
		$.post(
				"/meet/api/message?m=sendMessage&type=" + type,
				{
					'data':JSON.stringify(data)
				},
				function(data){
					data=jQuery.parseJSON(data);
					if(data.errno==0)
					{
						alert("发送成功！");
						location.reload();
					}
					else
						alert(data.errmsg);
				});
	}

	//取消发消息
	function cancel(){
		location.reload();
	}
</script>