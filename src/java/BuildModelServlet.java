/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import it.unisa.primeLab.Config;
import it.unisa.gitdm.bean.Evaluation;
import it.unisa.gitdm.bean.Metric;
import it.unisa.gitdm.bean.Model;
import it.unisa.gitdm.bean.MyClassifier;
import it.unisa.gitdm.bean.Project;
import it.unisa.gitdm.evaluation.WekaEvaluator;
import it.unisa.gitdm.init.servlet.CalculatePredictors;
import it.unisa.primeLab.ProjectHandler;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
//import weka.classifiers.AbstractClassifier;
import weka.classifiers.Classifier;
import weka.classifiers.bayes.NaiveBayes;
import weka.classifiers.trees.J48;

/**
 *
 * @author fabiano
 */
@WebServlet(name = "BuildModelServlet", urlPatterns = {"/BuildModelServlet"})
public class BuildModelServlet extends HttpServlet {

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
            out.println("<title>Servlet BuildModelServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BuildModelServlet at " + request.getContextPath() + "</h1>");
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
        
        // GET REQUEST PARAMETER
        String github = request.getParameter("github");
        Project curr = new Project(github);
        ProjectHandler.setCurrentProject(curr);
        String issueTracker = request.getParameterValues("issueTracker")[0];
        String[] checkedMetrics = request.getParameterValues("metrics");
        ArrayList<Metric> metrics = new ArrayList<Metric>();
        System.out.println(issueTracker);
        System.out.println(checkedMetrics[0]);
        for (String s : checkedMetrics) {
            System.out.println(s);
            metrics.add(new Metric(s));
        }
        
        System.out.println(metrics);
        MyClassifier classifier = ClassifierBuilder.buildClassifier(request.getParameterValues("classifier")[0]);
        System.out.println(classifier);
        String dirName = github.split(".com/")[1].split(".git")[0];
        String[] splitted = dirName.split("/");
        String projName = splitted[splitted.length - 1];
        curr.setName(projName);
        String projFolderPath = "" + Config.baseDir + projName;
        String clonePath = "" + Config.baseDir + projName + "/" + projName;

        System.out.println("*******"+ProjectHandler.getCurrentProject().getModels().toString());
        System.out.println("*****"+curr.getName());
        Model model = ModelBuilder.buildModel(curr.getName(), curr.getGitURL(), metrics, classifier);
        if (model == null) { // calculate evaluation
            Project p = ProjectHandler.getCurrentProject();
            
            DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm");
            Date date = new Date();
            String now = dateFormat.format(date);
            
            Model inputModel = new Model(p.getName() + "Model" + (p.getModels().size() + 1), p.getName(), p.getGitURL(), metrics, classifier,now);
            String scatteringFolderPath = "C:/ProgettoTirocinio/gitdm/scattering/";
            String baseFolderPath = "C:/ProgettoTirocinio/gitdm/";
            CalculatePredictors.CalculateSpecificPredictors(projName, issueTracker, issueTracker, projName, "All", baseFolderPath, scatteringFolderPath, inputModel);
            
            String baseFolder = "C:/ProgettoTirocinio/gitdm/";
            WekaEvaluator we = new WekaEvaluator(baseFolder, projName, classifier.getClassifier(), classifier.getName(), inputModel.getName());
            
            ArrayList<Model> models = p.getModels();
            models.add(inputModel);
            p.setModels(models);
            //non salva il progetto
            ProjectHandler.addProject(p);
            p = ProjectHandler.getAllProjects().get(ProjectHandler.getAllProjects().indexOf(p));
            System.out.println(p.getModels());
            
            Evaluation eval = DataExtractor.getEvaluation(projFolderPath, projName, inputModel);
            session.setAttribute("accuracy", eval.getEvaluationSummary().getAccuracy());
            session.setAttribute("precision", eval.getEvaluationSummary().getPrecision());
            session.setAttribute("recall", eval.getEvaluationSummary().getRecall());
            session.setAttribute("fmeasure", eval.getEvaluationSummary().getFmeasure());
            session.setAttribute("areaUnderROC", eval.getEvaluationSummary().getAreaUnderRoc());
            session.setAttribute("modello", inputModel);
            session.setAttribute("predictors", eval.getAnalyzedClasses());
            session.setAttribute("issueTracker", issueTracker);
            ServletContext sc = getServletContext();
            RequestDispatcher rd = sc.getRequestDispatcher("/prediction.jsp");
            rd.forward(request, response);
        }
        else{   //SHOW EXISTING EVALUATION
            Evaluation eval = DataExtractor.getEvaluation(projFolderPath, projName, model);
            session.setAttribute("accuracy", eval.getEvaluationSummary().getAccuracy());
            session.setAttribute("precision", eval.getEvaluationSummary().getPrecision());
            session.setAttribute("recall", eval.getEvaluationSummary().getRecall());
            session.setAttribute("fmeasure", eval.getEvaluationSummary().getFmeasure());
            session.setAttribute("areaUnderROC", eval.getEvaluationSummary().getAreaUnderRoc());
            session.setAttribute("modello", model);
            session.setAttribute("predictors", eval.getAnalyzedClasses());
            session.setAttribute("issueTracker", issueTracker);
            ServletContext sc = getServletContext();
            RequestDispatcher rd = sc.getRequestDispatcher("/prediction.jsp");
            rd.forward(request, response);
        }
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
