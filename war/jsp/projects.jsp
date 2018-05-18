<html>
<head>
<title> scrum board </title>
       <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
       <link rel="stylesheet" href="css/bas2.css"><script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
 <script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script type="text/javascript">
var id = '<%= request.getParameter("id")%>';
var btn = new Array();
var button = new Array();

 $(document).ready(function(){

	   var loaded = getData();
	   
	function getData(){
		   $.get("/retrieveproject?id="+id,
				   function result(result){
			   console.log(result.toString());
	
					for(var i = 0; i < result.length; i++){
						btn.push('myBtn'+i);
						button.push('myButn'+i);
						
						console.log(result[i].name);
						console.log(result[i].desc);
						console.log(result[i].id);
						//var data =	$("#task"+id).html(result[i].goals);
						$('#table').append("<div id='"+result[i].id+"' class='plan'><input class='checked' id='Butn' type='checkbox' name='key1' data-taskId='"+result[i].id+"' ></br></br><h3><span data-taskId='"+result[i].id+"' id='task"+i+"' class='name'>"+result[i].name+"</span></h3></br></br><button id='myBtn"+i+"' class='icon' title='Edit'>edit</button></br></br></br><span id='desc"+i+"' data-taskId='"+result[i].id+"' class='name'>"+result[i].desc+"</br><button id='myButn"+i+"' class='icon' title='Edit'>edit</button></span><span class='scrumboard' onclick='newscrum(this);'> view scrumboard </span></div>");
					}
					attachClickEventToImage();
					editClickEventToImage();
						    });
					
					
				
		   //setTimeout(getData,1000);
		   return true;
	}
	
 }); 
                  
function newscrum(elem)
{
var id  = elem.parentNode.id;
console.log(id);
window.location.href = "/scrumpage?id="+ id;
}
 function attachClickEventToImage(){
	   console.log(btn);
	   for (var i = 0; i < btn.length; i++) {
		   console.log("Button name : "+i);
	         listenerForI( i );
	     }

	      
              
	   
function  listenerForI( i ) {
    

	 console.log("This event was called by attachClickEventToImage!");
     document.getElementById(btn[i]).addEventListener('click', function()
     {
    	 console.log("Called with Id : "+btn[i]);

    	 document.getElementById('myModal').style.display = "block";

    Update.onclick = function()
    {
    	 var decide1=document.getElementById("comment").value;
    
         
    	 console.log( $('#'+btn[i]).parent().children().children().data('taskid'));
console.log(decide1);
  		  
     		   $.post("/namepost",
     		   		data={
     		   	suggest: decide1,  id:$('#'+btn[i]).parent().children().children().data('taskid')
     		   	},
     		   function result(result){
     			  window.location.href ="/updateprojname";
     
     		   	});
     		   
  
     		  $.get("/nameget?id="+id,
     		   function result(result){
     			  $('#'+btn[i]).val(result);
     			
     			 window.location.href="/getprojname";
     		  
     			 document.getElementById('myModal').style.display = "none";  
     		  });

    }
  

    
    Close.onclick = function()
      {
    	document.getElementById('myModal').style.display = "none";
      }
    });
     
   
}
 }

 function editClickEventToImage(){
	   console.log(button);
	 
	   for (var i = 0; i < button.length; i++) {
		   console.log("Button desc : "+i);
	         updateForI( i );
	     }
	      
            
	   
function  updateForI( i ) {


	 console.log("This event was called by editClickEventToImage!");
   document.getElementById(button[i]).addEventListener('click', function()
   {
  	 console.log("Called with Id : "+button[i]);

  	 document.getElementById('Modal').style.display = "block";

  	 Edit.onclick = function()
  	 {
  	 	 
  	      var decide2=document.getElementById("comment1").value;
  	      
  	 	 
  	console.log( $('#'+button[i]).parent().data('taskid'));
  	console.log(decide2);   		  
  	  		   $.post("/descpost",
  	  		   		data={
  	  		
  	  		   	sugg:decide2, id:$('#'+button[i]).parent().data('taskid')},
  	  		   
  	  		   
  	  		function result(result){
       			  window.location.href ="/updatedesc";
  	  		   	
  	  		   
  	  		   });
  	  		   

  	  		  $.get("/descget?id="+id,
  	  		   function result(result){
  	  			  $('#'+button[i]).val(result);
  	  			
  	  		   	
  	  		   document.getElementById('Modal').style.display = "none";  
  	  
  	  		window.location.href="/retrievedesc";
  	  
  	 });

  	 }

  
  Close.onclick = function()
    {
  	document.getElementById('Modal').style.display = "none";
    }
  	 
   });
 }
}


 

var checkbox = new Array();

 function deletedata() {
 

	 var answer = confirm("Are you sure you wish to delete the project?")
	 if (answer){
	     var length = $('input[type=checkbox]:checked').length;
  		for(var i = 0; i < length; i++){
  			checkbox.push(('input[type=checkbox]:checked')[i]);
  			console.log($('input[type=checkbox]:checked')[i].value);

  					// $("'input[type=checkbox]:checked')[i]").parent().remove();
  				console.log($('input[type=checkbox]:checked').data('taskid'));

  				$.post("/delproj", 
  						{
  			  	  		
  		  	  		   	data:checkbox, id:$('input[type=checkbox]:checked').data('taskid')
  		  	  		   	});
  		  	  		   	
  				
  				function result(result)	
  				{
  			$('input[type=checkbox]:checked').data('taskid').parent().remove(result);
  			
  		   	window.location.href="/deleteproj";
  			
 }
	 }
  		
  			}
} 

 		     		 

</script>

</head>
<body >
<h3><center><strong>PROJECT PAGE</center></strong></h3>
<p id="task"></p>
<div id="table" class="clear" >
   <button id='delete_button'  class='delete' onclick='deletedata();'> delete </button> 

</div>
</br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br>
<center><a href="/newproject"><IMG SRC="https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcRzDfGjRYPo_M4SZh-fSFWCZy14a6ZaGPrf_00pcAon_pNmJaT4qQ" alt="Logo" height="90" width="100"></A></center>


<div id="myModal" class="modal">

  <!-- Modal content -->
  <div class="modal-content">
    <div class="modal-header">
      <center>
      <h4 class="modal-title" id="mo-title">
       Update project</h4> 
      
      </center>

    </div>
    <div class="modal-body">
      <form>
        <div class="form-group">
        
         <label>Project Title:</label>
            <textarea  class="form-control" rows="2" cols="6" id="comment"></textarea>
           
   
      </div>
      </form>
    </div>
    <div class="modal-footer">
      <button type="button" class="btn btn-default" id="Update">Update</button>
      <button type="button" class="btn btn-default" id="Close" >Close</button>

    </div>
  </div>

</div>
<div id="Modal" class="modal">

  <!-- Modal content -->
  <div class="modal-content">
    <div class="modal-header">
      <center>
      <h4 class="modal-title" id="mo-title">
       Update project</h4> 
      
      </center>

    </div>
    <div class="modal-body">
      <form>
        <div class="form-group">
        
         <label>Description:</label>
            <textarea  class="form-control" rows="2" cols="6" id="comment1"></textarea>
           
   
      </div>
      </form>
    </div>
    <div class="modal-footer">
      <button type="button" class="btn btn-default" id="Edit">Update</button>
      <button type="button" class="btn btn-default" id="Close" >Close</button>

    </div>
  </div>

</div>




</body>
</html>