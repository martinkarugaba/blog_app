document.querySelector('#like-button').addEventListener('click', function(e) {
  e.preventDefault();

  fetch(`/users/${userId}/posts/${postId}/`, {
    method: 'POST',
    headers: {
      'X-Requested-With': 'XMLHttpRequest',
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
    },
    credentials: 'same-origin'
  })
  .then(response => response.json())
  .then(data => {
    document.getElementById(`likes-count-${postId}`).textContent = data.likes_count;
  });
});