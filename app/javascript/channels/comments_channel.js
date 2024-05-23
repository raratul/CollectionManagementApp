import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {
  const commentsContainer = document.getElementById('comments')
  if (commentsContainer) {
    const itemId = commentsContainer.dataset.itemId

    consumer.subscriptions.create({ channel: "CommentsChannel", item_id: itemId }, {
      received(data) {
        commentsContainer.insertAdjacentHTML('beforeend', data.comment_partial)
      }
    })
  }
})
