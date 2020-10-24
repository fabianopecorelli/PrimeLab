
import it.unisa.gitdm.bean.MyClassifier;
import weka.classifiers.Classifier;
import weka.classifiers.bayes.NaiveBayes;
import weka.classifiers.functions.Logistic;
import weka.classifiers.functions.MultilayerPerceptron;
import weka.classifiers.rules.DecisionTable;
import weka.classifiers.trees.RandomForest;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author fabiano
 */
//Questa classe di occupa di istanziare un classificatore
public class ClassifierBuilder {
    
    public static MyClassifier buildClassifier(String name){
        MyClassifier toReturn = new MyClassifier(name);
        switch(name){
            case "Decision Table Majority": 
                toReturn.setClassifier(new DecisionTable());
                break;
            case "Logistic Regression": 
                toReturn.setClassifier(new Logistic());
                break;
            case "Multi Layer Perceptron": 
                toReturn.setClassifier(new MultilayerPerceptron());
                break;
            case "Naive Baesian": 
                toReturn.setClassifier(new NaiveBayes());
                break;
            case "Random Forest": 
                toReturn.setClassifier(new RandomForest());
                break;
            default: 
                break;
        }
        return toReturn;
    }
    
}
