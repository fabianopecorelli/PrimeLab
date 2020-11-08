/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.unisa.gitdm.evaluation;

import it.unisa.primeLab.Config;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import weka.classifiers.Classifier;
import weka.classifiers.Evaluation;
import weka.core.Attribute;
import weka.core.Instances;
import weka.core.converters.ConverterUtils.DataSource;
import org.bounce.net.DefaultAuthenticator;
import weka.core.converters.CSVLoader;
/**
 *
 * @author fabiano
 */
public class WekaEvaluator {

    public WekaEvaluator(String baseFolderPath, String projectName, Classifier classifier, String classifierName, String modelName) throws IOException {
        // READ FILE
        /*CODICE VECCHIO
        try {
            BufferedReader reader = new BufferedReader(new FileReader(filePath));
            Instances data = new Instances(reader);
            data.setClassIndex(data.numAttributes() - 1);
            System.out.println(data.size());
            // dividere istance in train e test
            Instances train = data;
            Instances test = null;

            // EVALUATION
            Evaluation eval = new Evaluation(train);
            //eval.evaluateModel(j48, test);
            // CROSS-VALIDATION
            eval.crossValidateModel(classifier, train, 10, new Random(1));
            System.out.println(eval.toSummaryString());
            System.out.println(eval.toMatrixString());

        } catch (Exception ex) {
            Logger.getLogger(WekaEvaluator.class.getName()).log(Level.SEVERE, null, ex);
        } 
        CODICE VECCHIO*/
        String dirPath = Config.baseDir + projectName + "/models/" + modelName;
        /*Files.createDirectories(Paths.get(dirPath));
        Files.copy(Paths.get(baseFolderPath + projectName + "/predictors.csv"),  Paths.get(Config.baseDir + projectName + "/models/" + modelName + "/predictors.csv"));*/
        CSVLoader loader = new CSVLoader();
        String filePath = dirPath + "/predictors.csv";
        System.out.println(filePath);
        loader.setSource(new File(filePath));
        try {
            //DataSource source = new DataSource(filePath);
            Instances instances = loader.getDataSet();
            instances.setClassIndex(instances.numAttributes() - 1);
            System.out.println("Numero istanze: " + instances.size());
            evaluateModel(baseFolderPath, projectName, classifier, instances, modelName, classifierName);
        } catch (Exception ex) {
            Logger.getLogger(WekaEvaluator.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private static void evaluateModel(String baseFolderPath, String projectName, Classifier pClassifier, Instances pInstances, String pModelName, String pClassifierName) throws Exception {

        System.out.println(pModelName);
        // other options
        int folds = 10;

        // randomize data
        Random rand = new Random(42);
        Instances randData = new Instances(pInstances);
        randData.randomize(rand);
        if (randData.classAttribute().isNominal()) {
            randData.stratify(folds);
        }

        // perform cross-validation and add predictions
        Instances predictedData = null;
        Evaluation eval = new Evaluation(randData);

        int positiveValueIndexOfClassFeature = 0;
        for (int n = 0; n < folds; n++) {
            Instances train = randData.trainCV(folds, n);
            Instances test = randData.testCV(folds, n);
            // the above code is used by the StratifiedRemoveFolds filter, the
            // code below by the Explorer/Experimenter:
            // Instances train = randData.trainCV(folds, n, rand);
          
            //numero di colonne
            int classFeatureIndex = 0;
            for (int i = 0; i < train.numAttributes(); i++) {
                if (train.attribute(i).name().equals("isBuggy") || train.attribute(i).name().equals("isSmell")) {
                    classFeatureIndex = i;
                    break;
                }
            }

            //Atribute classe per la gestione di un attributo. Una volta che un attributo è stato creato, non può essere modificato.
            Attribute classFeature = train.attribute(classFeatureIndex);
            for (int i = 0; i < classFeature.numValues(); i++) {
                if (classFeature.value(i).equals("TRUE")) {
                    positiveValueIndexOfClassFeature = i;
                }
            }
            
            //viene utilizzato per definire l'attributo che rappresenterà la classe (per scopi di previsione)
            train.setClassIndex(classFeatureIndex);
            test.setClassIndex(classFeatureIndex);
            
            // build and evaluate classifier
            pClassifier.buildClassifier(train);
            eval.evaluateModel(pClassifier, test);

            // add predictions
//	        AddClassification filter = new AddClassification();
//	        filter.setClassifier(pClassifier);
//	        filter.setOutputClassification(true);
//	        filter.setOutputDistribution(true);
//	        filter.setOutputErrorFlag(true);
//	        filter.setInputFormat(train);
//	        Filter.useFilter(train, filter); 
//	        Instances pred = Filter.useFilter(test, filter); 
//	        if (predictedData == null)
//	          predictedData = new Instances(pred, 0);
//	        
//	        for (int j = 0; j < pred.numInstances(); j++)
//	          predictedData.add(pred.instance(j));
        }
        double accuracy
                = (eval.numTruePositives(positiveValueIndexOfClassFeature)
                + eval.numTrueNegatives(positiveValueIndexOfClassFeature))
                / (eval.numTruePositives(positiveValueIndexOfClassFeature)
                + eval.numFalsePositives(positiveValueIndexOfClassFeature)
                + eval.numFalseNegatives(positiveValueIndexOfClassFeature)
                + eval.numTrueNegatives(positiveValueIndexOfClassFeature));

        double fmeasure = 2 * ((eval.precision(positiveValueIndexOfClassFeature) * eval.recall(positiveValueIndexOfClassFeature))
                / (eval.precision(positiveValueIndexOfClassFeature) + eval.recall(positiveValueIndexOfClassFeature)));
        File wekaOutput = new File(Config.baseDir + projectName + "/models/" + pModelName + "/wekaOutput.csv");
        System.out.println(Config.baseDir + projectName + "/models/" + pModelName + "/wekaOutput.csv");
        try (PrintWriter pw1 = new PrintWriter(wekaOutput)) {
            pw1.write(accuracy + ";" + eval.precision(positiveValueIndexOfClassFeature) + ";"
                    + eval.recall(positiveValueIndexOfClassFeature) + ";" + fmeasure + ";" + eval.areaUnderROC(positiveValueIndexOfClassFeature));
            pw1.flush();
            pw1.close();
        }
        
         
        System.out.println(projectName + ";" + pClassifierName + ";" + pModelName + ";" + eval.numTruePositives(positiveValueIndexOfClassFeature) + ";"
                + eval.numFalsePositives(positiveValueIndexOfClassFeature) + ";" + eval.numFalseNegatives(positiveValueIndexOfClassFeature) + ";"
                + eval.numTrueNegatives(positiveValueIndexOfClassFeature) + ";" + accuracy + ";" + eval.precision(positiveValueIndexOfClassFeature) + ";"
                + eval.recall(positiveValueIndexOfClassFeature) + ";" + fmeasure + ";" + eval.areaUnderROC(positiveValueIndexOfClassFeature) + "\n");
    }
}
