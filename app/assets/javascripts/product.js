$(function() {
  // カテゴリーセレクトボックスのオプションを作成
  function appendOption(category){
    var html =`<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }

 // サイズセレクトボックスのオプションを作成
  function appendsizes(size){
    var html =`<option value="${size.id}" data-category="${size.id}">${size.name}</option>`;
    return html;
}

// ブランドリストを作成
function appendbrands(brand){
  var html =`<li class="product-brand-suggest-list" data-id="${brand.id}" data-name="${brand.name}">
              ${brand.name}
            </li>`;
  return html;
}

  // 子カテゴリーの表示作成
  function appendChidrenBox(insertHTML){
    var childSelectHtml = '';
    childSelectHtml = `<div id= 'children_wrapper'>
                          <select class="select-default" id="child_category" name="product[category_id]">
                            <option value="---" data-category="---">---</option>
                            ${insertHTML}
                          </select>
                      </div>`;
    $('.detail-right-cate-top').append(childSelectHtml);
  }


  // 孫カテゴリーの表示作成
  function appendGrandchidrenBox(insertHTML){
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `<div id= 'grandchildren_wrapper'>
                                <select class="select-default" id="grandchild_category" name="product[category_id]">
                                  <option value="---" data-category="---">---</option>
                                  ${insertHTML}
                                </select>
                            </div>`;
    $('.detail-right-cate-top').append(grandchildSelectHtml);
  }

  // サイズの表示作成
  function appendSizeBox(insertHTML){
    var SizeSelectHtml = '';
    SizeSelectHtml = `<div id= 'size_wrapper'>
                        <div class='products-new_main-detail-right-status'>
                          サイズ
                          <div class='products-new-redbtn'>
                            必須
                          </div>
                        </div>
                        <div class='detail-right-cate-top'>
                          <select class="select-default" id="product-size" name="product[size_id]">
                            <option value="" data-category="---">---</option>
                            ${insertHTML}
                          </select>
                        </div>
                      </div>`;
    $('.products-new_main-right-details').append(SizeSelectHtml);
  }

  // ブランドformの追加
  function appendBrandBox(){
    var BrandFormHtml = '';
      BrandFormHtml = `<div id= 'brand_wrapper'>
                        <div class='products-new_main-detail-right-status'>
                          ブランド
                          <div class='products-new-graybtn'>
                            任意
                          </div>
                        </div>
                        <div class='detail-right-brand-box'>
                          <input class="select-default" id="product-brand-form" placeholder= "例)シャネル" type= "text">
                          <div class="product-brand-suggest-box">
                          </div>
                        </div>
                      </div>`;
    $('.products-new_main-right-details').append(BrandFormHtml);
  }

  // ブランドインクリ
  function BrandListBox(insertHTML){
    var BrandListHtml = '';
      BrandListHtml = `<ul id= 'product-brand-suggest'>
                        ${insertHTML}
                      </ul>`;
    $('.product-brand-suggest-box').append(BrandListHtml);
  }


  function appendSelectBrand(name){
    var BrandSelectHtml = '';
      BrandSelectHtml = `<input id="product-brand-form" value= "${name}" type= "text">
                      <div class="product-brand-suggest-box">
                      </div>`;
    $('.detail-right-brand-box').append(BrandSelectHtml);
  }

  function appendHiddenBrand(id){
    var BrandHiddenHtml = '';
      BrandHiddenHtml = `<input name='product[brand_id]' type='hidden' value='${id}' id='hidden-brand'>`;
    $('.detail-right-brand-box').append(BrandHiddenHtml);
  }


  function appendDeliveryWayBox(){
    html = `<div id= 'products-new_main-delivary-right-area'>
              <div id=delivary-right-area-head>
                配送の方法
                <div id=products-new-redbtn>
                  必須
                </div>
              </div>
              <div id=delivary-right-area-box>
                <select id="select-default" name="product[delivery_way]">
                  <option value="---" data-category="---">---</option>
                  <option value="未定" data-category="---">未定</option>
                  <option value="らくらくメルカリ便" data-category="---">らくらくメルカリ便</option>
                  <option value="ゆうメール" data-category="---">ゆうメール</option>
                  <option value="レターパック" data-category="---">レターパック</option>
                  <option value="普通郵便(定形、定形外)" data-category="---">普通郵便(定形、定形外)</option>
                  <option value="クロネコヤマト" data-category="---">クロネコヤマト</option>
                  <option value="ゆうパック" data-category="---">ゆうパック</option>
                  <option value="クリックポスト" data-category="---">クリックポスト</option>
                  <option value="ゆうパケット" data-category="---">ゆうパケット</option>
                </select>
             </div>`;
    return html;
  }

  function appendDeliveryWayBox2(){
    html = `<div id= 'products-new_main-delivary-right-area'>
              <div id=delivary-right-area-head>
                配送の方法
                <div id=products-new-redbtn>
                  必須
                </div>
              </div>
              <div id=delivary-right-area-box>
                <select id="select-default" name="product[delivery_way]">
                  <option value="---" >---</option>
                  <option value="未定" >未定</option>
                  <option value="クロネコヤマト">クロネコヤマト</option>
                  <option value="ゆうパック">ゆうパック</option>
                  <option value="ゆうメール">ゆうメール</option>
                </select>
             </div>`;
    return html;
  }

  


  // 親カテゴリー選択後のイベント
  $('#parent_category').on('change', function(){
    var parentCategory = document.getElementById('parent_category').value; //選択された親カテゴリーの名前を取得
    if (parentCategory != "---"){ //親カテゴリーが初期値でないことを確認
      $.ajax({
        url: '/products/get_category_children',
        type: 'GET',
        data: { parent_id: parentCategory },
        dataType: 'json'
      })
      .done(function(children){
        $('#children_wrapper').remove(); //親が変更された時、子以下を削除する
        $('#grandchildren_wrapper').remove();
        $('#size_wrapper').remove();
        $('#brand_wrapper').remove();
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChidrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#children_wrapper').remove(); //親カテゴリーが初期値になった時、子以下を削除する
      $('#grandchildren_wrapper').remove();
      $('#size_wrapper').remove();
      $('#brand_wrapper').remove();
    }
  });


  // 子カテゴリー選択後のイベント
  $('.detail-right-cate-top').on('change', '#child_category', function(){
    var childId = $('#child_category option:selected').data('category'); //選択された子カテゴリーのidを取得
    if (childId != "---"){ //子カテゴリーが初期値でないことを確認
      $.ajax({
        url: '/products/get_category_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        dataType: 'json'
      })
      .done(function(grandchildren){
        if (grandchildren.length != 0) {
          $('#grandchildren_wrapper').remove(); //子が変更された時、孫以下を削除するする
          $('#size_wrapper').remove();
          $('#brand_wrapper').remove();
          var insertHTML = '';
          grandchildren.forEach(function(grandchild){
            insertHTML += appendOption(grandchild);
          });
          appendGrandchidrenBox(insertHTML);
        }
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#grandchildren_wrapper').remove(); //子カテゴリーが初期値になった時、孫以下を削除する
      $('#size_wrapper').remove();
      $('#brand_wrapper').remove();
    }
  });

  // 孫カテゴリー選択後のイベント(サイズ選択)
  $('.detail-right-cate-top').on('change', '#grandchild_category', function(){
    var grandchildId = $('#grandchild_category option:selected').data('category'); //選択された孫カテゴリーのidを取得
    if (grandchildId != "---"){ //子カテゴリーが初期値でないことを確認
      $.ajax({
        url: '/products/get_size',
        type: 'GET',
        data: { grandchild_id: grandchildId },
        dataType: 'json'
      })
      .done(function(sizes){
        if (sizes.length != 0) {
          $('#size_wrapper').remove();
          $('#brand_wrapper').remove();
          var insertHTML = '';
          sizes.forEach(function(size){
            insertHTML += appendsizes(size);
          });
          appendSizeBox(insertHTML);
          appendBrandBox()
        }
        else {
          $('#size_wrapper').remove();
          $('#brand_wrapper').remove();
          appendBrandBox()
        }

      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#size_wrapper').remove();
      $('#brand_wrapper').remove();
    }
  });

  // ブランド入力後のイベント
  $('.products-new_main-right-details').on('keyup', '#product-brand-form', function(e){
    e.preventDefault();
    var input = $("#product-brand-form").val();
    if (!input){
      $('.product-brand-suggest-box').empty();
      return
    }
    $.ajax({
      url: '/products/get_brand',
      type: 'GET',
      data: { keyword: input },
      dataType: 'json'
    })
    .done(function(brands){
      $('.product-brand-suggest-box').empty();
      $('#hidden-brand').remove();
      if (brands.length !== 0) {
        var insertHTML = '';
        brands.forEach(function(brand){
          insertHTML += appendbrands(brand);
        });
        BrandListBox(insertHTML);
      }
    })
    .fail(function(){
      alert('カテゴリー取得に失敗しました');
    })
  });

  $('.products-new_main-right-details').on('click', '.product-brand-suggest-list', function(){
    var brandName = $(this).data('name');
    var brandId = $(this).data('id');
    $(".detail-right-brand-box").empty();
    appendSelectBrand(brandName)
    appendHiddenBrand(brandId)
  });



  $('.delivary-right-burden-box').on('change', function(){
    $('#products-new_main-delivary-right-area').remove(); 
    $('#delivary-right-area-head').remove();
    $('#products-new-redbtn').remove();
    $('#delivary-right-area-box').remove();
    $('#select-default').remove();
    var deliveryBurden = document.getElementById('delivary-right-burden-box').value;
    if (deliveryBurden == "送料込み(出品者負担)"){
      var html = appendDeliveryWayBox
      $(".products-new_main-delivary-detail").append(html)
    }
    else if (deliveryBurden == '着払い(購入者負担)'){
      var html = appendDeliveryWayBox2
      $(".products-new_main-delivary-detail").append(html)
    }
    else{
      $('#products-new_main-delivary-right-area').remove(); 
      $('#delivary-right-area-head').remove();
      $('#products-new-redbtn').remove();
      $('#delivary-right-area-box').remove();
      $('#select-default').remove();
    }
  });

  $(function(){
    $('#price_calc').on('input', function(){   //リアルタイムで表示したいのでinputを使う｡入力の度にイベントが発火するようになる｡
      var data = $('#price_calc').val(); // val()でフォームのvalueを取得(数値)
      var profit = Math.round(data * 0.9)  // 手数料計算を行う｡dataにかけているのが0.9なのは単に引きたい手数料が10%のため｡
      var fee = (data - profit) // 入力した数値から計算結果(profit)を引く｡それが手数料となる｡
      $('.right_bar').html(fee) //  手数料の表示｡html()は追加ではなく､上書き｡入力値が変わる度に表示も変わるようにする｡
      $('.right_bar').prepend('¥') // 手数料の前に¥マークを付けたいので
      $('.right_bar_2').html(profit)
      $('.right_bar_2').prepend('¥')
      $('#price').val(profit) // 計算結果を格納用フォームに追加｡もし､入力値を追加したいのなら､今回はdataを引数に持たせる｡
      if(profit == '') {   // もし､計算結果が''なら表示も消す｡
      $('.right_bar_2').html('ー');
      $('.right_bar').html('ー');
      }
    })
  })









  // editのjs

  function appendEditChidrenBox(insertHTML){
    var childSelectHtml = '';
    childSelectHtml = `<select class="select-default" id="child_category-edit-add" name="product[category_id]">
                          <option value="---" data-category="---">---</option>
                          ${insertHTML}
                        </select>`;
    $('.detail-right-cate-top').append(childSelectHtml);
  }


  // 孫カテゴリーの表示作成
  function appendEditGrandchidrenBox(insertHTML){
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `<select class="select-default" id="grandchild_category-edit-add" name="product[category_id]">
                              <option value="---" data-category="---">---</option>
                              ${insertHTML}
                            </select>`;
    $('.detail-right-cate-top').append(grandchildSelectHtml);
  }

  // サイズの表示作成
  function appendEditSizeBox(insertHTML){
    var SizeSelectHtml = '';
    SizeSelectHtml = `<div id= 'size_wrapper-edit-add'>
                        <div class='products-new_main-detail-right-status'>
                          サイズ
                          <div class='products-new-redbtn'>
                            必須
                          </div>
                        </div>
                        <div class='detail-right-cate-top'>
                          <select class="select-default" id="product-size-edit-add" name="product[size_id]">
                            <option value="" data-category="---">---</option>
                            ${insertHTML}
                          </select>
                        </div>
                      </div>`;
    $('.products-new_main-right-details').append(SizeSelectHtml);
  }

  // ブランドformの追加
  function appendEditBrandBox(){
    var BrandFormHtml = '';
      BrandFormHtml = `<div id= 'brand_wrapper-edit-add'>
                        <div class='products-new_main-detail-right-status'>
                          ブランド
                          <div class='products-new-graybtn'>
                            任意
                          </div>
                        </div>
                        <div class='detail-right-brand-box'>
                          <input class="select-default" id="product-brand-form-edit-add" placeholder= "例)シャネル" type= "text">
                          <div class="product-brand-suggest-box">
                          </div>
                        </div>
                      </div>`;
    $('.products-new_main-right-details').append(BrandFormHtml);
  }

  // ブランドインクリ
  function EditBrandListBox(insertHTML){
    var BrandListHtml = '';
      BrandListHtml = `<ul id= 'product-brand-suggest'>
                        ${insertHTML}
                      </ul>`;
    $('.product-brand-suggest-box').append(BrandListHtml);
  }


  function appendEditSelectBrand(name){
    var BrandSelectHtml = '';
      BrandSelectHtml = `<input class="select-default" id="product-brand-form-edit-add" value= "${name}" type= "text">
                      <div class="product-brand-suggest-box">
                      </div>`;
    $('.detail-right-brand-box').append(BrandSelectHtml);
  }

  function appendEditHiddenBrand(id){
    var BrandHiddenHtml = '';
      BrandHiddenHtml = `<input name='product[brand_id]' type='hidden' value='${id}' id='hidden-brand-edit-add'>`;
    $('.detail-right-brand-box').append(BrandHiddenHtml);
  }

   // 親カテゴリー選択後のイベント
   $('#parent_category-edit').on('change', function(){
    var parentCategory = document.getElementById('parent_category-edit').value; //選択された親カテゴリーの名前を取得
    if (parentCategory != "---"){ //親カテゴリーが初期値でないことを確認
      $.ajax({
        url: '/products/get_category_children',
        type: 'GET',
        data: { parent_id: parentCategory },
        dataType: 'json'
      })
      .done(function(children){
        $('#child_category-edit').remove(); //親が変更された時、子以下を削除する
        $('#child_category-edit-add').remove();
        $('#grandchild_category-edit').remove();
        $('#grandchild_category-edit-add').remove();
        $('#size_wrapper-edit').remove();
        $('#size_wrapper-edit-add').remove();
        $('#brand_wrapper-edit').remove();
        $('#brand_wrapper-edit-add').remove();
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendEditChidrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#child_category-edit').remove(); //親が変更された時、子以下を削除する
      $('#child_category-edit-add').remove();
      $('#grandchild_category-edit').remove();
      $('#grandchild_category-edit-add').remove();
      $('#size_wrapper-edit').remove();
      $('#size_wrapper-edit-add').remove();
      $('#brand_wrapper-edit').remove();
      $('#brand_wrapper-edit-add').remove();
    }
  });

// 初期子カテゴリー選択後のイベント
  $('#child_category-edit').on('change', function(){
    var childCategory = document.getElementById('child_category-edit').value; //選択された子カテゴリーの名前を取得
    console.log(childCategory)
    if (childCategory != "---"){ //子カテゴリーが初期値でないことを確認
      $.ajax({
        url: '/products/get_category_grandchildren',
        type: 'GET',
        data: { child_id: childCategory },
        dataType: 'json'
      })
      .done(function(grandchildren){
        if (grandchildren.length != 0) {
          $('#grandchild_category-edit').remove();
          $('#grandchild_category-edit-add').remove();
          $('#size_wrapper-edit').remove();
          $('#size_wrapper-edit-add').remove();
          $('#brand_wrapper-edit').remove();
          $('#brand_wrapper-edit-add').remove();
          var insertHTML = '';
          grandchildren.forEach(function(grandchild){
            insertHTML += appendOption(grandchild);
          });
          appendEditGrandchidrenBox(insertHTML);
        }
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#grandchild_category-edit').remove();
      $('#grandchild_category-edit-add').remove();
      $('#size_wrapper-edit').remove();
      $('#size_wrapper-edit-add').remove();
      $('#brand_wrapper-edit').remove();
      $('#brand_wrapper-edit-add').remove();
    }
  });


  // 子カテゴリー選択後のイベント
  $('.detail-right-cate-top').on('change', '#child_category-edit-add', function(){
    var childId = $('#child_category-edit-add option:selected').data('category'); //選択された子カテゴリーのidを取得
    if (childId != "---"){ //子カテゴリーが初期値でないことを確認
      $.ajax({
        url: '/products/get_category_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        dataType: 'json'
      })
      .done(function(grandchildren){
        if (grandchildren.length != 0) {
          $('#grandchild_category-edit').remove();
          $('#grandchild_category-edit-add').remove();
          $('#size_wrapper-edit').remove();
          $('#size_wrapper-edit-add').remove();
          $('#brand_wrapper-edit').remove();
          $('#brand_wrapper-edit-add').remove();
          var insertHTML = '';
          grandchildren.forEach(function(grandchild){
            insertHTML += appendOption(grandchild);
          });
          appendEditGrandchidrenBox(insertHTML);
        }
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#grandchild_category-edit').remove();
      $('#grandchild_category-edit-add').remove();
      $('#size_wrapper-edit').remove();
      $('#size_wrapper-edit-add').remove();
      $('#brand_wrapper-edit').remove();
      $('#brand_wrapper-edit-add').remove();
    }
  });

  // 既存孫カテゴリー選択後のイベント(サイズ選択)
  $('#grandchild_category-edit').on('change', function(){
    var grandchildId = document.getElementById('grandchild_category-edit').value; //選択された孫カテゴリーのidを取得
    if (grandchildId != "---"){ //子カテゴリーが初期値でないことを確認
      $.ajax({
        url: '/products/get_size',
        type: 'GET',
        data: { grandchild_id: grandchildId },
        dataType: 'json'
      })
      .done(function(sizes){
        if (sizes.length != 0) {
          $('#size_wrapper-edit').remove();
          $('#size_wrapper-edit-add').remove();
          $('#brand_wrapper-edit').remove();
          $('#brand_wrapper-edit-add').remove();
          var insertHTML = '';
          sizes.forEach(function(size){
            insertHTML += appendsizes(size);
          });
          appendEditSizeBox(insertHTML);
          appendEditBrandBox()
        }
        else {
          $('#size_wrapper-edit').remove();
          $('#size_wrapper-edit-add').remove();
          $('#brand_wrapper-edit').remove();
          $('#brand_wrapper-edit-add').remove();
          appendEditBrandBox()
        }

      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#size_wrapper-edit').remove();
      $('#size_wrapper-edit-add').remove();
      $('#brand_wrapper-edit').remove();
      $('#brand_wrapper-edit-add').remove();
    }
  });

  // 孫カテゴリー選択後のイベント(サイズ選択)
  $('.detail-right-cate-top').on('change', '#grandchild_category-edit-add', function(){
    var grandchildId = $('#grandchild_category-edit-add option:selected').data('category'); //選択された孫カテゴリーのidを取得
    if (grandchildId != "---"){ //子カテゴリーが初期値でないことを確認
      $.ajax({
        url: '/products/get_size',
        type: 'GET',
        data: { grandchild_id: grandchildId },
        dataType: 'json'
      })
      .done(function(sizes){
        if (sizes.length != 0) {
          $('#size_wrapper-edit-add').remove();
          $('#brand_wrapper-edit-add').remove();
          var insertHTML = '';
          sizes.forEach(function(size){
            insertHTML += appendsizes(size);
          });
          appendEditSizeBox(insertHTML);
          appendEditBrandBox()
        }
        else {
          $('#size_wrapper-edit-add').remove();
          $('#brand_wrapper-edit-add').remove();
          appendEditBrandBox()
        }

      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#size_wrapper-edit-add').remove();
      $('#brand_wrapper-edit-add').remove();
    }
  });

  // ブランド入力後のイベント
  $('.products-new_main-right-details').on('keyup', '#product-brand-form-edit-add', function(e){
    e.preventDefault();
    var input = $("#product-brand-form-edit-add").val();
    if (!input){
      $('.product-brand-suggest-box').empty();
      return
    }
    $.ajax({
      url: '/products/get_brand',
      type: 'GET',
      data: { keyword: input },
      dataType: 'json'
    })
    .done(function(brands){
      $('.product-brand-suggest-box').empty();
      
      if (brands.length !== 0) {
        var insertHTML = '';
        brands.forEach(function(brand){
          insertHTML += appendbrands(brand);
        });
        EditBrandListBox(insertHTML);
      }
    })
    .fail(function(){
      alert('カテゴリー取得に失敗しました');
    })
  });

  // 既存ブランド入力後のイベント
  $('#product-brand-form-edit').on('keyup', function(e){
    e.preventDefault();
    var input = $("#product-brand-form-edit").val();
    if (!input){
      $('.product-brand-suggest-box').empty();
      return
    }
    $.ajax({
      url: '/products/get_brand',
      type: 'GET',
      data: { keyword: input },
      dataType: 'json'
    })
    .done(function(brands){
      $('.product-brand-suggest-box').empty();
      
      if (brands.length !== 0) {
        var insertHTML = '';
        brands.forEach(function(brand){
          insertHTML += appendbrands(brand);
        });
        EditBrandListBox(insertHTML);
      }
    })
    .fail(function(){
      alert('カテゴリー取得に失敗しました');
    })
  });

  $('.products-new_main-right-details').on('click', '.product-brand-suggest-list', function(){
    var brandName = $(this).data('name');
    var brandId = $(this).data('id');
    $(".detail-right-brand-box").empty();
    appendEditSelectBrand(brandName)
    appendEditHiddenBrand(brandId)
  });
});