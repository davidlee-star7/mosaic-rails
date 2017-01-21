CKEDITOR.editorConfig = function(config) {
  //config.language = 'es'; //this could be any language
  // config.width = '725';
  // config.height = '600';

  // Filebrowser routes
  // The location of an external file browser, that should be launched when "Browse Server" button is pressed.
  config.filebrowserBrowseUrl = "/ckeditor/attachment_files";
  // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Flash dialog.
  config.filebrowserFlashBrowseUrl = "/ckeditor/attachment_files";
  // The location of a script that handles file uploads in the Flash dialog.
  config.filebrowserFlashUploadUrl = "/ckeditor/attachment_files";
  // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Link tab of Image dialog.
  config.filebrowserImageBrowseLinkUrl = "/ckeditor/pictures";
  // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Image dialog.
  config.filebrowserImageBrowseUrl = "/ckeditor/pictures";
  // The location of a script that handles file uploads in the Image dialog.
  config.filebrowserImageUploadUrl = "/ckeditor/pictures";
  // The location of a script that handles file uploads.
  config.filebrowserUploadUrl = "/ckeditor/attachment_files";

// You could delete or reorder any of this elements as you wish
  config.language = 'hi';
 
  config.toolbar = 'Menu';

  config.allowedContent = {
    $1: {
      // Use the ability to specify elements as an object.
      elements: CKEDITOR.dtd,
      attributes: true,
      styles: true,
      classes: true
    }
  };

/*editor.filter.addElementCallback( function( el ) {
    if ( el.hasClass( 'tableauPlaceholder' ) )
        return CKEDITOR.FILTER_SKIP_TREE;
} );*/
  
  config.extraPlugins = 'fileUploader';
  return true;
};

CKEDITOR.plugins.add('fileUploader',
{
  init: function (editor) {
    var pluginName = 'fileUploader';
    editor.ui.addButton('InsertUploader', {
        label: 'Insert Uploader',
        command: 'insertUploader',
        icon: CKEDITOR.plugins.getPath('fileUploader') + 'insert-uploader.png',
        toolbar: 'insert,100'
      });
    var cmd = editor.addCommand('insertUploader', { exec: insertUploader });
  }
});

function insertUploader(editor) {
  $.ajax({
    url: "/uploaded_files",
    contentType: 'application/json',
    dataType: "json",
    method: 'POST',
    data: '{"uploaded_file": {"id": null}}'
  }).done(function(res) {
    editor.insertHtml("[fileuploader text='Upload file' id='" + res.id + "'][/fileuploader]");
  });
}
