// Run this example by adding <%= javascript_pack_tag "hello_elm" %> to the
// head of your layout file, like app/views/layouts/application.html.erb.
// It will render "Hello Elm!" within the page.

import {
  Elm
} from '../components/Home'

document.addEventListener('DOMContentLoaded', () => {
  const target = document.getElementById('app')

  document.body.appendChild(target)
  Elm.Home.init({
    node: target
  })
})
