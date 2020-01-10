$(function() {
  
  function showElementAnimation() {

    var element = document.getElementsByClassName('category-box_product');
    if(!element) return; // 要素がなかったら処理をキャンセル
    
    var showTiming = window.innerHeight > 768 ? 5 : 80; // 要素が出てくるタイミングはここで調整
    var scrollY = window.pageYOffset;
    var windowH = window.innerHeight;

    for(var i=0;i<element.length;i++) { var elemClientRect = element[i].getBoundingClientRect(); var elemY = scrollY + elemClientRect.top; if(scrollY + windowH - showTiming > elemY) {
        element[i].classList.add('is-show');
      }
    }
  }
  showElementAnimation();
  window.addEventListener('scroll', showElementAnimation);
});