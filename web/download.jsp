<%-- 
    Document   : download
    Created on : 16-ott-2020, 9.32.55
    Author     : giuse
--%>

<%@page import="it.unisa.primeLab.ProjectHandler"%>
<%@page import="it.unisa.gitdm.bean.Project"%>
<%@page import="it.unisa.gitdm.bean.Model"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% Model model = (Model) session.getAttribute("modello");%>
<% Project project = ProjectHandler.getCurrentProject();%>
<%String filename = "predictors.csv";   
String filepath = "C:/ProgettoTirocinio/projects/" + project.getName() + "/models/" + model.getName() + "/";   
response.setContentType("APPLICATION/OCTET-STREAM");   
response.setHeader("Content-Disposition","attachment; filename=\"" + filename + "\"");  
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
