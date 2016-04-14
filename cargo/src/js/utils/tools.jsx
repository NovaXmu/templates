module.exports = {
	hasClass: function(elem, className) {
		return elem.className.indexOf(className) > -1;
	},
	
	findAncestor: function(elem, pSelector) {
		var parent = elem.parentNode;
		while( parent && !this.selectorMatches(parent, pSelector) ) {
			parent = parent.parentNode;
		}
		return parent;
	},
	
	findChildren: function(elem, cSelector) {
		var collection = []
		var self = this;
		(function(parent){
			if ( self.selectorMatches(parent, cSelector) ) {
				collection.push(parent);
			}
			if ( parent.hasChildNodes() ) {
				var children = parent.children;
				for ( var i = 0; i < children.length; i++ ) {
					var child = children[i];
					arguments.callee(child, cSelector);
				}
			} else return;
		}(elem, cSelector))
		return collection;
	},
	
	spliceString: function(str, index, count, add) {
		return str.slice(0, index) + ( add || "" ) + str.slice(index+count);
	},
	
	selectorMatches: function(el, selector) {
		var p = Element.prototype;
		var f = p.matches || p.webkitMatchesSelector || p.mozMatchesSelector || p.msMatchesSelector || function(s) {
			return [].indexOf.call(document.querySelectorAll(s), this) !== -1;
		};
		return f.call(el, selector);
	}
}