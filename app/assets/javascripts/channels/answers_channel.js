App.cable.subscriptions.create("AnswersChannel", {
  connected() {
    this.perform('subscribed');
  },

  disconnected() {
  },

  received(data) {
    $('.answers').append(data);
  }
});