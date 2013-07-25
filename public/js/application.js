$(document).ready(function() {
  $(".upvote").on('click', function(event){
    event.preventDefault();
    event.stopPropagation();
    var url = $(this).attr('action');
    var count = $(this).siblings('.count').text();
    var newCount = Number(count) + 1;
    var that = $(this);
    $.post(url, function(response){
      if (response == '1') {
      that.siblings('.count').text(newCount);
    }
    });
  });
});
