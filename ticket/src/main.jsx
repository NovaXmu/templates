var ReactDOM = require('react-dom');
var React = require('react')
var Router = require('react-router').Router
var Route = require('react-router').Route
var Redirect = require('react-router').Redirect
var history = require("react-router/lib/hashHistory")

var App = require('./components/App/App')

var index = <App params={{section: "game"}} />

ReactDOM.render(<Router history={history}>
    <Redirect from="/" to="/game" />
    <Route path="/:section" component={App} />
  </Router>, document.getElementById("page"));