document.addEventListener('DOMContentLoaded', function() {
  var likeButtons = document.querySelectorAll('.like-button');

  likeButtons.forEach(function(button) {
    button.addEventListener('click', function(event) {
      event.stopPropagation();
    });
  });
});