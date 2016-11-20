/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import it.unisa.gitdm.bean.Evaluation;
import it.unisa.gitdm.bean.Model;
import it.unisa.gitdm.bean.Project;
import it.unisa.primeLab.Config;
import it.unisa.primeLab.ProjectHandler;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author fabiano
 */
@WebServlet(urlPatterns = {"/CompareServlet"})
public class CompareServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CompareServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CompareServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        String[] modelToCompare = request.getParameterValues("table_records");
        Project currentProject = ProjectHandler.getCurrentProject();
        String projName = currentProject.getName();
        String projFolderPath = Config.baseDir + "" + projName;
        ArrayList<Model> models = currentProject.getModels();
        System.out.println(models);
        ArrayList<Model> toReturn = new ArrayList<Model>();

        for (String modelName : modelToCompare) {
            for (Model m : models) {
                if (m.getName().equals(modelName)) {
                    toReturn.add(m);
                }
            }
        }
        ArrayList<Evaluation> evaluations = new ArrayList<Evaluation>();
        for (Model model : toReturn) {
            System.out.println(model);
            evaluations.add(DataExtractor.getEvaluation(projFolderPath, projName, model));
        }
        session.setAttribute("evaluations", evaluations);
        ServletContext sc = getServletContext();
        RequestDispatcher rd = sc.getRequestDispatcher("/compare.jsp");
        rd.forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
