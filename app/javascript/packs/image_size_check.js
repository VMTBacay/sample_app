function size_check_and_preview() {
  var size_in_megabytes = this.files[0].size/1024/1024;
  if (size_in_megabytes > 5) {
    alert("Maximum file size is 5MB. Please choose a smaller file.");
    $("#micropost_image").val("");
    $('#img_prev').attr('src', "");
  } else {
    if (this.files && this.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $('#img_prev').attr('src', e.target.result);
      };

      reader.readAsDataURL(this.files[0]);
    }
  }
}

$("#micropost_image").bind("change", size_check_and_preview);
$("#user_image").bind("change", size_check_and_preview);
