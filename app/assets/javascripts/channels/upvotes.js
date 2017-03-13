App.upvotes = App.cable.subscriptions.create('UpvotesChannel', {
  received: function(data) {
    $("#upvotes").removeClass('hidden')
    return $('#upvotes').append(this.renderUpvote(data));
  },

  renderUpvote: function(data) {
    return data.score;
  }
});
