$(function(){
  $("#show_contact_form").on("click", function(e){
    e.preventDefault();
    $("#contact-form").show();
    $(this).hide();
  });
});
