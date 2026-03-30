// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

(function() {
  function attachHighlightSelection() {
    var root = document.querySelector('[data-highlight-root]');
    var preview = document.querySelector('.highlight-preview');
    var contentInput = document.querySelector('.highlight-content-input');
    var positionInput = document.querySelector('.highlight-position-input');
    var submitButton = document.querySelector('[data-highlight-submit]');

    if (!root || !preview || !contentInput || !positionInput || !submitButton) {
      return;
    }

    function updateSelection() {
      var selection = window.getSelection();
      var text = selection ? selection.toString().replace(/\s+/g, ' ').trim() : '';

      if (!text) {
        preview.textContent = 'No text selected yet.';
        contentInput.value = '';
        positionInput.value = 0;
        submitButton.disabled = true;
        return;
      }

      var rootText = root.innerText || root.textContent || '';
      var position = rootText.indexOf(text);

      preview.textContent = text;
      contentInput.value = text;
      positionInput.value = position >= 0 ? position : 0;
      submitButton.disabled = false;
    }

    root.addEventListener('mouseup', updateSelection);
    root.addEventListener('touchend', updateSelection);
  }

  document.addEventListener('turbolinks:load', attachHighlightSelection);
})();

(function() {
  if (!('serviceWorker' in navigator)) {
    return;
  }

  window.addEventListener('load', function() {
    navigator.serviceWorker.register('/service-worker.js').catch(function() {
      return null;
    });
  });
})();
