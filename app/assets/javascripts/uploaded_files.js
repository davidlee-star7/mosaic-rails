$(document).ready(function() {
  $('.btn-file-uploader').on('click', function() {
    // $(this).data('id')
    $(this).closest('.file-uploader-wrapper').find('.file-uploader-input').click();
  })
  $('.file-uploader-input').on('change', function() {
    $(this).closest("form").submit();
  })
  $('.file-uploader-form').on('submit', function() {
    var file = new FormData();
    var $this = $(this);
    file.append('uploaded_file[file]', $this.find('.file-uploader-input')[0].files[0]);
    $.ajax({
      url: $this.attr('action'),
      type: 'PUT',
      dataType: "json",
      data: file,
      cache: false,
      contentType: false,
      processData: false,
      success: function (res) {
        var $wrapper = $this.closest('.file-uploader-wrapper').find('.uploaded-file-wrapper');
        if (res.file_content_type.startsWith('image')) {
          $wrapper.html('<img src="' + res.file + '" alt="" style="max-width: 100%;" />');
        } else {
          $wrapper.html('<a href="' + res.file + '">' + res.file_file_name+ '</a>');
        }
      }
    });

    return false;
  })
});