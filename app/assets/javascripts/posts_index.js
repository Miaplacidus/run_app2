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
  $('#radius_select, #gender_select, #pace_select, #age_select').change(submit_post_filters_form);
  $('#post_filters_form').submit(submit_post_filters_form);
  $('#new_post').submit(submit_post_create_form);

  function submit_post_filters_form(){
    // missing? event.preventDefault();
    $.ajax({
      type: "GET",
      url: "/posts/filter.js",
      data: $("#post_filters_form").serialize() + "&user_lat=" + user_lat + "&user_lon=" + user_lon,
      dataType: 'json',
      success : function(json_posts) {
        $('.post_filters_results').empty();
        var post_info = "<li class='post_box'><ul class='post-summary'><li><div id='gmaps-container<%-post.id%>' style='position:relative;width:100%;height:220px;background-color:#e7eaf0;border-top-left-radius:7px;border-top-right-radius:7px;'></div><div id='zoom-in'></div><div id='zoom-out'></div></li> <li><span class='post-address'><%- post.address %></span></li> <li><%- post.time_in_tz %></li> <li><%- post.gender_preference %></li> <li>Pace: <%- post.pace_title %></li> <li>Age Preference: <%- post.age_preference_range %></li> <li>Minimum Distance: <%- post.min_distance %></li> <li>Commitment: $<%- post.min_amt %></li> <li>Notes: <%- post.notes %></li> <li>Associated Circle: <% if (post.circle) { %><%- post.circle.name %> <% } %></li> <li>Organizer: <%- post.organizer.first_name %>, <%- post.organizer.gender %></li> <li>Runners: <%- post.runners %> -> <%- post.runners.count %> / <%- post.max_runners %></li></ul></li>";
        var list = '<% _.forEach(posts, function(post) { %>' + post_info + '<% }); %>';
        var liTemplate = _.template(list, {"posts": json_posts.posts });
        $(".post_filters_results").append('<ul class= "grid effect-2" id="grid">' + liTemplate + '</ul>');
        console.log(json_posts.posts);
        setMapValues(json_posts.posts);
      }
    });
  }

  function submit_post_create_form(){
    $.ajax({
      type: "POST",
      url: "/posts.js",
      data: $("#new_post").serialize(),
      dataType: 'json',
      success: function(json_post) {
        var post_info = "<h3>Run Successfully Scheduled</h3><ul><li><%- post.address %></li> <li><div id='gmaps-container<%-post.id%>' style='position:relative;width:100%;height:220px;background-color:#e7eaf0'></div><div id='zoom-in'></div><div id='zoom-out'></div></li><li><%- post.time_in_tz %></li> <li><%- post.gender_preference %></li> <li>Pace: <%- post.pace_title %></li> <li>Age Preference: <%- post.age_preference_range %></li> <li>Minimum Distance: <%- post.min_distance %></li> <li>Commitment: $<%- post.min_amt %></li> <li>Notes: <%- post.notes %></li> <li>Associated Circle: <% if (post.circle) { %><%- post.circle.name %> <% } %></li> <li>Organizer: <%- post.organizer.first_name %>, <%- post.organizer.gender %></li> <li>Runners: <%- post.runners %> -> <%- post.runners.length %> / <%- post.max_runners %></li></ul>";
        var liTemplate = _.template(post_info, {"post": json_post.post});
        $("#postcreatemodal .modal-body").html(liTemplate);
        setMapValues(json_post);
      }
    });
    // $("#new_post")[0].reset();
  }

  $('#postcreatemodal').on('hidden.bs.modal', function () {
    $.get("/posts/get_form", function(data){
      $("#postcreatemodal .modal-dialog").html(data);
    });
  });

  function setMapValues(json_posts){
    for (var post in json_posts) {
      var location = json_posts[post].location.match(/(\-?\d{1,}\.\d{1,})\s(\-?\d{1,}\.\d{1,})/);
      var latitude = parseFloat(location[2]);
      var longitude = parseFloat(location[1]);
      createMap(latitude, longitude, json_posts[post].id);
    }
  }

});
