 <%@ page import="java.sql.*" %>
   <%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>
<%@ page import="java.io.*" %>
<HTML>
<HEAD>
  <TITLE>insert data using prepared statement </TITLE>
</HEAD>
    <BODY bgcolor="#ffffcc">
<font size="+3" color="black"><br>Welcome in MSB Messages</font><br>
<%
GregorianCalendar cal = new GregorianCalendar();
out.print(cal.get(Calendar.DATE)+"-");
out.print(cal.get(Calendar.MONTH)+"-");
out.print(cal.get(Calendar.YEAR));

      %>
  <form action = "Creation.jsp" method = "GET">
         <br> Name: <input type = "text" name = "name"> <br> <br>

         Content: <input type = "text" name = "content" /> <br> <br>


         <input type = "submit" value = "Add" /> <br>


<%
   String name = request.getParameter("name");
   String content = request.getParameter("content");


    String connectionURL = "jdbc:mysql://localhost:3310/playerinfo";

    Connection connection = null;

     PreparedStatement pstatement = null;

            ResultSet rs=null;

     Class.forName("com.mysql.jdbc.Driver").newInstance();
          int updateQuery = 0;


	 if(name!=null && content!=null){

	     if(name!="" && content!="") {
	                 try {
              connection = DriverManager.getConnection
              (connectionURL, "root", "mysql");

              String queryString = "INSERT INTO messages(name,content,time) VALUES (?, ?,CURRENT_TIMESTAMP)";
              pstatement = connection.prepareStatement(queryString);
              pstatement.setString(1, name);
			  pstatement.setString(2, content);

              updateQuery = pstatement.executeUpdate();
                            if (updateQuery != 0) { %>
	           <br>
	           <TABLE style="background-color: #E3E4FA;"
                   WIDTH="30%" border="1">
		      <tr><th>Data is inserted successfully
                    in database.</th></tr>
		   </table>
              <%
              }
            }
            catch (Exception ex) {
            out.println("");

               }
            finally {

                try{
                pstatement.close();
                connection.close();
                }catch(Exception e)
                {System.out.println(e);}


            }
	  }
	}
%>

<TABLE style="background-color: #ECE5B6;" WIDTH="30%" >
<%

Statement statement=null;
try{
  Class.forName("com.mysql.jdbc.Driver").newInstance();
  connection = DriverManager.getConnection(connectionURL, "root", "mysql");
  statement = connection.createStatement();
  rs = statement.executeQuery("select * from messages");
  int i=0;
  while(rs.next())
  {
    i=0;
  %>
  <tr style="height:100px">
  <td>
  <%= rs.getInt(4) %><br>
    <%= rs.getString(1)%><br>
    <%= rs.getString(2)%><br>
    <%= rs.getTimestamp(3) %><br>
    </td>
  <%
  while(i<3 &&  rs.next())
  {
  i++;%>
    <td>
    <%= rs.getInt(4) %><br>
    <%= rs.getString(1)%><br>
    <%= rs.getString(2)%><br>
    <%= rs.getTimestamp(3) %><br>
    </td>
    <%
  }
    %>
    </tr>
    <%
    }
}
  catch (Exception ex) {
    out.println("");
} finally {
    // close all the connections.
    rs.close();
    statement.close();
    connection.close();
}
%>
  </TABLE>
  </FORM>

<form method="post" action="Deletion.jsp">
Delete by ID:<br>
<input type="text" name="id">
<br>
<input type="submit" value="submit">
</form>
 </body>
</html>