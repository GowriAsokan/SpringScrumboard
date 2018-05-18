
<html>
<head>
<title> scrum board </title>
<link rel = "stylesheet" type="text/css" href="css/b.css" title ="style1"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

   <script type="text/javascript">
   $(document).ready(function(){
	   $("#submit").click(function(){

	   var txt = $("#addgoal").val();
	   var txt1 = $("#adddesc").val();
	   $.post("/value?id="+'<%=request.getParameter("id")%>',
	   		data={
	   	decide: txt, 
	   	decide1: txt1
	   	}, 
	   	
	   function result(result){
	   $("span").html(result);
	   window.location.href = "/scrumpage?id="+'<%=request.getParameter("id")%>';
	 
	   });
	   	
	   });
	   });
    </script>

</head>
 <body background="https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQDu6Si2_1-e2YLWOrHjvHL-2BbliQnzcrm0WHdG8F8iiDy2Qsl" height="150%" width="100%" align="center">

<center><h1>TO DO LIST</h1></center>
</br>

<center>
	<h2>GOALS:</h2> &nbsp;<input type="text" id="addgoal" class="g" name="addgoal" style="font-size: 18pt; height: 80px; width:280px; "></br>
</br>
</br>
<h2>DETAILS:</h2> &nbsp;<input type="text" id="adddesc" class="d" name="adddesc" style="font-size: 18pt; height: 80px; width:280px; "></br>
</br>
</br>
<span></span>
  <center> 
<input type="submit" id="submit" value="submit" onclick="myFunction()" ></input></center>
</center>

</body>
</html>