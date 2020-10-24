/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.unisa.gitdm.bean;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Objects;
import weka.classifiers.Classifier;

/**
 *
 * @author fabiano
 */
public class Model implements Serializable{
    private String name;
    private String projName;
    private String projURL;
    private ArrayList<Metric> metrics;
    private MyClassifier classifier;
    private String date;

    public Model(String name, String projName, String projURL, ArrayList<Metric> metrics, MyClassifier classifier, String date) {
        this.name = name;
        this.projName = projName;
        this.projURL = projURL;
        this.metrics = metrics;
        this.classifier = classifier;
        this.date = date;
    }
    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    public String getProjName(){
        return projName;
    }
    
    public void setProjName(String projName){
        this.projName = projName;
    }
    
    public String getProjURL(){
        return projURL;
    }
    
    public void setProjURL(String projURL){
        this.projURL = projURL;
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

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
    
    @Override
    public String toString() {
        return "Model{" + "name=" + name + ", metrics=" + metrics + ", classifier=" + classifier + '}';
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Model other = (Model) obj;
        if (!Objects.equals(this.metrics, other.metrics)) {
            System.err.print("different metrics " +this.metrics + " " + other.metrics);
            return false;
        }
        if (!Objects.equals(this.classifier.toString(), other.classifier.toString())) {
            System.err.print("different metrics");
            return false;
        }
        return true;
    }
    
    
}
