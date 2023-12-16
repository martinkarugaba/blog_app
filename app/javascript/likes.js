document.addEventListener('DOMContentLoaded', function() {
  document.querySelectorAll('.like-button').forEach(function(button) {
    button.addEventListener('click', function(event) {
      event.preventDefault();

      var postId = this.dataset.postId;

      fetch('/posts/' + postId + '/like', { method: 'POST' })
        .then(response => response.json())
        .then(data => {
          document.getElementById('likes-count-' + postId).innerText = data.likes_count;
        });
    });
  });
});