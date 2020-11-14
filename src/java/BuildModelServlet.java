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
import it.unisa.gitdm.init.servlet.CalculateBuggyFiles;
import it.unisa.gitdm.experiments.CalculateDeveloperSemanticScattering;
import it.unisa.gitdm.experiments.CalculateDeveloperStructuralScattering;
import it.unisa.gitdm.experiments.Checkout;
import it.unisa.gitdm.init.servlet.CalculatePredictors;
import it.unisa.gitdm.source.Git;
import it.unisa.primeLab.ProjectHandler;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.LinkOption;
import java.nio.file.Paths;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
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
        
        String type =(String) request.getParameter("type");
        if(type == null || type.equals("")) {
            type = (String) session.getAttribute("typePrediction");
        }
        String version = request.getParameter("version");
        if(version == null) {
            version = "";
        }
        String smell = request.getParameter("smell");
        
        System.out.println(type);
        // GET REQUEST PARAMETER
        String github = request.getParameter("github");
        Project curr = new Project(github);
        ArrayList<Model> models = new ArrayList<Model>();
        String issueTracker = "";
        String issueTrackerName = "";
        
        
        
        String[] checkedMetrics = request.getParameterValues("metrics");
        ArrayList<Metric> metrics = new ArrayList<Metric>();
        //System.out.println(issueTracker);
        
        
        
        //System.out.println(issueTrackerName);
        System.out.println(checkedMetrics[0]);
        for (String s : checkedMetrics) {
            System.out.println(s);
            metrics.add(MetricBuilder.MyMetric(s));
        }
        
        System.out.println(metrics);
        MyClassifier classifier = ClassifierBuilder.buildClassifier(request.getParameterValues("classifier")[0]);
        System.out.println(classifier);
        String dirName = github.split(".com/")[1].split(".git")[0];
        String[] splitted = dirName.split("/");
        String projName = splitted[splitted.length - 1];
        curr.setName(projName);
        curr.setVersion(version);
        String projFolderPath = "" + Config.baseDir + projName;

//        System.out.println("*******"+ProjectHandler.getCurrentProject().getModels().toString());
//        System.out.println("*****"+curr.getName());
        try {
            ProjectHandler.setCurrentProject(curr);
            curr = ProjectHandler.getCurrentProject();
            models = ProjectHandler.getCurrentProject().getModels();
            issueTracker = request.getParameterValues("issueTracker")[0];
        } catch(NullPointerException e) {
            curr = new Project(github);
            curr.setName(projName);
            curr.setVersion(version);
            
        }
        
        if(issueTracker == null) {
            issueTracker = "";
        }
        String[] parts = issueTracker.split("/");
        issueTrackerName = parts[parts.length - 1];
        Model model = ModelBuilder.buildModel(curr.getName(), curr.getGitURL(), metrics, classifier, type, smell);
        for(Project pro : ProjectHandler.getAllProjects()) {
            System.out.print(pro);
        }
        if (model == null) { // calculate evaluation
            curr.setModels(models);
            
            DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm");
            Date date = new Date();
            String now = dateFormat.format(date);
            System.out.println(models.size() + 1);
            Model inputModel = new Model(curr.getName() + "Model" + (models.size() + 1), curr.getName(), curr.getGitURL(), metrics, classifier, now, type, smell);
            models.add(inputModel);
            
            String scatteringFolderPath = "C:/ProgettoTirocinio/gitdm/scattering/";
            String baseFolderPath = "C:/ProgettoTirocinio/gitdm/";
            
            String periodLength = "All";
            
            //check if exist repository
            boolean isSVN = false;
//            try {
//                Git.clone(curr.getGitURL(), isSVN, curr.getName(), baseFolderPath, version);
//            } catch (InterruptedException ex) {
//                Logger.getLogger(BuildModelServlet.class.getName()).log(Level.SEVERE, null, ex);
//            }
//
//            boolean init = (Files.notExists(Paths.get(scatteringFolderPath + "/" + curr.getName() + "buggyFiles.data"), LinkOption.NOFOLLOW_LINKS) || Files.notExists(Paths.get(scatteringFolderPath + curr.getName() + "/" + periodLength + "/developersChanges.data"), LinkOption.NOFOLLOW_LINKS));
//            System.out.println(init);
//            Checkout checkout = new Checkout(curr.getName(), periodLength, baseFolderPath, scatteringFolderPath, true);
//            
//            CalculateDeveloperStructuralScattering calculateDeveloperStructuralScattering = new CalculateDeveloperStructuralScattering(curr.getName(), periodLength, scatteringFolderPath);
//            
//            CalculateDeveloperSemanticScattering calculateDeveloperSemanticScattering = new CalculateDeveloperSemanticScattering(curr.getName(), periodLength, baseFolderPath, scatteringFolderPath);
            

            
            CalculatePredictors cp = new CalculatePredictors(projName, issueTrackerName, issueTracker, projName, "All", baseFolderPath, scatteringFolderPath, inputModel, version);
            
            String baseFolder = "C:/ProgettoTirocinio/gitdm/";
            WekaEvaluator we = new WekaEvaluator(baseFolder, projName, classifier.getClassifier(), classifier.getName(), inputModel.getName());
            
            //p.setModels(models);
            
            ProjectHandler.addProject(curr);
            System.out.println(ProjectHandler.getAllProjects().size());
            
            Evaluation eval = DataExtractor.getEvaluation(projFolderPath, projName, inputModel);
            session.setAttribute("accuracy", eval.getEvaluationSummary().getAccuracy());
            session.setAttribute("precision", eval.getEvaluationSummary().getPrecision());
            session.setAttribute("recall", eval.getEvaluationSummary().getRecall());
            session.setAttribute("fmeasure", eval.getEvaluationSummary().getFmeasure());
            session.setAttribute("areaUnderROC", eval.getEvaluationSummary().getAreaUnderRoc());
            session.setAttribute("modello", inputModel);
            session.setAttribute("predictors", eval.getAnalyzedClasses());
            session.setAttribute("issueTracker", issueTracker);
            session.setAttribute("typePrediction", type);
            session.setAttribute("project", curr);
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
            session.setAttribute("typePrediction", type);
            session.setAttribute("project", ProjectHandler.getCurrentProject());
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
