// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// JS Imports
require("@rails/ujs").start()
const Turbolinks = require("turbolinks")
Turbolinks.start()
require("@rails/activestorage").start()
require("channels")
import "controllers"

// Fonts
import "@fontsource/open-sans/400.css"
import "@fontsource/open-sans/400-italic.css"
import "@fontsource/open-sans/700.css"

// Icons
import "bootstrap-icons/bootstrap-icons.svg"

// Stylesheets
import "bootstrap"
import "../stylesheets/application"

// Bootstrap JS Initialization
document.addEventListener("turbolinks:load", () => {
  $('[data-toggle="tooltip"]').tooltip()
  $('[data-toggle="popover"]').popover()
})
