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
  var deferredInstallPrompt = null;

  function isStandalone() {
    return window.matchMedia && window.matchMedia('(display-mode: standalone)').matches || window.navigator.standalone;
  }

  function isiPhoneOrIPad() {
    return /iphone|ipad|ipod/i.test(window.navigator.userAgent || '');
  }

  function installMessageFor(platform, promptAvailable) {
    if (platform === 'ios') {
      return 'On iPhone or iPad, open Alpha Blog in Safari, tap Share, then choose Add to Home Screen.';
    }

    if (promptAvailable) {
      return 'Tap Install on Android to add Alpha Blog to your home screen and open it like a native app.';
    }

    return 'If your browser does not show the install prompt, open the browser menu and choose Install app or Add to Home screen.';
  }

  function attachInstallPrompt() {
    var panel = document.querySelector('[data-install-panel]');
    var help = document.querySelector('[data-install-help]');
    var message = document.querySelector('[data-install-message]');
    var buttons = document.querySelectorAll('[data-install-trigger]');

    if (!panel || !help || !message || !buttons.length) {
      return;
    }

    if (isStandalone()) {
      panel.style.display = 'none';
      return;
    }

    function setMessage(text) {
      message.textContent = text;
      help.classList.add('is-visible');
    }

    Array.prototype.forEach.call(buttons, function(button) {
      button.addEventListener('click', function() {
        var platform = button.getAttribute('data-install-trigger');

        if (platform === 'android' && deferredInstallPrompt) {
          deferredInstallPrompt.prompt();
          deferredInstallPrompt.userChoice.finally(function() {
            deferredInstallPrompt = null;
          });
          setMessage('Install prompt opened. If you dismiss it, you can reopen it from your browser menu.');
          return;
        }

        if (platform === 'ios' && isiPhoneOrIPad()) {
          setMessage(installMessageFor('ios', false));
          return;
        }

        setMessage(installMessageFor(platform, !!deferredInstallPrompt));
      });
    });

    setMessage(isiPhoneOrIPad() ? installMessageFor('ios', false) : installMessageFor('android', !!deferredInstallPrompt));
  }

  window.addEventListener('beforeinstallprompt', function(event) {
    event.preventDefault();
    deferredInstallPrompt = event;
  });

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
  document.addEventListener('turbolinks:load', attachInstallPrompt);
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
