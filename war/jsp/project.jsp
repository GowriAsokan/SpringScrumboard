<html>
<head>
<title> scrum board </title>
<link rel = "stylesheet" type="text/css" href="css/bas2.css" title ="style1"/>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script type="text/javascript">
var id = '<%= request.getParameter("id")%>';
   $(document).ready(function(){
	   var count = 1;
	   function myfunc(name, desc,id){
	   var innerTable = "<div id='"+id+"' class='plan'><h3><span id='task"+count+"'>"+name+"</span></h3></br></br></br></br></br><p></p><span id='desc"+count+"'>"+desc+"</span><span class='scrumboard'  onclick='callServer(this);'>view scrumboard</span></div>";
	   if(document.getElementById('table').innerHTML == ''){
	   document.getElementById('table').innerHTML = innerTable;
	   }
	   else {
	   var newTable = document.getElementById('table').innerHTML;
	   newTable = document.getElementById('table').innerHTML;
	   document.getElementById('table').innerHTML = newTable + innerTable;
	   }
	   count++;
	   }
	   var loaded = getData();
	   
	 
	function getData(){
		   $.get("/projects?id="+id,
				   function result(result){
	
					
					for(var i = 0; i < result.length; i++){
						console.log(result[i].name);
						console.log(result[i].desc);
						console.log(result[i].id);
						myfunc(result[i].name, result[i].desc,result[i].id);
					}
				});
	//   setTimeout(getData,2000);
		   return true;
	   }
   });
   function callServer(elem)
   {
	  var prj=elem.parentNode.id;
	  window.location.href="/scrumpage?id="+prj;
	   	   }
    </script>
</head>
<body>
<h3><center><strong>PROJECT PAGE</center></h3></strong></h3>

<div id="table" class="clear">
    

</div>

</br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br>

<center><a href="/newproject"><IMG SRC="https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcRzDfGjRYPo_M4SZh-fSFWCZy14a6ZaGPrf_00pcAon_pNmJaT4qQ" alt="Logo" height="90" width="100"></A></center>



</body>
</html>