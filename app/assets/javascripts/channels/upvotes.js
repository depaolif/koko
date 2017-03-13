App.upvotes = App.cable.subscriptions.create('UpvotesChannel', {
  received: function(data) {
    var upvote = $("#review_" + data.review_id).children('span').children()
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

    // $("#upvotes").attr("class")
    // $("#upvotes").removeClass('hidden')
    // debugger
    var add_score = data.score - data.prev
    $('#review_' + data.review_id + '_total').html(parseInt($('#review_' + data.review_id + '_total').html()) + add_score)
    // parseInt($('#review_' + data.review_id + '_total').html()) + data.score
    // $('#upvotes').html(parseInt($('#upvotes').html()) + data.score)
  },

  renderUpvote: function(data) {
    return "Hey";
  }
});
