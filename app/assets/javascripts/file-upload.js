$(document).ready(function() {

  $('.file-upload-proxy').on('click', function() {
    $(this).closest('.file-upload').find('input[type=file]').click();
  });


  $('.file-upload input[type=file]').on('change', function() {
    var $input = $(this);
    $(this).closest('.file-upload').find('.file-upload-proxy').text($input.val().replace(/^.*[\\\/]/, ''));
  });
});
