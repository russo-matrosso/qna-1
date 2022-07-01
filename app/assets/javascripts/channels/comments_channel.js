App.cable.subscriptions.create("CommentsChannel", {
  connected() {
    this.perform('subscribed');
  },

  disconnected() {
  },

  received(data) {
    //console.log(data);
    var type = data.comment.commentable_type.toLowerCase();
    var id = data.comment.commentable_id;

    if (type == 'question') {
      $('.question_comments').append(data['partial']);
    } else {
      $('.answer_comments').append(data['partial']);
     }
   }
});