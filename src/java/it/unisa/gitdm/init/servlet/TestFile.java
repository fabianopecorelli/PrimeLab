package it.unisa.gitdm.init.servlet;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import it.unisa.gitdm.algorithm.Process;
import it.unisa.gitdm.bean.Commit;
import it.unisa.gitdm.bean.FileBean;
import it.unisa.gitdm.bean.Metric;
import it.unisa.gitdm.bean.Model;
import it.unisa.gitdm.bean.MyClassifier;
import it.unisa.gitdm.bean.Period;
import it.unisa.gitdm.bean.Project;
import it.unisa.gitdm.bean.metrics.CKMetrics.CBO;
import it.unisa.gitdm.bean.metrics.CKMetrics.RFC;
import it.unisa.gitdm.bean.metrics.CKMetrics.WMC;
import it.unisa.gitdm.bean.metrics.process.NumberOfFix;
import it.unisa.gitdm.evaluation.WekaEvaluator;
import it.unisa.gitdm.metrics.CKMetrics;
import it.unisa.gitdm.metrics.ReadSourceCode;
import it.unisa.gitdm.metrics.parser.bean.ClassBean;
import it.unisa.gitdm.scattering.DeveloperFITreeManager;
import it.unisa.gitdm.scattering.DeveloperTreeManager;
import it.unisa.gitdm.scattering.PeriodManager;
import it.unisa.gitdm.source.Git;
import it.unisa.primeLab.Config;
import it.unisa.primeLab.ProjectHandler;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.commons.io.FileUtils;
import weka.classifiers.bayes.NaiveBayes;
import weka.classifiers.functions.Logistic;

/**
 *
 * @author giuse
 */
public class TestFile {
    
    public static void main(String [] args) throws IOException {
        String projectName = "ant";
        String issueTracker = "bugzilla";
        String issueTrackerPath = "https://issues.apache.org/bugzilla/";
        String productName = "ant";
        String periodLength = "All";
        String baseFolderPath = "C:/ProgettoTirocinio/gitdm/";
        String scatteringFolderPath = "C:/ProgettoTirocinio/gitdm/scattering/";
        
        ArrayList<Metric> metrics = new ArrayList<Metric>();
        metrics.add(new WMC());
        metrics.add(new RFC());
        metrics.add(new CBO());
        metrics.add(new NumberOfFix());
        
        
        Process process = new Process() {};
        
        process.initGitRepositoryFromFile(scatteringFolderPath + "/" + projectName
                + "/gitRepository.data");
        
        // Calculate developer trees
        try {
            DeveloperTreeManager.calculateDeveloperTrees(process.getGitRepository()
                    .getCommits(), periodLength);
            DeveloperFITreeManager.calculateDeveloperTrees(process.getGitRepository()
                    .getCommits(), periodLength);
        } catch (Exception ex) {
            Logger.getLogger(TestFile.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        // Calculate periods
        List<Commit> commits = process.getGitRepository().getCommits();
        PeriodManager.calculatePeriods(commits, periodLength);
        List<Period> periods = PeriodManager.getList();

        
        // Calculating file complexity
            for (Period p : periods) {

                File periodData = new File(baseFolderPath + projectName + "/predictors.csv");
                PrintWriter pw1 = null;
            try {
                pw1 = new PrintWriter(periodData);
            } catch (FileNotFoundException ex) {
                Logger.getLogger(TestFile.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            String message = "";
            for(Metric m : metrics) {
                message += m.getNome() + ",";
            }
                pw1.write("name,"
                        + message + "isBuggy\n");

                CalculateBuggyFiles cbf = new CalculateBuggyFiles(scatteringFolderPath, projectName, issueTracker, issueTrackerPath, productName, false, false, false);

                List<FileBean> periodBuggyFiles = cbf.getBuggyFiles();
                
                String projectPath = baseFolderPath + projectName;
                File workTreeFolder = new File(baseFolderPath + "wd");
            try {
                FileUtils.deleteDirectory(workTreeFolder);
            } catch (IOException ex) {
                Logger.getLogger(TestFile.class.getName()).log(Level.SEVERE, null, ex);
            }
                workTreeFolder.mkdirs();

               // int middleCommitNumber = p.getCommits().size() / 2;

             //   Commit c = p.getCommits().get(middleCommitNumber);

                Git.gitReset(new File(projectPath));
                Git.clean(new File(projectPath));
           //     Git.gitCheckout(new File(projectPath), c, workTreeFolder);

                List<FileBean> repoFiles = Git.gitList(new File(projectPath));
                System.out.println("Repo size: "+repoFiles.size());
                for (FileBean file : repoFiles) {

                    if (file.getPath().contains(".java")) {
                        File workTreeFile = new File(projectPath + "/" + file.getPath());

                        ClassBean classBean = null;

                        if (workTreeFile.exists()) {
                            ArrayList<ClassBean> code = new ArrayList<>();
                            ArrayList<ClassBean> classes = null;
                            try {
                                classes = ReadSourceCode.readSourceCode(workTreeFile, code);
                            } catch (IOException ex) {
                                Logger.getLogger(TestFile.class.getName()).log(Level.SEVERE, null, ex);
                            }
                            
                            String message1 = file.getPath() + ",";
                            if (classes.size() > 0) {
                                classBean = classes.get(0);
                                
                            }
                            for(Metric m : metrics) {
                                try{
                                    message1 += m.getValue(classBean, classes, null, null, file, p) + ",";
                                } catch(NullPointerException e) {
                                    message1 += "0.0,";
                                }
                            }
                            
                            
                            boolean isBuggy = false;

                            for (FileBean fileBean : periodBuggyFiles) {
                                if (fileBean.getPath().equals(
                                        file.getPath())) {
                                    isBuggy = true;
                                    break;
                                }
                            }

                            message1 += isBuggy + "\n";

                            pw1.write(message1);
                        }
                    }
                }
                Git.gitReset(new File(projectPath));
                pw1.flush();

                System.out.println(periodData);
            }
            //end for calculate 
            
            String modelName = "antModel1";
            //predizione
            WekaEvaluator we = new WekaEvaluator(baseFolderPath, projectName, new NaiveBayes(), "Naive Baesian", modelName);
            WekaEvaluator we1 = new WekaEvaluator(baseFolderPath, projectName, new Logistic(), "Logistic Regression", "antModel2");
            
            //file projects.txt
            ArrayList<Model> models = new ArrayList<Model>();
            
            DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm");
            Date date = new Date();
            String now = dateFormat.format(date);
            MyClassifier c1 = new MyClassifier("Logistic Regression");
            c1.setClassifier(new Logistic());
            models.add(new Model("antModel1", "ant", "https://github.com/apache/ant.git", metrics, c1, now));
            MyClassifier c2 = new MyClassifier("Naive Baesian");
            c2.setClassifier(new NaiveBayes());
            models.add(new Model("antModel2", "ant", "https://github.com/apache/ant.git", metrics, c2, now));
            System.out.println(models);
            //create a project
            Project p1 = new Project("https://github.com/apache/ant.git");
            p1.setModels(models);
            p1.setName("ant");
            
            ArrayList<Project> projects;
            //projects.add(p1);
            
            //create a file
            try {
                File f = new File(Config.baseDir + "projects.txt");
                FileOutputStream fileOut;
                if(f.exists()){
                    projects = ProjectHandler.getAllProjects(); 
                    Files.delete(Paths.get(Config.baseDir + "projects.txt"));
                    //fileOut = new FileOutputStream(f, true);
                } else {
                    projects = new ArrayList<Project>();
                    Files.createFile(Paths.get(Config.baseDir + "projects.txt"));
                }
                fileOut = new FileOutputStream(f);
                projects.add(p1);
            ObjectOutputStream out = new ObjectOutputStream(fileOut);
            out.writeObject(projects);
            out.close();
            fileOut.close();

            } catch (FileNotFoundException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
            ProjectHandler.setCurrentProject(p1);
            Project curr = ProjectHandler.getCurrentProject();
            System.out.println(curr.getGitURL()+" --- "+curr.getModels());
            ArrayList<Project> projectest = ProjectHandler.getAllProjects();
            for(Project testp : projectest){
                System.out.println(testp.getModels());
            }
//            ArrayList<Model> models = new ArrayList<Model>();
//            ArrayList<Metric> metrics = new ArrayList<Metric>();
//            metrics.add(new Metric("CBO"));
//            metrics.add(new Metric("LOC"));
//            metrics.add(new Metric("NOC"));
//            metrics.add(new Metric("numberOfChanges"));
//            DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm");
//            Date date = new Date();
//            String now = dateFormat.format(date);
//            MyClassifier c1 = new MyClassifier("Naive Baesian");
//            c1.setClassifier(new NaiveBayes());
//            String modelName = "MdTest";
//            models.add(new Model(modelName, "ant", "https://github.com/apache/ant.git", metrics, c1, now));
//            System.out.println(models);
//            //create a project
//            Project p1 = new Project("https://github.com/apache/ant.git");
//            p1.setModels(models);
            //CalculatePredictors.CalculateSpecificPredictors(projectName, issueTracker, issueTrackerPath, productName, periodLength, baseFolderPath, scatteringFolderPath, models.get(0));
            //CalculatePredictors calculate = new CalculatePredictors(projectName, issueTracker, issueTrackerPath, productName, periodLength, baseFolderPath, scatteringFolderPath);
        }
    }
    
