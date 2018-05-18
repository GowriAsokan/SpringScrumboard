<!DOCTYPE html>
<head><meta content="text/html; charset=utf-8"> 
<title>
New Project
</title>
<style>
body
{

 background-image: url("images/step0002.jpg");
  background-repeat: no-repeat;
  background-size: cover;

}
h3
{
  color: #3399FF;
}
textarea
{
  color: #003399;
}
h1
{

color: orange;
margin-top: 12px;
font-size: 50px;
font-style: oblique;
font-family: "Georgia", serif;
padding-top: 40px;

}
button
{
  margin-top: 20px;
  padding: 10px;
background-color:#217C7E;
color: white;
font-family:Courier;
}
button:hover
{
  background-color: #9A3334;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

   <script type="text/javascript">
   $(document).ready(function(){
	   $("#submit").click(function(){

	   var txt = $("#goal").val();
	   var txt1 = $("#desc").val();
	   $.post("/storeproject",
	   		data={
	   	suggest: txt, 
	   	sugg: txt1
	   	}, 
	   	
	   function result(result){
	   $("#demo").html(result);
	   window.location.href = "/proj";
	 
	   });
	   	
	   });
	   });
    </script>

  </head>

<body>
<center>
<h1>
New Project
</h1>
<h3> Title</h3>
&nbsp;<input id="goal" type="text" name="goals" style="font-size: 18pt; height: 80px; width:280px; "/>
</br>
<h3> Description </h3>
&nbsp;<input id="desc" type="text" name="desc" style="font-size: 18pt; height: 80px; width:280px; "/></br>
<br>
<br>
<span id="demo"></span>
</center>
<center> 

<input type="button" id="submit" value="submit"></input></center>
</body>
</html>

