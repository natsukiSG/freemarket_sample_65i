$(function() {
  $(function() {
    $('img.details__photo__under__image').click(function(){
      var ImgSrc = $(this).attr("src");
      $("img#mainphoto").attr({src:ImgSrc});
      $("img#mainphoto").hide();
      $("img#mainphoto").fadeIn();
      return false;
    });
    $('img.details__photo__under__image').mouseover(function(){
      var ImgSrc = $(this).attr("src");
      $("img#mainphoto").attr({src:ImgSrc});
      $("img#mainphoto").hide();
      $("img#mainphoto").fadeIn();
        return false;
    });
  });
})