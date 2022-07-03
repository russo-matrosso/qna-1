App.cable.subscriptions.create({ channel: "CommentsChannel", question_id: gon.question_id }, {
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