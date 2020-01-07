// 画像複数枚保存イベント
$(function(){
  var dropzone = $('.dropzone-area');
  var dropzone2 = $('.dropzone-area2');
  var images = [];
  var inputs  =[];
  var input_area = $('.input_area');
  var preview = $('#preview');
  var preview2 = $('#preview2');
  
  $(document).on('change', 'input[type= "file"]#upload-image',function() {
    var count = gon.count
    var file = $(this).prop('files')[0];
    var reader = new FileReader();
    inputs.push($(this));
    var img = $( `<div class= "img_view">
                    <div class=img_view_upper>
                      <img class= "product-new-img">
                    </div>
                  </div>`);
    reader.onload = function(e) {
      var btn_wrapper = $(`<div class="btn_wrapper"><div class="btn_edit">編集</div><div class="btn_delete">削除</div></div>`);
      img.append(btn_wrapper);
      img.find('img').attr({src: e.target.result})
    }
    reader.readAsDataURL(file);
    images.push(img);

    if(images.length >= (5 - count)) {
      dropzone2.css({
        'display': 'block'
      })
      dropzone.css({
        'display': 'none'
      })
      $.each(images, function(index, image) {
        image.attr('data-image', index);
        preview2.append(image);

        dropzone2.css({
          'width': `calc(100% - (126px * ${images.length - 5 + count}))`
        })
      })
      if(images.length >= (6 - count)) {
        dropzone2.css({
          'position': 'absolute'
        })
      }
      if(images.length == (9 - count)) {
        dropzone2.find('p').replaceWith('<i class="fa fa-camera"></i>')
      }
    } else {
      $.each(images, function(index, image) {
        image.attr('data-image', index);
        preview.append(image);
      })
      dropzone.css({
        'width': `calc(100% - (126px * ${images.length + count}))`
      })
    }
    if(images.length == (4 - count)) {
      dropzone.find('p').replaceWith('<i class="fa fa-camera"></i>')
    }
    if(images.length == (10 - count)) {
      dropzone2.css({
        'display': 'none'
      })
      return;
    }
    var new_image = $(`<input multiple= "multiple" name="images[url][]" data-image= ${images.length} type="file" id="upload-image" class="upload-image">`);
    input_area.prepend(new_image);
  });

// 削除イベント
  $(document).on('click', '.btn_delete', function() {
    var target_image = $(this).parent().parent();
    $.each(inputs, function(index, input){
      if ($(this).data('image') == target_image.data('image')){
        $(this).remove();
        target_image.remove();
        var num = $(this).data('image');
        images.splice(num, 1);
        inputs.splice(num, 1);
        if(inputs.length == 0) {
          $('input[type= "file"].upload-image').attr({'data-image': 0})
        }
      }
    })
    $('input[type= "file"].upload-image:first').attr({
      'data-image': inputs.length
    })
    $.each(inputs, function(index, input) {
      var input = $(this)
      input.attr({
        'data-image': index
      })
      $('input[type= "file"].upload-image:first').after(input)
    })
    if (images.length >= 5) {
      dropzone2.css({
        'display': 'block'
      })
      $.each(images, function(index, image) {
        image.attr('data-image', index);
        preview2.append(image);
      })
      dropzone2.css({
        'width': `calc(100% - (126px * ${images.length - 5}))`
      })
      if(images.length == 9) {
        dropzone2.find('p').replaceWith('<i class="fa fa-camera"></i>')
      }
      if(images.length == 8) {
        dropzone2.find('i').replaceWith('<p>ドラッグ&ドロップまたはクリックしてファイルをアップロード</p>')
      }
    } else {
      dropzone.css({
        'display': 'block'
      })
      $.each(images, function(index, image) {
        image.attr('data-image', index);
        preview.append(image);
      })
      dropzone.css({
        'width': `calc(100% - (126px * ${images.length}))`
      })
    }
    if(images.length == 4) {
      dropzone2.css({
        'display': 'none'
      })
    }
    if(images.length == 3) {
      dropzone.find('i').replaceWith('<p>ドラッグ&ドロップまたはクリックしてファイルをアップロード</p>')
    }
  })

  $(".btn_delete").on("click", function() {
    var target_image = $(this).parent().parent();
    var img_id = target_image.data('id')
    target_image.remove();
    hidden_form = `<input type="hidden", name="[delete_ids][]", value="${img_id}">`
    $('.dropzone-container3').append(hidden_form)
  });
})