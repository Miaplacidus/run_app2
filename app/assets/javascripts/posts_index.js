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
    $('#filter_select, #age_select').val('0');
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
        var post_info = "<li><%- post.address %></li> <li><%- post.time_in_tz %></li> <li><%- post.gender_preference %></li> <li>Pace: <%- post.pace_title %></li> <li>Age Preference: <%- post.age_preference_range %></li> <li>Minimum Distance: <%- post.min_distance %></li> <li>Commitment: $<%- post.min_amt %></li> <li>Notes: <%- post.notes %></li> <li>Associated Circle: <%- post.circle.name %></li> <li>Organizer: <%- post.organizer.first_name %>, <%- post.organizer.gender %></li> <li>Runners: <%- post.runners %> -> <%- post.runners.count %> / <%- post.max_runners %></li>"
        var list = '<% _.forEach(posts, function(post) { %><ul>' + post_info + '</ul><% }); %>';
        var liTemplate = _.template(list, {"posts": json_posts.posts });
        $(".post_filters_results").append(liTemplate);
      }
    });
  });

});
