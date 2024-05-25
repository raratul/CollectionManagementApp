// Entry point for the build script in your package.json
//= require bootstrap
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require jquery-ui
//= require jquery_ujs
//= require rails-ujs
//= require turbolinks
//= require_tree .
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"

import "./channels"
