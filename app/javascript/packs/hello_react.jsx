// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import PrimarySearchAppBar from '../components/header/navigation'
// import configureStore from './redux/store';
// import { Provider } from 'react-redux';

let initialState = {};
// let store = configureStore(initialState);

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
          <PrimarySearchAppBar />,
    document.body.appendChild(document.createElement('div')),
  )
});
