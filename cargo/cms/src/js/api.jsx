var Fetch = require("whatwg-fetch");
var rootUrl = "/cargo/";
module.exports = {
	get: function(url, queries, onSuccess) {
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
		request.open("get", rootUrl + url);
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
		
		request.send(null);
	},
	
	post: function(url, queries, body, onSuccess) {
		if ( queries ) {
			url += "?";
			for ( var key in queries ) {
				if ( queries.hasOwnProperty(key) ) {
					url += (key + "=" + queries[key] + "&");
				}
			}
			url = url.slice(0, url.length-1);
		}
		
		var realBody = "";
		if ( body ) {
			for ( var prop in body ) {
				if ( body.hasOwnProperty(prop) ) {
					realBody += ( prop + "=" + body[prop] + "&");
				}
			}
			realBody = realBody.slice(0, realBody.length-1);
		}
		var request = new XMLHttpRequest();
		request.open("post", rootUrl + url);
		request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
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
		request.send(realBody);
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
	},
	
	download: function(url, queries, body, onSuccess) {
		if ( queries ) {
			url += "?";
			for ( var key in queries ) {
				if ( queries.hasOwnProperty(key) ) {
					url += (key + "=" + queries[key] + "&");
				}
			}
			url = url.slice(0, url.length-1);
		}
		
		var realBody = "";
		if ( body ) {
			for ( var prop in body ) {
				if ( body.hasOwnProperty(prop) ) {
					realBody += ( prop + "=" + body[prop] + "&");
				}
			}
			realBody = realBody.slice(0, realBody.length-1);
		}
		var request = new XMLHttpRequest();
		request.open("post", rootUrl + url);
		request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		request.onreadystatechange = function() {
			if ( request.readyState == 4 && request.status == 200 ) {
				if ( onSuccess ) {
					onSuccess(request.responseText);
				}
			}
		}
		request.send(realBody);
	}
}