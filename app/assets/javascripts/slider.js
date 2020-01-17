$(function() {
  $('.top-banner-slider').slick({
    prevArrow:'<i class="slider-controller-left"></i>',
    nextArrow:'<i class="slider-controller-right"></i>',
    autoplay: true,
    autoplaySpeed: 2000,
    speed: 2000
  });

  $('.top-banner-slider').on(function() {
    $('.top-banner-slider').slick('goTo', $(this).index());
  });
});