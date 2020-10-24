
import it.unisa.gitdm.bean.Evaluation;
import it.unisa.gitdm.bean.EvaluationPredictors;
import it.unisa.gitdm.bean.EvaluationSummary;
import it.unisa.gitdm.bean.Model;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author fabiano
 */
public class DataExtractor {

    public static Evaluation getEvaluation(String projFolderPath, String projName, Model model) {
        Evaluation toReturn = new Evaluation();
        toReturn.setClassifier(model.getClassifier());
        toReturn.setMetrics(model.getMetrics());
        toReturn.setEvaluationSummary(getEvaluationSummary(projFolderPath, projName, model));
        toReturn.setAnalyzedClasses(getAnalyzedClasses(projFolderPath, projName, model));
        return toReturn;
    }

    private static EvaluationSummary getEvaluationSummary(String projFolderPath, String projName, Model model) {
        String fileName = projFolderPath + "/models/" + model.getName() + "/wekaOutput.csv";
        File file = new File(fileName);
        EvaluationSummary toReturn = null;
        try {
            // -read from filePooped with Scanner class
            Scanner inputStream = new Scanner(file);
            // hashNext() loops line-by-line
            while (inputStream.hasNext()) {
                //read single line, put in string
                String data = inputStream.next();
                String[] splitted = data.split(";");
                for (String s : splitted) {
                    System.out.println(s);
                }
                toReturn = new EvaluationSummary(Double.parseDouble(splitted[0]), Double.parseDouble(splitted[1]), Double.parseDouble(splitted[2]), Double.parseDouble(splitted[3]), Double.parseDouble(splitted[4]));
            }
            // after loop, close scanner
            inputStream.close();

        } catch (FileNotFoundException e) {

            e.printStackTrace();
        }
        //apri file output di weka (va messo in projfolderPath/modelName)
        //leggi da file e ritorna
        return toReturn;
    }
    
    private static ArrayList<EvaluationPredictors> getAnalyzedClasses(String projFolderPath, String projName, Model model) {
        String fileName = projFolderPath + "/models/" + model.getName() + "/predictors.csv";
        System.out.println(projFolderPath);
        File file = new File(fileName);
        ArrayList<EvaluationPredictors> toReturn = new ArrayList<EvaluationPredictors>();
        
        try {
            // -read from filePooped with Scanner class
            Scanner inputStream = new Scanner(file);
            // hashNext() loops line-by-line
            //inputStream.next();
            while (inputStream.hasNext()) {
                //read single line, put in string
                String data = inputStream.next();
                String[] splitted = data.split(",");
                ArrayList<String> list = new ArrayList<String>();
                for(int i = 0; i < splitted.length; i++) {
                    list.add(splitted[i]);
                }
                toReturn.add(new EvaluationPredictors(list));
                //System.out.println(list);
            }
            // after loop, close scanner
            inputStream.close();

        } catch (FileNotFoundException e) {

            e.printStackTrace();
        }
        //apri file output di weka (va messo in projfolderPath/modelName)
        //leggi da file e ritorna
        return toReturn;
    }
}
