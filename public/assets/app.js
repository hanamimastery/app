(() => {
  console.log('fuuuuu')
  document.body.addEventListener('htmx:configRequest', (event) => {
    let csrf_param = document.querySelector('meta[name="csrf-param"]').content
    let csrf_token = document.querySelector('meta[name="csrf-token"]').content

    // event.detail.headers['X-CSRF-Token'] = '{{ csrf_token }}';
    // event.detail.params['_csrf_token'] = '{{ csrf_token }}';
    // #   <meta name="csrf-param" content="_csrf_token">
    // #   <meta name="csrf-token" content="4a038be85b7603c406dcbfad4b9cdf91ec6ca138ed6441163a07bb0fdfbe25b5">
    console.log('*****************')
    console.log(csrf_param);
    console.log(csrf_token);

  })
})();
