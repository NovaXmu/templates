window.onload=function(){

   //留言提交部分
	var clear=document.getElementById("clear");
	clear.addEventListener("click",clearall);
	var form=document.getElementById("form");
	form.addEventListener("click",formall);
	var text1=document.getElementById("text-1");
	var text2=document.getElementById("text-2");
  var btncontainer=document.getElementById("btn-container");
  var btns=getByClass(btncontainer,'btn-3');

  var ulsp=document.getElementById("message-ul");
  var lisp=ulsp.getElementsByTagName("li")[0];
  var messageid;
  var attention;
  var messagetype;
  var username;
  var contactway;
  var messagecontent;
  var mailbox;


  var alink=document.getElementById("a-1");
  alink.addEventListener("click",function(){
    window.location.href="index1.html";



  })
   
  for(var i=0;i<btns.length;i++)
  { 
    btns[i].value=i;
    btns[i].addEventListener('click',btnsAdd)
  }
  function btnsAdd(){
    for(var i=0;i<btns.length;i++)
    {
      if(i!=this.value)
      {
        btns[i].className='';
        btns[i].className='btn-3';

      }
      else{
        btns[i].className='';
        btns[i].className='btn-4';
      }
    }
    messagetype=this.id;
   
  }
  //设置留言的类型，纯js








   //留言显示部分
   var ulist=document.getElementById("message-ul").getElementsByTagName("li");
   for(var i=0;i<ulist.length;i++)
   {
   	 ulist[i].id=i;
   }

   //实现内容部分的滚动
	(function(){
		var request=new XMLHttpRequest();
		request.onreadystatechange=function(){
			if(request.readyState==4){
				if(request.status>=200&&request.status<=300)
				{
                  var data=JSON.parse(request.responseText);
                  if(data.errno==0)
                 {
                  var list=[];
                  var length=data.errmsg.bugfrontend.length+data.errmsg.bugbackend.length+data.errmsg.bugother.length;
                  for(var i=0;i<length-1;i++)
                  {
                    licode=lisp.cloneNode(true);
                    ulsp.appendChild(licode);
                  };
                  var mylist=getByClass(ulsp,'li-container');
                  var myuser=getByClass(ulsp,'block');
                  var myatentions=getByClass(ulsp,'atention');
                  var mytringer=getByClass(ulsp,'iconfont');
                  for(var i=0;i<data.errmsg.bugfrontend.length;i++)
                  {
                  	mylist[i].innerHTML=data.errmsg.bugfrontend[i].messagecontent;
                    myuser[i].innerHTML="前端BUG";
                    myatentions[i].innerHTML=data.errmsg.bugfrontend[i].attention;
                  }
                  for(var i=0;i<data.errmsg.bugbackend.length ;i++)
                  {
                    mylist[i+data.errmsg.bugfrontend.length].innerHTML=data.errmsg.bugbackend[i].messagecontent;
                    myuser[i+data.errmsg.bugfrontend.length].innerHTML="后端BUG";
                    myatentions[i+data.errmsge.bugfrontend.length].innerHTML=data.errmsg.bugbackend[i].attention;
                  }
                  for(var i=0;i<data.errmsg.bugother.length;i++)
                  {
                    mylist[i+data.errmsg.bugfrontend.length+data.errmsg.bugbackend.length].innerHTML
                    =data.errmsg.bugother[i].messagecontent;
                    myuser[i+data.errmsge.bugfrontend.length+data.errmsg.bugbackend.length].innerHTML="其他BUG";
                    myatentions[i+data.errmsg.bugfrontend.length+data.errmsg.bugbackend.length].innerHTML=data.errmsg.bugother[i].attention;

                  }
                  for(var i=0;i<length;i++)
                  { 
                    mytringer[i].id=i;
                    mytringer[i].addEventListener('click',function(){
                      if(this.id<data.errmsg.bugfrontend.length)
                      {
                        var x=parseInt(myatentions[this.id].innerHTML);
                        myatentions[this.id].innerHTML=x+1;
                        messageid=data.errmsg.bugfrontend[this.id].messageid;
                        attention=x+1;
                      }
                      else if(this.id>=data.errmsg.bugfrontend.length&&this.id<data.errmsg.bugbackend.length+data.errmsg.bugfrontend.length)
                      { 
                   
                        var x=parseInt(myatentions[this.id].innerHTML);
                        myatentions[this.id].innerHTML=x+1
                        messageid=data.errmsg.bugbackend[this.id-data.errmsg.bugfrontend.length].messageid;                 
                        attention=x+1;
                      }
                      else
                      {
                       var x=parseInt(myatentions[this.id].innerHTML);
                       myatentions[this.id].innerHTML=x+1;
                       messageid=data.errmsg.bugother[this.id-data.errmsg.bugfrontend.
                       length-data.errmsg.bugbackend.length].messageid;
                       attention=x+1;
                      }
                      var xml=new XMLHttpRequest();
                      xml.onreadystatechange=function(){
                        if(xml.readyState==4&&xml.status==200)
                        {
                           var data=JSON.parse(xml.responseText);
                           if(data.errno==0)
                           {
                            alert("点赞成功b(￣▽￣)d")
                           }
                        }
                      }
                      var postStr="messageid="+messageid+"&attention="+attention;
                      xml.open("post",'http://test.novaxmu.cn/message/api/user/Attention','true');
                      xml.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                      xml.send(postStr);
                    })
                      //提交改变关注度的,留言的id..........原型太长,封装成函数,函数体也写得太
                  }
              }
              else{
              	alert("链接数据库不成功");

              }
				}
			
				else{
					alert("error1");

				}
			}
			
		}
		request.open("get","http://test.novaxmu.cn/message/api/user/Push","true");
		request.send(null);


	})()


	function getByClass(oparent,sclass){
		var mylist=oparent.getElementsByTagName("*");
		var result=[];
		for(var i=0;i<mylist.length;i++)
		{
			if(mylist[i].className==sclass)
			{
              result.push(mylist[i]);
			}

		}
		return result;

	}
    
	function clearall(){
	    text1.value=" "
	}
	function formall(){
    messagecontent=text1.value;
		if(messagetype==null||messagecontent==null)
    {
      alert("未选择留言类型或留言为空");
    }
    else{     
        var xml=new XMLHttpRequest();
        xml.onreadystatechange=function(){
          if(xml.readyState==4&&xml.status==200)
          {
            var data=JSON.parse(xml.responseText);
            if(data.errno==0)
            {
              alert("留言成功(＾－＾)V");
            }
            else{

            }
          }
        }
        username=document.getElementById("username").value;
        contactway=document.getElementById("contactway").value;
        mailbox=document.getElementById("mailbox").value;
        
        var postStr="username="+username+"&contactway="+contactway+"&mailbox="+mailbox+"&messagetype="+messagetype
        +"&messagecontent="+messagecontent;
        xml.open("post",'http://test.novaxmu.cn/message/api/user/LeaveMessage','true');
        xml.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
        xml.send(postStr);
    }
	}


}
