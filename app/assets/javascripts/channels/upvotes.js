App.upvotes = App.cable.subscriptions.create('UpvotesChannel', {
  received: function(data) {
    var upvote = $("#review_" + data.review_id).find('span#socket_' + data.account_id).children()
    upvote.each(function(index){
      this.className = "votes-form"
      this[3].value = 0
    });

    if (data.score == 1) {
      upvote.first().addClass("votes-form selected-up")
      upvote.last().each(function(index){
        this[3].value = -1
      })
    };

    if (data.score == -1) {
      upvote.last().addClass("votes-form selected-down")
      upvote.first().each(function(index){
        this[3].value = 1
      })
    };

    if (data.score == 0) {
      upvote.first().addClass("votes-form")
      upvote.last().addClass("votes-form")
      upvote.first().each(function(index){
        this[3].value = 1
      })
      upvote.last().each(function(index){
        this[3].value = -1
      })
    };
    var add_score = data.score - data.prev
    $('#review_' + data.review_id + '_total').html(parseInt($('#review_' + data.review_id + '_total').html()) + add_score)
  },
});
