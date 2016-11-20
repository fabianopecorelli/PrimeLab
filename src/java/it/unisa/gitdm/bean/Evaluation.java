/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.unisa.gitdm.bean;

import java.io.Serializable;
import java.util.ArrayList;
import weka.classifiers.Classifier;

/**
 *
 * @author fabiano
 */
public class Evaluation implements Serializable{
    
    private EvaluationSummary evaluationSummary;
    private ArrayList<EvaluationPredictors> analyzedClasses;
    private ArrayList<Metric> metrics;
    private MyClassifier classifier;

    public Evaluation(){}

    public Evaluation(EvaluationSummary evaluationSummary, ArrayList<EvaluationPredictors> analyzedClasses, ArrayList<Metric> metrics, MyClassifier classifier) {
        this.evaluationSummary = evaluationSummary;
        this.analyzedClasses = analyzedClasses;
        this.metrics = metrics;
        this.classifier = classifier;
    }

    public EvaluationSummary getEvaluationSummary() {
        return evaluationSummary;
    }

    public void setEvaluationSummary(EvaluationSummary evaluationSummary) {
        this.evaluationSummary = evaluationSummary;
    }

    public ArrayList<EvaluationPredictors> getAnalyzedClasses() {
        return analyzedClasses;
    }

    public void setAnalyzedClasses(ArrayList<EvaluationPredictors> analyzedClasses) {
        this.analyzedClasses = analyzedClasses;
    }

    public ArrayList<Metric> getMetrics() {
        return metrics;
    }

    public void setMetrics(ArrayList<Metric> metrics) {
        this.metrics = metrics;
    }

    public MyClassifier getClassifier() {
        return classifier;
    }

    public void setClassifier(MyClassifier classifier) {
        this.classifier = classifier;
    }
    
    
}
