var Reflux = require("reflux");

module.exports = Reflux.createActions([
	'getCategories',
	'getItemsInCategory',
	'getCartItems',
	'addItemToCart',
	'updateItemInCart',
	'removeItemFromCart',
	'removeItemFromCartByName',
	'clearCart',
	'getOrdersByType',
	'filterOrdersByState',
	'getUserInfo',
	'setUserInfo'
]);