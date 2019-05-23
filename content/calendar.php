<div class="row clearfix">
            <div></div>
		<div class="col-md-12 column">
			<ul class="breadcrumb">
				<li>
					<a href="#">Home</a> <span class="divider">/</span>
				</li>
				<li>
					<a href="#">News</a> <span class="divider">/</span>
				</li>
				<li class="active">
					Latest
				</li>
			</ul>
	</div>
</div>


<link href='dist/fullcalendar/fullcalendar.css' rel='stylesheet' />
<link href='dist/fullcalendar/fullcalendar.print.css' rel='stylesheet' media='print' />
<script src='dist/lib/jquery-ui.custom.min.js'></script>
<script src='dist/fullcalendar/fullcalendar.min.js'></script>
<script>
$(document).ready(function() {
  var date = new Date();
  var d = date.getDate();
  var m = date.getMonth();
  var y = date.getFullYear();

  var calendar = $('#calendar').fullCalendar({
   editable: true,
   header: {
    left: 'prev,next today',
    center: 'title',
    right: 'month,agendaWeek,agendaDay'
   },
   
   events: "http://bioinfo.umassmed.edu/php/events.php",
   
   // Convert the allDay from string to boolean
   eventRender: function(event, element, view) {
    if (event.allDay === 'true') {
     event.allDay = true;
    } else {
     event.allDay = false;
    }
   },
   <?php
   if (!empty($_SESSION['admin']))
   {   
   ?>
   selectable: true,
   selectHelper: true,
   select: function(start, end, allDay) {
   var title = prompt('Event Title:');
   //var url = prompt('Type Event url, if exits:');
   var url = '';
   if (title) {
   var start = $.fullCalendar.formatDate(start, "yyyy-MM-dd HH:mm:ss");
   var end = $.fullCalendar.formatDate(end, "yyyy-MM-dd HH:mm:ss");
   $.ajax({
   url: 'http://bioinfo.umassmed.edu/php/add_events.php',
   data: 'title='+ title+'&start='+ start +'&end='+ end +'&url='+ url ,
   type: "POST",
   success: function(json) {
   alert('Added Successfully');
   }
   });
   calendar.fullCalendar('renderEvent',
   {
   title: title,
   start: start,
   end: end,
   allDay: allDay
   },
   true // make the event "stick"
   );
   }
   calendar.fullCalendar('unselect');
   },
   editable: true,
   eventDrop: function(event, delta) {
   var start = $.fullCalendar.formatDate(event.start, "yyyy-MM-dd HH:mm:ss");
   var end = $.fullCalendar.formatDate(event.end, "yyyy-MM-dd HH:mm:ss");
   $.ajax({
   url: 'http://bioinfo.umassmed.edu/php/update_events.php',
   data: 'title='+ event.title+'&start='+ start +'&end='+ end +'&id='+ event.id ,
   type: "POST",
   success: function(json) {
    alert("Updated Successfully");
   }
   });
   },
   eventResize: function(event) {
   var start = $.fullCalendar.formatDate(event.start, "yyyy-MM-dd HH:mm:ss");
   var end = $.fullCalendar.formatDate(event.end, "yyyy-MM-dd HH:mm:ss");
   $.ajax({
    url: 'http://bioinfo.umassmed.edu/php/update_events.php',
    data: 'title='+ event.title+'&start='+ start +'&end='+ end +'&id='+ event.id ,
    type: "POST",
    success: function(json) {
     alert("Updated Successfully");
    }
   });

  },
  eventClick: function(event) {
    var decision = confirm("Do you want to delete the event?"); 
    if (decision) {
     $.ajax({
     type: "POST",
     url: "http://bioinfo.umassmed.edu/php/delete_events.php",

     data: "&id=" + event.id
    });
    calendar.fullCalendar('removeEvents', event.id);
    calendar.fullCalendar( 'renderEvents' );


   } else {
   }
   }
   <?}?>
  });
  
 });

</script>
<style>

 body {
  margin-top: 40px;
  text-align: center;
  font-size: 14px;
  font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;

  }


 #calendar {
  width: 900px;
  margin: 0 auto;
  }

</style>
<div id='loading' style='display:none'>loading...</div>
<div id='calendar'></div>

