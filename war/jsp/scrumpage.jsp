<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>Scrum Board </title>




<link rel="stylesheet" href="css/style.css">

<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>

<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
body
{

background-color:#337ab7;

}
.list-group-item {
margin-bottom: 5px;
}

h3
{
color: white;
margin-top: 0px;
margin-bottom:0px;
font-size:40px;

}
ul.list1{
list-style-type:none;
padding:0px;
margin-left: 100px;
}
ul{
list-style-type:none;
}
.selected {
background-color:white;
}
.container
{

margin-top: 100px;
}
.panel
{
background-color:#026aa7;
margin-left:0px;
}
.list2 .panel,.list3 .panel,.list4 .panel
{
margin-left:-40px;
}

.row {
margin-right: -120px;
margin-left: -27px;
}
img.icon
{
height:25px;
width: 20px;
}

.btn-sm {
font-size:15px;
} 
</style>

<script type="text/javascript">
var id = '<%= request.getParameter("id") %>';
var btn = new Array();
$(document).ready(function(){
var loaded = getData();

function getData(){
	  $.get("/scrum?id="+id,
function result(result){
console.log(result.toString());

for(var i = 0; i < result.length; i++){
btn.push('myBtn'+i);

//var data =	$("#task"+id).html(result[i].goals);
if(result[i].status == 'todo' || result[i].status == ''){
$('#table').append('<li class="list-group-item" data-taskId="'+result[i].id+'" id="'+result[i].id+'"> <span class="description" id="task'+i+'"><span><img src="images/edit.jpg" id="myBtn'+i+'" class="icon" title="Edit"/></span>' + result[i].goals + '</span></li>');
} else if(result[i].status == 'working'){
$('#table1').append('<li class="list-group-item" data-taskId="'+result[i].id+'" id="'+result[i].id+'"> <span class="description" id="task'+i+'"><span><img src="images/edit.jpg" id="myBtn'+i+'" class="icon" title="Edit"/></span>' + result[i].goals + '</span></li>');
} else if(result[i].status == 'verification'){
$('#table2').append('<li class="list-group-item" data-taskId="'+result[i].id+'" id="'+result[i].id+'"> <span class="description" id="task'+i+'"><span><img src="images/edit.jpg" id="myBtn'+i+'" class="icon" title="Edit"/></span>' + result[i].goals + '</span></li>');
} else if(result[i].status == 'verified'){
$('#table3').append('<li class="list-group-item" data-taskId="'+result[i].id+'" id="'+result[i].id+'"> <span class="description" id="task'+i+'"><span><img src="images/edit.jpg" id="myBtn'+i+'" class="icon" title="Edit"/></span>' + result[i].goals + '</span></li>');
}
}
attachClickEventToImage();

});
//setTimeout(getData,1000);
return true;
}
});


function openGoalsPage(){
window.location.href = "goals?id="+'<%= request.getParameter("id") %>';
}

function attachClickEventToImage(){
console.log(btn);
for (var i = 0; i < btn.length; i++) {
console.log("Button : "+i);
listenerForI( i );
}



var modal = document.getElementById('myModal');
function listenerForI( i ) {
console.log("This event was called by attachClickEventToImage!");
document.getElementById(btn[i]).addEventListener('click', function()
{
console.log("Called with Id : "+btn[i]);
modal.style.display = "block";

Update.onclick = function()
{
var decide1=document.getElementById("comment").value;
console.log("id" + $('#'+btn[i]).parent().parent().parent().data('taskid'));
$.post("/scrumpost",
	   		data={
	   	decide: decide1, id:$('#'+btn[i]).parent().parent().parent().data('taskid')
	   },
	  function result(result){
		  window.location.href ="/list";
	   	});

	   	$.get("/scrumget",
	   function result(result){
		  $('#'+btn[i]).val(result);
	  
		 window.location.href="/list1";

	   	});
	   	
modal.style.display = "none";
history.go();
}
Close.onclick = function() {
modal.style.display = "none";
}
});
}
}

$(function(){
$('body').on('click', '.list-group .list-group-item', function() {
var data;
$('.list-group .list-group-item').not(this).removeClass('active'); 
$(this).toggleClass('active');

if($(this).hasClass('active'))
{
$(this).find('.icon').show();
}
else{
$('.icon').hide();
}

$('.list-arrows button').click(function() {
var $button = $(this), actives = '';
if ($button.hasClass('move-left1')) {
actives = $('.list-right1 ul li.active');
data = document.getElementsByTagName("body")[0].id;
id = document.getElementsByClassName('list-group-item active')[0].id;
actives.prependTo('.list-left1 ul');
$.ajax({
url: '/trackingservlet',
type: 'POST',
data: "status=" +"todo" + "&id=" + id ,	
});
} 
else if ($button.hasClass('move-right1')) {
actives = $('.list-left1 ul li.active');

data = document.getElementsByTagName("body")[0].id;
id = document.getElementsByClassName('list-group-item active')[0].id;
actives.prependTo('.list-right1 ul');

$.ajax({
url: '/trackingservlet',
type: 'POST',
data: "status=" +"working" + "&id=" + id ,	
});
}
});
});
//-------------------------------------------------------------------------------------------------------------
$('.list-arrows button').click(function() {
var $button = $(this), actives = '';
if ($button.hasClass('move-left2')) {
actives = $('.list-left2 ul li.active');
data = document.getElementsByTagName("body")[0].id;
id = document.getElementsByClassName('list-group-item active')[0].id;
actives.prependTo('.list-right1 ul');
$.ajax({
url: '/trackingservlet',
type: 'POST',
data: "status=" + "working"+"&id=" +id ,
});
} 
else if ($button.hasClass('move-right2')) {
actives = $('.list-right1 ul li.active');
data = document.getElementsByTagName("body")[0].id;
id = document.getElementsByClassName('list-group-item active')[0].id;
actives.prependTo('.list-left2 ul');
$.ajax({
url: '/trackingservlet',
type: 'POST',
data: "status=" + "verification" +"&id=" + id ,
});
}

});
//---------------------------------------------------------------------------------------------
$('.list-arrows button').click(function() {
var $button = $(this), actives = '';
if ($button.hasClass('move-left3')) {
actives = $('.list-right2 ul li.active');
data = document.getElementsByTagName("body")[0].id;
id = document.getElementsByClassName('list-group-item active')[0].id;
actives.prependTo('.list-left2 ul');
$.ajax({
url: '/trackingservlet',
type: 'POST',
data: "status=" + "verification" +"&id=" + id ,
});
} 
if ($button.hasClass('move-right3')) {
actives = $('.list-left2 ul li.active');
data = document.getElementsByTagName("body")[0].id;
id = document.getElementsByClassName('list-group-item active')[0].id;
actives.prependTo('.list-right2 ul');
$.ajax({
url: '/trackingservlet',
type: 'POST',
data: "status=" + "verified" +"&id=" + id ,

});


}
});




var modal = document.getElementById('myModal');

$('body').on('click', '.icon ', function() {
$(this).toggleClass('active');
id = document.getElementsByClassName('list-group-item active')[0].id;
var $content = document.getElementsByClassName('list-group-item.active')[0];
console.log(id);
console.log($content);

modal.style.display = "block";
Update.onclick = function()
{
var x=document.getElementById("comment").value;
console.log(x);
var update = $('.list-group-item active').find(".description");
update.text(x);
$.ajax({
url: '/trackingservlet',
type: 'GET',
data: "data="+ x +"&id=" + id ,

});
modal.style.display = "none"; 
location.reload();
}
Close.onclick = function() 
{
modal.style.display = "none";
}


});


});

</script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script type="text/javascript">



</script>
</head>

<body>

<div class="header js-list ">
<img src="images/asd.png" class="navbar-header">
<h3 id="project title" class="text-center">SCRUMPAGE</h3>
</div>

<a class="boot2" href="/projects">back to project page</a>
<div class="container container-fluid">


<div class="row">

<!-- table 1 -->

<div class="dual-list list-left1 col-md-2">
<div class="well text-center">
<h4 class="lead">To Do </h4>
<ul class="list-group" id="table" onclick='document.getElementById("mo-title").innerHTML="To-do"' >


</ul>

</div>
</div>

<!-- Arrows 1-->
<div class="list-arrows col-md-1 text-center">
<button class="btn btn-default btn-sm move-left1">
<span class="glyphicon glyphicon-chevron-left"></span>

</button>

<button class="btn btn-default btn-sm move-right1">
<span class="glyphicon glyphicon-chevron-right"></span>
</button>
</div>
<!-- table 2-->
<div class="dual-list list-right1 col-md-2">
<div class="well text-center">
<h4 class="lead">Work in Prog.. </h4>
<ul class="list-group" id="table1" onclick='document.getElementById("mo-title").innerHTML="To-do"' >

</ul>


</div>
</div>
<!-- Arrows 2-->
<div class="list-arrows col-md-1 text-center">
<button class="btn btn-default btn-sm move-left2">
<span class="glyphicon glyphicon-chevron-left"></span>
</button>

<button class="btn btn-default btn-sm move-right2">
<span class="glyphicon glyphicon-chevron-right"></span>
</button>
</div>
<!-- table 3-->
<div class="dual-list list-left2 col-md-2">
<div class="well text-center">
<h4 class="lead"> For Verification</h4>

<ul class="list-group" id="table2" onclick='document.getElementById("mo-title").innerHTML="To-do"' >

</ul>
</div>
</div>
<!-- Arrows 3-->
<div class="list-arrows col-md-1 text-center">
<button class="btn btn-default btn-sm move-left3">
<span class="glyphicon glyphicon-chevron-left"></span>
</button>

<button class="btn btn-default btn-sm move-right3">
<span class="glyphicon glyphicon-chevron-right"></span>
</button>
</div>
<!-- table 4-->
<div class="dual-list list-right2 col-md-2">
<div class="well text-center">
<h4 class="lead">Verified </h4>

<ul class="list-group" id="table3" onclick='document.getElementById("mo-title").innerHTML="To-do"' >

</ul>
</div>
</div>

</div>




<br>
<br>
<center>

<button class="btn btn-default" onclick="openGoalsPage();">
New Task
<span class="glyphicon glyphicon-plus"></span>
</button>
</center>

<!-- The Modal -->
<div id="myModal" class="modal">

<!-- Modal content -->
<div class="modal-content">
<div class="modal-header">
<center> <h4 class="modal-title" id="mo-title">Edit To-Do </h4> </center>

</div>
<div class="modal-body">
<form>
<div class="form-group">
<label>Description:</label>
<textarea class="form-control" rows="2" id="comment"></textarea>

</div>
</form>
</div>
<div class="modal-footer">
<button type="button" class="btn btn-default" id="Update">Update</button>
<button type="button" class="btn btn-default" id="Close" >Close</button>

</div>
</div>

</div>




</body>
</html>