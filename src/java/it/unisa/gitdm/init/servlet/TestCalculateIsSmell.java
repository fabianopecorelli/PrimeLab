/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.unisa.gitdm.init.servlet;

/**
 *
 * @author giuse
 */
import it.unisa.gitdm.experiments.CalculateSmellFiles;
import it.unisa.gitdm.algorithm.Process;
import it.unisa.gitdm.bean.Commit;
import it.unisa.gitdm.bean.FileBean;
import it.unisa.gitdm.bean.Metric;
import it.unisa.gitdm.bean.Model;
import it.unisa.gitdm.bean.MyClassifier;
import it.unisa.gitdm.bean.Period;
import it.unisa.gitdm.bean.metrics.smellMetrics.ELOC;
import it.unisa.gitdm.bean.metrics.smellMetrics.NMNOPARAM;
import it.unisa.gitdm.bean.metrics.smellMetrics.NOPA;
import it.unisa.gitdm.evaluation.WekaEvaluator;
import it.unisa.gitdm.metrics.ReadSourceCode;
import it.unisa.gitdm.metrics.parser.bean.ClassBean;
import it.unisa.gitdm.scattering.DeveloperFITreeManager;
import it.unisa.gitdm.scattering.DeveloperTreeManager;
import it.unisa.gitdm.scattering.PeriodManager;
import it.unisa.gitdm.source.Git;
import it.unisa.primeLab.Config;
import static it.unisa.primeLab.Config.baseFolderPath;
import static it.unisa.primeLab.Config.scatteringFolderPath;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
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
import weka.classifiers.functions.Logistic;
import it.unisa.gitdm.bean.MyClassifier;
import it.unisa.gitdm.bean.Project;
import it.unisa.primeLab.ProjectHandler;
import java.io.FileOutputStream;
import java.io.ObjectOutputStream;

public class TestCalculateIsSmell {
    public static void main(String[] args) throws FileNotFoundException, IOException, InterruptedException {
//        String url = "https://github.com/apache/derby.git";
//        Git.clone(url , false, "derby", baseFolderPath, "10.9");
        ArrayList<Metric> metrics = new ArrayList<Metric>();
        metrics.add(new ELOC());
        metrics.add(new NOPA());
        metrics.add(new NMNOPARAM());
        MyClassifier c1 = new MyClassifier("Logistic Regression");
        c1.setClassifier(new Logistic());
        String type = "CodeSmellDetection";
        String smell = "Large Class";
        Model model = new Model("antModel1", "ant", "https://github.com/apache/ant.git", metrics, c1, "", type, smell);
        Process process = new Process();
        String periodLength = "All";
        
        String projectName = model.getProjName();
        process.initGitRepositoryFromFile(scatteringFolderPath + "/" + projectName
                + "/gitRepository.data");
        try {
            DeveloperTreeManager.calculateDeveloperTrees(process.getGitRepository()
                    .getCommits(), periodLength);
            DeveloperFITreeManager.calculateDeveloperTrees(process.getGitRepository()
                    .getCommits(), periodLength);
        } catch (Exception ex) {
            Logger.getLogger(TestFile.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        List<Commit> commits = process.getGitRepository().getCommits();
        PeriodManager.calculatePeriods(commits, periodLength);
        List<Period> periods = PeriodManager.getList();
        
        String dirPath = Config.baseDir + projectName + "/models/" + model.getName();
        Files.createDirectories(Paths.get(dirPath));
        
        for (Period p : periods) {
            File periodData = new File(dirPath + "/predictors.csv");
            PrintWriter pw1 = new PrintWriter(periodData);
            
            String message1 = "nome,";
            for(Metric m : metrics) {
                message1 += m.getNome() + ",";
            }
            message1 += "isSmell\n";
            pw1.write(message1);
            
            //String baseSmellPatch = "C:/ProgettoTirocinio/dataset/apache-ant-data/apache_1.8.3/Validated";
            CalculateSmellFiles cs = new CalculateSmellFiles(model.getProjName(), "Large Class", "1.8.1");
            
            List<FileBean> smellClasses = cs.getSmellClasses();
            
            String projectPath = baseFolderPath + projectName;
            
            Git.gitReset(new File(projectPath));
            Git.clean(new File(projectPath));
            
            List<FileBean> repoFiles = Git.gitList(new File(projectPath));
            System.out.println("Repo size: "+repoFiles.size());
            
            
            for (FileBean file : repoFiles) {
                
                if (file.getPath().contains(".java")) {
                    File workTreeFile = new File(projectPath + "/" + file.getPath());

                    ClassBean classBean = null;
                    
                    if (workTreeFile.exists()) {
                        ArrayList<ClassBean> code = new ArrayList<>();
                        ArrayList<ClassBean> classes = ReadSourceCode.readSourceCode(workTreeFile, code);
                        
                        String body = file.getPath() + ",";
                        if (classes.size() > 0) {
                            classBean = classes.get(0);

                        }
                        for(Metric m : metrics) {
                            try{
                                body += m.getValue(classBean, classes, null, null, null, null) + ",";
                            } catch(NullPointerException e) {
                                body += "0.0,";
                            }
                        }
                        
                        //isSmell
                        boolean isSmell = false;
                        for(FileBean sm : smellClasses) {
                            if(file.getPath().contains(sm.getPath())) {
                                System.out.println("ok");
                                isSmell = true;
                                break;
                            }
                        }
                        
                        body = body + isSmell + "\n";
                        pw1.write(body);     
                    }
                }
            }
            Git.gitReset(new File(projectPath));
            pw1.flush();
        }
        
        WekaEvaluator we1 = new WekaEvaluator(baseFolderPath, projectName, new Logistic(), "Logistic Regression", model.getName());
        
        ArrayList<Model> models = new ArrayList<Model>();
            
        models.add(model);
            System.out.println(models);
            //create a project
            Project p1 = new Project("https://github.com/apache/ant.git");
            p1.setModels(models);
            p1.setName("ant");
            
            ArrayList<Project> projects;
            //projects.add(p1);
            
            //create a file
//            try {
//                File f = new File(Config.baseDir + "projects.txt");
//                FileOutputStream fileOut;
//                if(f.exists()){
//                    projects = ProjectHandler.getAllProjects(); 
//                    Files.delete(Paths.get(Config.baseDir + "projects.txt"));
//                    //fileOut = new FileOutputStream(f, true);
//                } else {
//                    projects = new ArrayList<Project>();
//                    Files.createFile(Paths.get(Config.baseDir + "projects.txt"));
//                }
//                fileOut = new FileOutputStream(f);
//                projects.add(p1);
//            ObjectOutputStream out = new ObjectOutputStream(fileOut);
//            out.writeObject(projects);
//            out.close();
//            fileOut.close();
//
//            } catch (FileNotFoundException e) {
//                e.printStackTrace();
//            } catch (IOException e) {
//                e.printStackTrace();
//            }
//            ProjectHandler.setCurrentProject(p1);
//            Project curr = ProjectHandler.getCurrentProject();
//            System.out.println(curr.getGitURL()+" --- "+curr.getModels());
//            ArrayList<Project> projectest = ProjectHandler.getAllProjects();
//            for(Project testp : projectest){
//                System.out.println(testp.getModels());
//            }
    }
    
}
