import "../css/app.css";

console.log('LOADED MAIN APP.js 2');

document.body.addEventListener('htmx:configRequest', (event) => {
  let csrf_param = document.querySelector('meta[name="csrf-param"]').content;
  let csrf_token = document.querySelector('meta[name="csrf-token"]').content;

  event.detail.headers['X-CSRF-Token'] = csrf_token;
  event.detail.parameters['_csrf_token'] = csrf_token;
});
