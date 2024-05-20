import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {
  const commentsElement = document.getElementById('comments')
  if (commentsElement) {
    const itemId = commentsElement.dataset.itemId

    consumer.subscriptions.create({ channel: "CommentsChannel", item_id: itemId }, {
      received(data) {
        commentsElement.innerHTML += data.comment_partial
      }
    })
  }
})
