$(window).on('load', function(){
  var name = $('.k_ir_section__inner--form2-input')
  var description = $('.k_ir_section__inner--form2-textarea')
  var parent_category = $('#category_parent')
  var child_category = $('#category_children')
  var grandchild_category = $('#category_grandchildren')
  var condition = $('.condition')
  var shipping_fee = $('#shipping_fee')
  var shipping_method = $('#shipping_method')
  var prefecture_id = $('.prefecture_id')
  var shipping_date = $('.shipping_date')
  var price = $('#sell-price')

  $('#new_item, .edit_item').on('submit', function() {
    if ($('#preview1').children()[0] == undefined) {
      $('.error_image').text('画像がありません')
    }
    if (name.val() == "") {
      $('.error_name').text('入力してください')
    }
    if (name.val().length > 40) {
      $('.error_name').text('40文字以内で入力してください')
    }
    if (description.val() == "") {
      $('.error_description').text('入力してください')
    }
    if (description.val().length > 1000) {
      $('.error_description').text('1000文字以内で入力してください')
    }
    if (parent_category.val() == "" || child_category.val() == "" || grandchild_category.val() == "" ) {
      $('.error_category').text('選択してください')
    }
    if (condition.val() == "") {
      $('.error_condition').text('選択してください')
    }
    if (shipping_fee.val() == "") {
      $('.error_shipping_fee').text('選択してください')
    }
    if (shipping_method.val() == "") {
      $('.error_shipping_method').text('選択してください')
    }
    if (prefecture_id.val() == "") {
      $('.error_prefecture_id').text('選択してください')
    }
    if (shipping_date.val() == "") {
      $('.error_shipping_date').text('選択してください')
    }
    if (price.val() == "") {
      $('.error_price').text('入力してください')
    }
    if (price.val() != "" && (price.val() < 300 || price.val() > 9999999)) {
      $('.error_price').text('300以上9999999以下で入力してください')
    }
  })
})