<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%= url('/styles/site_css.css') %>" rel="stylesheet" type="text/css" />
</head>
<body>

<div class="header">
  <h1> Rspectors Booking Requests </h1>
</div>


<div class="row">
  <div class="create_container page_info_container">
    <div class="page_info_header_container">
      <h3>Your Requests:</h3>
    </div>
    <div class="page_info_message_container">
       Here you can view the booking requests you have made:
    </div>
  </div>
</div>

<div class="listings_container main_body">
  <% @all_bookings.each do |booking| %>
    <div class="space_container item_container">
      <div class="space_info">
        <div class="space_header">
          <b><%= booking.status %></b>
        </div>
        <div class="space_description">
          <p><%= booking.date %></p>
        </div>

      </div>
    </div>
  <% end %>
</div>

</body>
</html>
