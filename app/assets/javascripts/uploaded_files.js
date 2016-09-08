$(document).ready(function() {
  $('.btn-file-uploader').on('click', function() {
    // $(this).data('id')
    $(this).closest('.file-uploader-wrapper').find('.file-uploader-input').click();
  })
  $('.file-uploader-input').on('change', function() {
    $(this).closest("form").submit();
  })
  $('.file-uploader-form').on('submit', function() {
    var form_data = new FormData();
    var $this = $(this);
    var file_input = $this.find('.file-uploader-input')[0];
    form_data.append('uploaded_file[file]', file_input.files[0]);
    var user_id = $this.find('.file-uploader-user').val();
    form_data.append('uploaded_file[user_id]', user_id);
    file_input.type = '';
    file_input.type = 'file';
    $.ajax({
      url: $this.attr('action'),
      type: 'PUT',
      dataType: "json",
      data: form_data,
      cache: false,
      contentType: false,
      processData: false,
      success: function (res) {
        var $wrapper = $this.closest('.file-uploader-wrapper').find('.uploaded-file-wrapper');
        $wrapper.html(
          '<a href="' + res.file + '" target="_blank">' + res.file_file_name + '</a> ' +
          '<a class="delete-uploaded-file-link" data-confirm="Are you sure?" rel="nofollow" data-remote="true" data-method="delete" href="/uploaded_files/' + res.id + '">' +
            '<i class="fa fa-remove"></i>' + 
          '</a>'
        );
      }
    });

    return false;
  })
});