package com.springproject;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.datastore.Query.FilterPredicate;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.labs.repackaged.org.json.JSONArray;
import com.google.appengine.labs.repackaged.org.json.JSONObject;

@Controller

public class SpringScrumBoard {

	@RequestMapping("/")
	public String home() {
		return "index";
	}
  @RequestMapping("/proj")
  public String project(){
	return "projects";
    }
  @RequestMapping("/newproject")
  public String newproject() {
	return "newproject";
    }

	@RequestMapping(value = "/storeproject", method = RequestMethod.POST)
	public void store(HttpServletRequest req, HttpServletResponse resp) throws IOException {

		String name = req.getParameter("suggest");
		String desc = req.getParameter("sugg");

		System.out.println(req.getParameter("suggest"));
		System.out.println(req.getParameter("sugg"));

		DatastoreService ds = DatastoreServiceFactory.getDatastoreService();

		Entity e = new Entity("new project");
		e.setProperty("name", name);
		e.setProperty("desc", desc);
		//model.addAttribute("id", id);
		//System.out.println(id);
		
		try {
			ds.put(e);
		} catch (Exception error) {
			error.printStackTrace();
		}
		resp.setContentType("text/plain");
		resp.getWriter().println(
				"Saved! Task = " + req.getParameter("suggest") + " & Description = " + req.getParameter("sugg"));
	}
	
	@RequestMapping(value = "/retrieveproject", method = RequestMethod.GET)
	public void retrieve(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		DatastoreService das = DatastoreServiceFactory.getDatastoreService();
		JSONArray jarr =  new JSONArray();
		try {
			Query q = new Query("new project");
			PreparedQuery pq = das.prepare(q);
			for (Entity u1 : pq.asIterable()) {
				JSONObject json = new JSONObject();
				json.put("name", u1.getProperty("name"));
				json.put("desc", u1.getProperty("desc"));
				json.put("id",u1.getKey().getId());
				jarr.put(json);
			}
			System.out.println(jarr.toString());
		} catch (Exception err) {
			err.printStackTrace();
		}
		resp.setContentType("application/json");
		resp.getWriter().println(jarr);
       
	}
	@RequestMapping("/updateprojname")
	public String updatename(){
		return "projects"; 
}
	
	@RequestMapping(value = "/namepost", method = RequestMethod.POST)
	public void projupdate(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String id = req.getParameter("id");

		String name = req.getParameter("suggest");
		

		System.out.println(req.getParameter("suggest"));
	


		DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
		
		try{
			Key key = KeyFactory.createKey("new project" , Long.parseLong(id));
			Entity recievedEntity = ds.get(key);
			recievedEntity.setProperty("name", name);
			
			ds.put(recievedEntity);
		}
		catch(Exception e){
			e.printStackTrace();
		}
	
		
		resp.setContentType("text/plain");
		resp.getWriter().println( " name = " + req.getParameter("suggest") );
	
	}
	
	/*@RequestMapping("/projectpage")
	public void redirectToProjView(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException{
		RequestDispatcher rd = req.getRequestDispatcher("projects.jsp");
		rd.forward(req, resp);
	}*/
	@RequestMapping("/getprojname")
	public String getname(){
		return "projects";
	  }
	@RequestMapping(value = "/nameget", method = RequestMethod.GET)
	public void getupdatedname(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		DatastoreService das = DatastoreServiceFactory.getDatastoreService();
		JSONArray jarr =  new JSONArray();
		try {
			Query q = new Query("new project");
			PreparedQuery pq = das.prepare(q);
			for (Entity u1 : pq.asIterable()) {
				String uname = (String) u1.getProperty("name");
		
			}
			System.out.println(jarr.toString());
		} catch (Exception err) {
			err.printStackTrace();
		}
		resp.setContentType("text/plain");
		resp.getWriter().println(jarr);
	}
	
	
	@RequestMapping("/updatedesc")
	public String updatedesc(){
		return "projects";
	  }

	@RequestMapping(value = "/descpost", method = RequestMethod.POST)
	public void updatedesc(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String id = req.getParameter("id");

		
		String desc = req.getParameter("sugg");
		
	
		System.out.println(req.getParameter("sugg"));

		DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
		
		try{
			Key key = KeyFactory.createKey("new project" , Long.parseLong(id));
			Entity recievedEntity = ds.get(key);
	
			recievedEntity.setProperty("desc", desc);
			ds.put(recievedEntity);
		}
		catch(Exception e){
			e.printStackTrace();
		}
	
		
		resp.setContentType("text/plain");
		resp.getWriter().println(  "  Description = " + req.getParameter("sugg"));
	
	}

	@RequestMapping("/retrievedesc")
	public String retrievedesc(){
		return "projects";
	  }
	@RequestMapping(value = "/descget", method = RequestMethod.GET)
	
	public void retrievedesc(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		DatastoreService das = DatastoreServiceFactory.getDatastoreService();
		JSONArray jarr =  new JSONArray();
		try {
			Query q = new Query("new project");
			PreparedQuery pq = das.prepare(q);
			for (Entity u1 : pq.asIterable()) {
				
				String udesc = (String) u1.getProperty("desc");
			}
			System.out.println(jarr.toString());
		} 
		catch (Exception err) {
			err.printStackTrace();
		}
		resp.setContentType("text/plain");
		resp.getWriter().println(jarr);
	}
	@RequestMapping("/deleteproj")
	public String deleteproject(){
		return "projects";
	  }
	@RequestMapping(value = "/delproj", method = RequestMethod.POST)
	public void delete(HttpServletRequest req, HttpServletResponse response)
		    throws IOException {
		String id = req.getParameter("id");
		String data = req.getParameter("data");
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Key key = KeyFactory.createKey("new project", Long.parseLong(id));
		try{
			datastore.delete(key);
		}
		catch(Exception e){
			e.printStackTrace();
		}
	
		response.setContentType("text/plain");
		response.getWriter().println("deleted..!");
	}
	
	
	
@RequestMapping("/scrumpage")
public String scrumpage(){
	return "scrumpage"; 

}
@RequestMapping("/goals")
public String goals(){
	return "goals";
  }
@RequestMapping(value="/value", method = RequestMethod.POST)
public void storegoal(HttpServletRequest req, HttpServletResponse resp) throws IOException {
	String goals = req.getParameter("decide");
	String details = req.getParameter("decide1");
	String goalsid = req.getParameter("id");
	String work_in_progress = req.getParameter("Work in Prog..");
	String for_verification = req.getParameter("For Verification");
	String verified = req.getParameter("Verified");
	
	System.out.println(req.getParameter("decide"));
	System.out.println(req.getParameter("decide1"));

	DatastoreService ds = DatastoreServiceFactory.getDatastoreService();

	Entity e = new Entity("Goals");
	e.setProperty("goals", goals);
	e.setProperty("details", details);
	e.setProperty("projectid",goalsid );
       e.setProperty("status", "todo" );
       
	
	
	try {
		ds.put(e);
	} catch (Exception error) {
		error.printStackTrace();
	}
	resp.setContentType("text/plain");
	resp.getWriter().println(
			"Saved! Task = " + req.getParameter("decide") + " & Description = " + req.getParameter("decide1"));
}
	
@RequestMapping(value="/scrum", method = RequestMethod.GET)
public void retrievegoal(HttpServletRequest req, HttpServletResponse resp) throws IOException {
	String id = req.getParameter("id");
	DatastoreService das = DatastoreServiceFactory.getDatastoreService();
	JSONArray jarr =  new JSONArray();
	try {
		Query q = new Query("Goals");
		Filter filter = new FilterPredicate("projectid",FilterOperator.EQUAL,id);
		q.setFilter(filter);
		PreparedQuery pq = das.prepare(q);
		for (Entity u1 : pq.asIterable()) {
			JSONObject json = new JSONObject();
			json.put("goals", u1.getProperty("goals"));
			json.put("details", u1.getProperty("details"));
			json.put("goalsid", u1.getProperty("goalsid"));
			json.put("status", u1.getProperty("status"));
			json.put("id", u1.getKey().getId());
			jarr.put(json);
		}
		System.out.println(jarr.toString());
	} catch (Exception err) {
		err.printStackTrace();
	}
	resp.setContentType("application/json");
	resp.getWriter().println(jarr);
}




@RequestMapping("/list")
public String taskupdate(){
	return "scrumpage";
  }
@RequestMapping(value="/scrumpost", method = RequestMethod.POST)
public void scrumpost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
	
	String id = req.getParameter("id");
	String goals = req.getParameter("decide");
	//String details = req.getParameter("decide1");

	
	System.out.println(req.getParameter("decide"));
	
	DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
	
	try{
		Key key = KeyFactory.createKey("Goals" , Long.parseLong(id));
		Entity recievedEntity = ds.get(key);
		recievedEntity.setProperty("goals", goals);
		
		ds.put(recievedEntity);
	}
	catch(Exception e){
		e.printStackTrace();
	}

	
	resp.setContentType("text/plain");
	resp.getWriter().println(req.getParameter("decide"));

}
/*@RequestMapping("/scrumbroad")
public void redirectToView(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException{
	RequestDispatcher rd = req.getRequestDispatcher("scrumpage.jsp");
	rd.forward(req, resp);
}*/
@RequestMapping("/list1")
public String taskdisplay(){
	return "scrumpage";
  }
@RequestMapping(value="/scrumget", method = RequestMethod.GET)
public void scrumretrieve(HttpServletRequest req, HttpServletResponse resp) throws IOException {
DatastoreService das = DatastoreServiceFactory.getDatastoreService();
JSONArray jarr =  new JSONArray();
try {
	Query q = new Query("Goals");
	PreparedQuery pq = das.prepare(q);
	for (Entity u1 : pq.asIterable())
	{
		String ugoals = (String) u1.getProperty("goals");
	}
	System.out.println(jarr.toString());
} catch (Exception err) {
	err.printStackTrace();
}
resp.setContentType("text/plain");
resp.getWriter().println(req.getParameter("ugoals"));
}

@RequestMapping(value="/trackingservlet", method = RequestMethod.POST)
public void tracking(HttpServletRequest req, HttpServletResponse resp) throws IOException {
String id = req.getParameter("id");


String status = req.getParameter("status");

DatastoreService ds = DatastoreServiceFactory.getDatastoreService();

try{
Key key = KeyFactory.createKey("Goals" , Long.parseLong(id));
Entity recievedEntity = ds.get(key);
recievedEntity.setProperty("status",status);

ds.put(recievedEntity);
}
catch(Exception e){
e.printStackTrace();
}


resp.setContentType("text/plain");
resp.getWriter().println( " status = " + req.getParameter("status") );

}

}


