<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="bean.Collection" %>
<%@ page import="dao.CollectionDao" %>
<%@ page import="java.sql.SQLException" %>

<%
    String collectionName = request.getParameter("collectionName");

    Collection collection = new Collection();
    collection.setCollectionName(collectionName);

    // Create DAO instance
    CollectionDao collectionDAO = new CollectionDao();

    try {
        // Check if the collection already exists
        if (collectionDAO.isCollectionExists(collectionName)) {
            out.print("<script type='text/javascript'>");
            out.print("alert('Collection already exists.');");
            out.print("window.location.href = 'addcollections.jsp';");
            out.print("</script>");
        } else {
            // Insert collection into the database
            boolean isInserted = collectionDAO.insertCollection(collection);
            if (isInserted) {
                out.print("<script type='text/javascript'>");
                out.print("alert('Successfully added');");
                out.print("window.location.href = 'viewcollections.jsp';");
                out.print("</script>");
            } else {
                out.print("<script type='text/javascript'>");
                out.print("alert('Failed to add collection.');");
                out.print("window.location.href = 'addcollections.jsp';");
                out.print("</script>");
            }
        }
    } catch (SQLException e) {
        out.print("<script type='text/javascript'>");
        out.print("alert('An error occurred. Please try again later.');");
        out.print("window.location.href = 'addcollections.jsp';");
        out.print("</script>");
        e.printStackTrace();
    }
%>
