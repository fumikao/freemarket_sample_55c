$(window).on('load', function(){
  if (location.href.match(/\/items\/\d+\/edit/)){
    var imagelabel1 = $('.o_image-label1')
    var imagelabel2 = $('.o_image-label2')
    var imagezone1 = $('.o_image-zone1-parent')
    var imagezone2 = $('.o_image-zone2-parent')
    
    var images = []
    var registered_images_ids = []
    var new_image_files = []
    
    //アップロードされている画像の表示
    $.each(gon.images, function(i, image){
      var img = $('<div class="add_img"><div class="img_area"><img class="image"></div></div>')
      var btn = $('<div class="btn_wrapper"><a class="btn_delete">削除</a></div>')
      img.attr("data-image", i)
      img.append(btn)
      
      binary_data = gon.item_images_binary_datas[i]

      img.find("img").attr({
        src: "data:image/jpeg;base64," + binary_data
      });
      
      images.push(img)
      registered_images_ids.push(image.id)
    })
    
    if (images.length <= 4) {
      $('#preview1').text('');
      $.each(images, function(i, image){
        $('#preview1').append(image);
      })
      imagelabel1.css({
        width: `calc(100% - (20% * ${images.length})`
      })
    } else if (images.length == 5) {
      $('#preview1').text('');
      $.each(images, function(i, image){
        $('#preview1').append(image);
      })
      imagelabel1.css({
        display: "none"
      })
      imagezone2.css({
        display: "block"
      })
    } else {
      var firstrow_images = images.slice(0, 5)
      $('#preview1').text()
      $.each(firstrow_images, function(i, image) {
        $('#preview1').append(image)
      })
      
      var secondrow_images = images.slice(5)
      $.each(secondrow_images, function(i, image){
        $('#preview2').append(image);
      })
      imagelabel1.css({
        display: 'none'
      })
      imagezone2.css({
        display: 'block'
      })
      imagelabel2.css({
        width: `calc(100% - (20% * ${images.length - 5})`
      })
    }
    
    if (images.length == 10) {
      imagelabel2.css({
        display: "none"
      })
    }
    
    var new_image = $(
      `<input multiple= "multiple" name="item_images[image][]" class="upload-image" data-image= ${images.length} type="file" id="upload-image">`
    );
    $('preview-btn').append(new_image);
    
    //追加
    $(document).on('change', 'input[type= "file"]', function(){
      var file = $(this).prop('files')[0];
      new_image_files.push(file);
      var reader = new FileReader();

      var img = $('<div class="add_img"><div class="img_area"><img class="image"></div></div>')
      var btn = $('<div class="btn_wrapper"><a class="btn_delete">削除</a></div>')
      img.append(btn);
      
      reader.onload = function(e) {
        img.find('img').attr({ src: e.target.result });
      };
      
      reader.readAsDataURL(file);
      images.push(img);

      if (images.length <= 4) {
        $('#preview1').text('');
        $.each(images, function(i, image){
          image.attr('data-image', i);
          $('#preview1').append(image);
        })
        imagelabel1.css({
          width: `calc(100% - (20% * ${images.length})`
        })
      } else if (images.length == 5) {
        $('#preview1').text('');
        $.each(images, function(i, image){
          image.attr('data-image', i);
          $('#preview1').append(image);
        })
        imagelabel1.css({
          display: "none"
        })
        imagezone2.css({
          display: "block"
        })
      } else {
        var firstrow_images = images.slice(0, 5)
        $('#preview1').text('')
        $.each(firstrow_images, function(i, image) {
          image.attr('data-image', i)
          $('#preview1').append(image)
        })

        $('#preview2').text('')
        var secondrow_images = images.slice(5)
        $.each(secondrow_images, function(i, image){
          image.attr('data-image', i + 5);
          $('#preview2').append(image);
        })
        imagelabel2.css({
          width: `calc(100% - (20% * ${images.length - 5})`
        })
      }
      if (images.length == 10) {
        imagelabel2.css({
          display: "none"
        })
      }
      
      var new_image = $(`<input multiple="multiple" name="images[images][]" data-image=${images.length} type="file" id="item_images_attributes_0_image">`);
      $('.preview-btn').append(new_image);
    })
    
    // 削除
    $(document).on('click', '.btn_delete', function(){
      var target_image = $(this).parent().parent();
      var target_image_num = target_image.attr('data-image');
      target_image.remove();
      images.splice(target_image_num, 1);
      
      if (target_image_num < registered_images_ids.length){
        registered_images_ids.splice(target_image_num, 1)
      } else {
        new_image_files.splice((target_image_num - registered_images_ids.length), 1)
      }
      
      if (images.length == 0) {
        $('input[type="file"]').attr('data-image', 0)
      }
      
      if (images.length <= 4) {
        $('#preview1').text('');
        $.each(images, function(i, image){
          image.attr('data-image', i);
          $('#preview1').append(image);
        })
        imagelabel1.css({
          display: 'block',
          width: `calc(100% - (20% * ${images.length})`
        })
        imagezone2.css({
          display: 'none'
        })
      } else if (images.length == 5) {
        $('#preview1').text('');
        $.each(images, function(i, image){
          image.attr('data-image', i);
          $('#preview1').append(image);
        })
        imagezone1.css({
          display: 'block'
        })
        imagelabel2.css({
          width: '100%'
        })
        imagelabel1.css({
          display: 'none'
        })
        $('#preview2').text('')
      } else {
        var firstrow_images = images.slice(0, 5)
        $('#preview1').text('')
        $.each(firstrow_images, function(i, image) {
          image.attr('data-image', i)
          $('#preview1').append(image)
        })
        
        var secondrow_images = images.slice(5)
        $.each(secondrow_images, function(i, image){
          image.attr('data-image', i + 5)
          $('#preview2').append(image)
          imagelabel2.css({
            display: 'block',
            width: `calc(100% - (20% * ${images.length - 5})`
          })
        })
      }
    })
    
    $('#sell-price').on('keyup', function(){
      var price = $(this).val();
      var mercari_fee = Math.floor(price * 0.1)
      var seller_gain = price - mercari_fee
  
      if (price >= 300 && price <= 9999999) {
        $('#mercari_fee').text('¥' + mercari_fee.toLocaleString())
        $('#seller_gain').text('¥' + seller_gain.toLocaleString())
      } else {
        $('#mercari_fee').text('-')
        $('#seller_gain').text('-')
      }
    })
    
    // データ送信
    $('.edit_item').on('submit', function(e) {
      e.preventDefault();
      var formData = new FormData(this);
      formData.delete('images[images][]');
      if (registered_images_ids.length == 0){
        formData.append("registered_images_ids[ids][]", 0)
      } else {
        $.each(registered_images_ids, function(i, id){
          formData.append("registered_images_ids[ids][]", id)
        })
      }
      
      if (new_image_files.length == 0){
        formData.append("images[images][]", " ")
      } else {
        $.each(new_image_files, function(i, file){
          formData.append("images[images][]", file)
        })
      }

      var grandchild_id = $('#category_grandchildren').val()
      formData.append("category_id", grandchild_id)

      var brand_name = $('#brand').val()
      if (brand_name != " ") {
        formData.append("brand_name", brand_name)
      }

      $.ajax({
        url: '/items/' + gon.item.id,
        type: 'PATCH',
        data: formData,
        dataType: 'json',
        contentType: false,
        processData: false
      })
      .done(function(){
        location.href = `/items/${gon.item.id}/seller`
      })
      .fail(function() {
      })
      .always(function(){
        $("input[type=submit]").removeAttr("disabled");
      })
    })
  }
})