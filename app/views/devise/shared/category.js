$(function() {


  // 子カテゴリーを追加するための処理です。
function buildChildrenHTML(){
  var html = `<ul class='header_children-nav'>
              </ul>`;
  return html;
}
function buildChildHTML(child){
  var html =`<li class="header_children-list" data-id= "${child.id}">
              <a class="header_children-link" href="/categories/${child.id}">${child.name}</a>
            </li>`;
  return html;
}

$(".header_parent-list").on("mouseenter", function() {
  var id = this.id                      //どのリンクにマウスが乗ってるのか取得します
  $(".header_children-list").remove();//一旦出ている子カテゴリ消します！
  $(".header_children-nav").remove();
  $(".header_grandchildren-nav").remove();
  $(".active_parent-list").removeClass("active_parent-list")//赤色のcssのためです
  $('#' + id).addClass("active_parent-list");//赤色のcssのためです
  $('.active_parent-link').removeClass("active_parent-link");
  $('.active_parent-list').children().addClass("active_parent-link");
  // $('.active_parent-list').children().hover().css({"color":"#fff"});
  $.ajax({
    type: 'GET',
    url: '/categories/get_category_children',
    data: {parent_id: id},//どの親の要素かを送ります params[:parent_id]で送られる
    dataType: 'json'
  }).
  done(function(children) {
    var html = buildChildrenHTML()
    $(".header_category-nav").append(html)
    children.forEach(function (child) {
      var html = buildChildHTML(child);//HTMLにして
      $(".header_children-nav").append(html);//リストに追加します
    })
  });
  $(".nav-left__cate").on("mouseleave", function() {
    $(".header_children-nav").remove();
    $(".header_grandchildren-nav").remove();
    $(".header_children-list").remove();
    $(".header_grandchildren-list").remove();
    $(".active_parent-list").removeClass("active_parent-list")
    $(".active_children-list").removeClass("active_children-list")
    $(".active_parent-link").removeClass("active_parent-link")
  });
  $(".header_all-list").on("mouseenter", function() {
    $(".header_children-nav").remove();
    $(".header_grandchildren-nav").remove();
    $(".header_children-list").remove();
    $(".header_grandchildren-list").remove();
    $(".active_parent-list").removeClass("active_parent-list")
    $(".active_children-list").removeClass("active_children-list")
    $(".active_parent-link").removeClass("active_parent-link")
  });
});



// 孫カテゴリを追加する処理

function buildGrandChildrenHTML(){
  var html = `<ul class='header_grandchildren-nav'>
              </ul>`;
  return html;
}

function buildGrandChildHTML(grandchild){
  var html =`<li class="header_grandchildren-list" data-id="${grandchild.id}">
              <a class="header_grandchildren-link" href="/categories/${grandchild.id}">${grandchild.name}</a>
            </li>`;
  return html;
}

$(".header_category-nav").on("mouseenter", ".header_children-list", function () {
  var id = $(this).data('id');
  $(".header_grandchildren-list").remove();
  $(".header_grandchildren-nav").remove();
  $(".active_children-list").removeClass("active_children-list");
  $($(this)).addClass("active_children-list");
  $.ajax({
    type: 'GET',
    url: '/categories/get_category_grandchildren',
    data: {child_id: id},
    dataType: 'json'
  })
  .done(function(grandchildren) {
    var html = buildGrandChildrenHTML()
    $(".header_category-nav").append(html)
    grandchildren.forEach(function (grandchild) {
      var html = buildGrandChildHTML(grandchild);
      $(".header_grandchildren-nav").append(html);
    })
  });
});
});