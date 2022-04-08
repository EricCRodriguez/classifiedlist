$(function(){
  $("#language-select").on("change", function(){
    $.ajax({
      url: "/locale/set",
      method: "post",
      data: {
        language: this.value
      },
      success: function(){
        window.location.reload();
      }
    });
  });
});
