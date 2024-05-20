document.addEventListener('turbolinks:load', () => {
    document.querySelectorAll('a[data-remote]').forEach(link => {
      link.addEventListener('ajax:success', () => {
        const likeSection = document.getElementById('like-section');
        likeSection.innerHTML = '<%= j(render partial: "items/like_section", locals: { item: @item }) %>';
      });
    });
});
  