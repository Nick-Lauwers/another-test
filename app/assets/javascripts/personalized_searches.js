$(function() {
  
  // form
    
    var matchesIntroductionClose = $('.matches-introduction-close');
    var matchesIntroduction      = $('.matches-introduction');
    
    matchesIntroductionClose.click(function () {
      matchesIntroduction.css("display", "none");
    });
    
    $('.right-paddle').click(function() {
      event.preventDefault();
      $('.parameters').animate({
        scrollLeft: "+=200px"
      }, "slow");
    });

   $('.left-paddle').click(function() {
      event.preventDefault();
      $('.parameters').animate({
        scrollLeft: "-=200px"
      }, "slow");
    });
});