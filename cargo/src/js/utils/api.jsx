var rootUrl = "/cargo/";
var Fetch = require("whatwg-fetch");

module.exports = {
	
	fetch: function(url) {
		return fetch(rootUrl + url, {
			credentials: "same-origin"
		})
		.then(function(response) {
			return response.json();
		});
	},
	
	get: function(url, queries, onSuccess) {
		var request = new XMLHttpRequest();
		if ( queries ) {
			url += "?";
			for ( var key in queries ) {
				if ( queries.hasOwnProperty(key) ) {
					var value = queries[key];
					url += ( key + "=" + value + "&" );
				}
			}
			url = url.slice(0, url.length - 1);
		} 
		request.open("get", rootUrl + url);
		request.onreadystatechange = function() {
			switch( request.readyState ) {
				case 4: 
					document.querySelector(".loading").classList.remove("show");
					this.onComplete(request, onSuccess);
					break;
				case 3:

					break;
				case 2:
					break;
			}
		}.bind(this)
		request.send();
		document.querySelector(".loading").classList.add("show"); 
	},
	
	post: function(url, queries, obj, onSuccess) {
		//obj.openid = "ziyang";
		var request = new XMLHttpRequest();
		if ( queries ) {
			url += "?";
			for ( var key in queries ) {
				if ( queries.hasOwnProperty(key) ) {
					var value = queries[key];
					url += ( key + "=" + value + "&" );
				}
			}
			url = url.slice(0, url.length - 1);
		} 
		request.open("post", rootUrl + url);
		request.onreadystatechange = function() {
			switch( request.readyState ) {
				case 4: 
					document.querySelector(".loading").classList.remove("show");
					this.onComplete(request, onSuccess);
					break;
				case 3:
					break;
				case 2:
					break;
			}
		}.bind(this)

		var query = "";
		for ( var key in obj ) {
			if ( obj.hasOwnProperty(key) ) {
				var value = obj[key];
				query += ( key + "=" + value + "&" );
			}
		}
		query = query.slice(0, query.length-1);
		request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");		
		//request.send(formData);
		request.send(query);
		document.querySelector(".loading").classList.add("show"); 
	},
	
	postJSON: function(url, queries, obj, onSuccess) {
		var request = new XMLHttpRequest();
		if ( queries ) {
			url += "?";
			for ( var key in queries ) {
				if ( queries.hasOwnProperty(key) ) {
					var value = queries[key];
					url += ( key + "=" + value + "&" );
				}
			}
			url = url.slice(0, url.length - 1);
		} 
		request.open("post", rootUrl + url);
		request.onreadystatechange = function() {
			switch( request.readyState ) {
				case 4: 
					document.querySelector(".loading").classList.remove("show");
					this.onComplete(request, onSuccess);
					break;
				case 3:
					break;
				case 2:
					break;
			}
		}.bind(this)
		
		request.send(JSON.stringify(obj));
		document.querySelector(".loading").classList.add("show"); 
	},
	
	upload: function(url, queries, body, onSuccess) {
		var fd = new FormData();
		for ( var props in body ) {
			fd.append(props, body[props]);
		}
		
		if ( queries ) {
			url += "?";
			for ( var key in queries ) {
				if ( queries.hasOwnProperty(key) ) {
					url += (key + "=" + queries[key] + "&");
				}
			}
			url = url.slice(0, url.length-1);
		}
		var request = new XMLHttpRequest();
		request.open("post", rootUrl + url);
		request.onreadystatechange = function() {
			if ( request.readyState == 4 && request.status == 200 ) {
				var json;
				try {
					json = JSON.parse(request.responseText);
				} catch(e) {
					alert("后台数据解析出错");
					console.log(e);
					return;
				}
				onSuccess(json);
			}
		}
		request.send(fd);
		document.querySelector(".loading").classList.add("show"); 
	},
	
	onComplete: function(request, onSuccess) {
		if ( request.status == "200" ) {
				try {
					var json = JSON.parse(request.responseText);
				} catch(e) {
					alert("返回数据解析失败，把情况告诉程序猿们，他们会帮你解决~ 数据文本：" + request.responseText);
					return;
				}
				onSuccess(json);
		} else {
			alert( "网络错误" );
		}		
	}
}