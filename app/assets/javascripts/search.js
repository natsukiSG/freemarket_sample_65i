$(function() {
  // カテゴリーセレクトボックスのオプションを作成
  function appendOption(category){
    var html =`<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  // 子カテゴリーの表示作成
  function appendChidrenBox(insertHTML){
    var childSelectHtml = '';
    childSelectHtml = `<div id= 'children_wrapper'>
                          <select class="select-default" id="child_category" name="child">
                            ${insertHTML}
                          <select>
                      </div>`;
    $('.product-search-category-child').append(childSelectHtml);
  }


  // 孫カテゴリーの表示作成
  function appendGrandchidrenBox(grandchild){
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `<div class= 'category-checkbox-block'>
                                <input type="checkbox" name="grandchild[]" value="${grandchild.id}" id = "q[costcharge_in]">
                                ${grandchild.name}
                            </div>`;
    $('.product-search-category-grid').append(grandchildSelectHtml);
  }

  // 商品サイズの表示作成
  function appendSearchsizeBox(searchsize){
    var searchsizeCheckboxHtml = '';
    searchsizeCheckboxHtml = `<div class= 'searchsize_wrapper'>
                                <input type="checkbox" name="q[size_id_in][]" value="${searchsize.id}" id = "q[size_id_in]">
                                ${searchsize.name}
                              </div>`;
    $('.product-search-size-grid').append(searchsizeCheckboxHtml);
  }


  // 親カテゴリー選択後のイベント
  $('#parent_category_search').on('change', function(){
    var parentCategory = document.getElementById('parent_category_search').value; //選択された親カテゴリーの名前を取得
    if (parentCategory != "---"){ //親カテゴリーが初期値でないことを確認
      $.ajax({
        url: 'get_category_children',
        type: 'GET',
        data: { parent_id: parentCategory },
        dataType: 'json'
      })
      .done(function(children){
        $('#children_wrapper').remove(); //親が変更された時、子以下を削除する
        $('.category-checkbox-block').remove();
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChidrenBox(insertHTML);
        $('#child_category').prepend(`<option value="${parentCategory}" data-category="---" selected>すベて</option>`)
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#children_wrapper').remove(); //親カテゴリーが初期値になった時、子以下を削除する
      $('.category-checkbox-block').remove();
    }
  });


  // 子カテゴリー選択後のイベント
  $('.product-search-categorybox').on('change', '#child_category', function(){
    var childId = $('#child_category option:selected').data('category'); //選択された子カテゴリーのidを取得
    if (childId != "---"){ //子カテゴリーが初期値でないことを確認
      $.ajax({
        url: 'get_category_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        dataType: 'json'
      })
      .done(function(grandchildren){
        if (grandchildren.length != 0) {
          $('.category-checkbox-block').remove(); //子が変更された時、孫以下を削除する
          grandchildren.forEach(function(grandchild){
            appendGrandchidrenBox(grandchild);
          });
        }
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('.category-checkbox-block').remove(); //子カテゴリーが初期値になった時、孫以下を削除する
    }
  });

  // 商品サイズのイベント
  $('#product-search-size-default').on('change',function() {
    var sizechoose = document.getElementById('product-search-size-default').value;
    if (sizechoose != ""){
      $.ajax({
        url: '/products/get_searchsize',
        type: 'GET',
        data: { searchsize_id: sizechoose },
        dataType: 'json'
      })
      .done(function(searchsizes){
        if (searchsizes.length != 0) {
          $('.searchsize_wrapper').remove();
          searchsizes.forEach(function(searchsize){
            appendSearchsizeBox(searchsize);
          });
        }
        else {
          $('.searchsize_wrapper').remove();
        }
      })
      .fail(function(){
        alert('サイズの取得に失敗しました');
      })
    }else {
      $('.searchsize_wrapper').remove();
    }
  });
});