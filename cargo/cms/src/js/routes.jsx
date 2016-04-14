var React = require("react");
var ReactRouter = require("react-router");
var history = require("react-router/lib/hashHistory");
var Router = ReactRouter.Router;
var Route = ReactRouter.Route;
var Redirect = ReactRouter.Redirect;

var Index = require("./components/Index");

module.exports = (
	<Router history={new history}>
		<Route path="/" component={Index}>
		</Route>
	</Router>
);