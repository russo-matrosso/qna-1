App.cable.subscriptions.create({ channel: "AnswersChannel", question_id: gon.question_id }, {
  connected() {
    this.perform('subscribed');
  },

  disconnected() {
  },

  received(data) {
    $('.answers').append(data);
  }
});