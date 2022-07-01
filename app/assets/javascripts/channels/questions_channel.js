
App.cable.subscriptions.create("QuestionsChannel", {
  connected() {
    this.perform('subscribed');
  },

  disconnected() {
  },

  received(data) {
    $('.questions').append(data);
  }
});