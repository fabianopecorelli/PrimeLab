package it.unisa.gitdm.init.servlet;

import it.unisa.gitdm.bean.Developer;
import it.unisa.gitdm.bean.DeveloperTree;
import it.unisa.gitdm.evaluation.WekaEvaluator;
import it.unisa.gitdm.experiments.CalculateDeveloperSemanticScattering;
import it.unisa.gitdm.experiments.CalculateDeveloperStructuralScattering;
import it.unisa.gitdm.experiments.Checkout;
import it.unisa.gitdm.source.Git;
import java.io.IOException;
import weka.classifiers.Classifier;
import weka.classifiers.trees.J48;

public class Main {

    public static void main(String[] args) throws IOException, InterruptedException {
        String repoURL = "https://github.com/apache/ant.git";
        //String repoURL = "https://github.com/fabianopecorelli/provaPerTesi.git";
        String projectName = "ant";
        String where = "/home/sesa/Scrivania/gitdm/";
        String scatteringFolder = "/home/sesa/Scrivania/gitdm/scattering/";
        String issueTracker = "bugzilla";
        String bugzillaUrl = "https://issues.apache.org/bugzilla/";
        //classifier
        J48 j48 = new J48();
        String classifierName = "j48";
        String modelName = "myModel";
        
        Main.initAndCheckout(repoURL, where, projectName,"All", scatteringFolder, issueTracker, bugzillaUrl, "Ant", false, false, false, j48, classifierName, modelName);
    }
    
    public static void initAndCheckout(String repoURL, String baseFolder, String projectName, String periodLength,
                                     String scatteringFolderPath, String issueTracker, String issueTrackerPath, String productName, boolean initRepository, boolean initIssueTracker, boolean isSVN, Classifier classifier, String classifierName, String modelName) throws IOException, InterruptedException{
//        Git.clone(repoURL, isSVN, projectName, baseFolder);
  //      Checkout checkout = new Checkout(projectName, periodLength, baseFolder, scatteringFolderPath, initRepository);
    //    CalculateDeveloperStructuralScattering calculateDeveloperStructuralScattering = new CalculateDeveloperStructuralScattering(projectName, periodLength, scatteringFolderPath);
      //  CalculateDeveloperSemanticScattering calculateDeveloperSemanticScattering = new CalculateDeveloperSemanticScattering(projectName, periodLength, baseFolder, scatteringFolderPath);
//        CalculateBuggyFiles calculateBuggyFiles = new CalculateBuggyFiles(scatteringFolderPath, projectName, issueTracker, issueTrackerPath, productName, initIssueTracker, false, isSVN);
        //CalculatePredictors calculatePredictors = new CalculatePredictors(projectName, issueTracker, issueTrackerPath, productName, periodLength, baseFolder, scatteringFolderPath);
        WekaEvaluator we = new WekaEvaluator(projectName, classifier,"/home/fabiano/Desktop/01.csv", classifierName, modelName);
    }
}
