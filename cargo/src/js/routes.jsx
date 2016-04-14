var React = require("react");
var ReactRouter = require("react-router");
var history = require("react-router/lib/hashHistory");
var Router = ReactRouter.Router;
var Route = ReactRouter.Route;
var Redirect = ReactRouter.Redirect;

var Page = require("./components/Page");
var MainSecDispatcher = require("./components/MainSecDispatcher");
var SecManage = require("./components/SecManage");
var NoMatch = require("./components/NoMatch");
var Linkin = require("./components/Linkin");
var Entry = require("./components/Entry");

module.exports = (
    <Router history={history} >
      <Redirect from="/home" to="/section/take" />
      <Route path="/" component={Entry}></Route>
      <Route path="/section/:secName" component={Page}></Route>
      <Route path="/linkin" component={Linkin}></Route>  
      <Route path="*" component={NoMatch}/>
    </Router>
);