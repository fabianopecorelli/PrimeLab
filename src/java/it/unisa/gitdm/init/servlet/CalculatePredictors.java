package it.unisa.gitdm.init.servlet;

import it.unisa.gitdm.algorithm.Process;
import it.unisa.gitdm.bean.*;
import it.unisa.gitdm.experiments.CalculateSmellFiles;
import it.unisa.gitdm.metrics.CKMetrics;
import it.unisa.gitdm.metrics.ReadSourceCode;
import it.unisa.gitdm.metrics.parser.bean.ClassBean;
import it.unisa.gitdm.scattering.DeveloperFITreeManager;
import it.unisa.gitdm.scattering.DeveloperTreeManager;
import it.unisa.gitdm.scattering.PeriodManager;
import it.unisa.gitdm.scattering.ScatteringMetricsParser;
import it.unisa.gitdm.source.Git;
import it.unisa.primeLab.Config;
import org.apache.commons.io.FileUtils;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CalculatePredictors {

    public CalculatePredictors(String projectName, String issueTracker, String issueTrackerPath,
                               String productName, String periodLength, String baseFolderPath,
                               String scatteringFolderPath, Model model, String version) throws IOException {

        ArrayList<Metric> metrics = model.getMetrics();
        System.out.println("#########metrics\n"+metrics.toString());
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
        
        // Load files and folders
        ScatteringMetricsParser structuralMP = null;
        //if(metrics.contains(new Metric("structural scatering"))) {
            structuralMP = new ScatteringMetricsParser();
            File structuralScatteringFile = new File(scatteringFolderPath + projectName + "/"
                + periodLength + "/structuralScattering.csv");
            try {
                structuralMP.parseFile(structuralScatteringFile);
            } catch (NumberFormatException | IOException ex) {
                Logger.getLogger(CalculatePredictors.class.getName()).log(Level.SEVERE, null, ex);
            }
        //}
        ScatteringMetricsParser semanticalMP = null;
        //if(metrics.contains(new Metric("semantic scatering"))) {
            semanticalMP = new ScatteringMetricsParser();
            File semanticScatteringFile = new File(scatteringFolderPath + projectName + "/"
                + periodLength + "/semanticScattering.csv");
            try {
                semanticalMP.parseFile(semanticScatteringFile);
            } catch (NumberFormatException | IOException ex) {
                Logger.getLogger(CalculatePredictors.class.getName()).log(Level.SEVERE, null, ex);
            }
        //}
        
        String dirPath = Config.baseDir + projectName + "/models/" + model.getName();
        Files.createDirectories(Paths.get(dirPath));
        //Calculating file complexity
        for(Period p : periods) {
            
                File periodData = new File(dirPath + "/predictors.csv");
                PrintWriter pw1 = null;
                
                try {
                    pw1 = new PrintWriter(periodData);
                    pw1.write(CalculatePredictors.writeHeading(metrics, model.getType()));
                    

                    List<FileBean> periodFiles = null;
                    
                    if(model.getType().equals("BugPrediction")) {
                        CalculateBuggyFiles cbf = new CalculateBuggyFiles(scatteringFolderPath, projectName, issueTracker, issueTrackerPath, productName, false, false, false);
                        periodFiles = cbf.getBuggyFiles();
                    } else {
                        CalculateSmellFiles csf = new CalculateSmellFiles(projectName, model.getSmell() ,version);
                        periodFiles = csf.getSmellClasses();
                    }
                    String projectPath = baseFolderPath + projectName;
                    File workTreeFolder = new File(baseFolderPath + "wd");
                    FileUtils.deleteDirectory(workTreeFolder);
                    workTreeFolder.mkdirs();
                    
                    
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
                                        body += m.getValue(classBean, classes, structuralMP, semanticalMP, file, p) + ",";
                                    } catch(NullPointerException e) {
                                        body += "0.0,";
                                    }
                                }
                                
                                //buggy
                                boolean isBuggy = false;

                                for (FileBean fileBean : periodFiles) {
                                    if (file.getPath().contains(fileBean.getPath())) {
                                        isBuggy = true;
                                        break;
                                    }
                                }
                                body = body + isBuggy + "\n";
                                
                                pw1.write(body);
                                
                            }
                        }
                    }
                    Git.gitReset(new File(projectPath));
                    pw1.flush();
                    
                    System.out.println(periodData);
                } catch (FileNotFoundException ex) {
                    Logger.getLogger(CalculatePredictors.class.getName()).log(Level.SEVERE, null, ex);
                } catch (IOException ex) {
                Logger.getLogger(CalculatePredictors.class.getName()).log(Level.SEVERE, null, ex);
            }
                
        }
        
    }
    
    private static String writeHeading(ArrayList<Metric> metrics, String type) {
        
        String heading = "name,";
        
        for(Metric m : metrics) {
            heading = heading + m.getNome() + ",";
        }
        if(type.equals("BugPrediction")) {
            heading = heading + "isBuggy\n";
        } else {
            heading += "isSmell\n";
        }
        System.out.print(heading);
        return heading;
    }
    

    private int getTotalNumberOfChanges(Period p) {
        int totalNumberOfChanges = 0;

        List<FileBean> periodFiles = PeriodManager.getFiles(p.getId());

        for (FileBean periodFileBean : periodFiles) {
            if (periodFileBean.getPath().contains(".java")) {

                List<Developer> developersOnFile = DeveloperTreeManager
                        .getDevelopersOnFile(periodFileBean,
                                p.getId());

                for (Developer developer : developersOnFile) {
                    totalNumberOfChanges += DeveloperTreeManager
                            .getNumberOfChanges(developer,
                                    p.getId(), periodFileBean);
                }
            }
        }
        return totalNumberOfChanges;
    }
}
