$(document).ready(function(){

  navigator.geolocation.getCurrentPosition(GetLocation);
    var user_lat = 0, user_lon = 0;
    function GetLocation(location) {
      user_lat = location.coords.latitude;
      user_lon = location.coords.longitude;

      console.log(user_lat);
      console.log(user_lon);
    }

  $('#pace_select, #age_select, #time_select').toggle();

  $('#radius_select, #gender_select').change(function(){
    $('#pace_select, #age_select, #time_select').hide();
    $('#filter_select').val('0');
  });

  $('#filter_select').change(function() {
    var filter = "#" + $("#filter_select option:selected").text() + "_select";
    filter = filter.toLowerCase();
    $('#pace_select, #age_select, #time_select').hide();
    $(filter).toggle();
  });

  $('#radius_select, #gender_select, #pace_select, #age_select').change(function(){
    $.ajax({
      type: "GET",
      url: "/posts/filter.js",
      data: $("#post_filters_form").serialize() + "&user_lat=" + user_lat + "&user_lon=" + user_lon,
      success : function(text) {
        // alert('success');
        // console.log(text);
      }
    });
  });

});
