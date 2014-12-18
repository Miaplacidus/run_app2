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

// TODO: Nest geolocation or provide refresh button or loading bar
  $('#radius_select, #gender_select, #pace_select, #age_select').change(function(){
    $.ajax({
      type: "GET",
      url: "/posts/filter.js",
      data: $("#post_filters_form").serialize() + "&user_lat=" + user_lat + "&user_lon=" + user_lon,
      dataType: 'json',
      success : function(json_posts) {
        console.log(json_posts);
        $('.post_filters_results').empty();
        // _.each(json_posts.posts, function(post){
        //   var liTemplate = "<ul><li>";
        //   console.log(post);
        //   liTemplate +=
        //   liTemplate += post.pace_title;
        //   liTemplate += "</li></ul>";
        //   $(".post_filters_results").append(liTemplate);
        // });
        var list = '<% _.forEach(posts, function(post) { %><ul><li><%- post.pace_title %></li></ul><% }); %>';
        console.log(_.template(list, {"posts": json_posts.posts }));

        // var list = '<% _.forEach(people, function(name) {
        //   %><li><%- name %></li><%
        // }); %>';
        // _.template(list, { 'people': ['fred', 'barney'] });
      }
    });
  });

});
