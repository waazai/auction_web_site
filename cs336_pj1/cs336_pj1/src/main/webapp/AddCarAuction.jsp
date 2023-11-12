<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.io.PrintStream"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Add Car Auction</title>
	</head>
	<body>
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			
			//Get the info
			Statement stmt = con.createStatement();
			String userN=(String)session.getAttribute("username");  //get current username
			String vid = request.getParameter("vid");  //require
			String itemName = request.getParameter("itemName");   //optional
			String minPrice = request.getParameter("minPrice");  //optional
			String country = request.getParameter("country");   //optional
					
			String endTime = request.getParameter("endTime");  //require
		
			
			if (vid.isEmpty() || endTime.isEmpty()) {
				out.print("One or more required fields are empty.\n");
				%>
					<a href="Car.jsp"><input onclick="this.parentNode.href=Car.jsp;" type="button" value="Go Back" name="Fail"/></a>
				<%
			}else{
				//Make INSERT vehicles query
				PreparedStatement statement = con.prepareStatement("INSERT IGNORE INTO vehicles (vid, itemName, minPrice, country) VALUES (?, ?, ?, ?)");
				statement.setString(1, vid);
				//Optional values
				if (itemName.isEmpty()) {itemName = "null";}
				statement.setString(2, itemName);
				if (minPrice.isEmpty()) {itemName = "null";}
				statement.setString(3, minPrice);
				if (country.isEmpty()) {itemName = "null";}
				statement.setString(4, country);
				
				//Run the query against the database.
				int result = statement.executeUpdate();
				
				
				//Make INSER auction query
				PreparedStatement statement2 = con.prepareStatement("INSERT IGNORE INTO auction (available, username, vid, endtime) values (true, ?, ?, date(?))");
				statement2.setString(1, userN);
				statement2.setString(2, vid);
				//Make string
				statement2.setString(3, endTime);
				
				//Run the query against the database.

				int result2 = statement2.executeUpdate();
			
				%>
				<body>
					<p>Car Auction success!.</p>
					<a href="HomePage.jsp"><input onclick="this.parentNode.href=HomePage.jsp;" type="button" value="Go Back Home" name="gobackhome"/></a>
				</body>
				<%
				}
				
			} catch (Exception e) {
			out.print(e);
		}%>
	

	</body>
</html>