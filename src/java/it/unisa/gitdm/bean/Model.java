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
    private String type;
    private String smell;

    public Model(String name, String projName, String projURL, ArrayList<Metric> metrics, MyClassifier classifier, String date, String type, String smell) {
        this.name = name;
        this.projName = projName;
        this.projURL = projURL;
        this.metrics = metrics;
        this.classifier = classifier;
        this.date = date;
        this.type = type;
        this.smell = smell;
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

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getSmell() {
        return smell;
    }

    public void setSmell(String smell) {
        this.smell = smell;
    }
    
    
    
    
    @Override
    public String toString() {
        if(smell == null) {
            return "Model{" + "name=" + name + ", metrics=" + metrics + ", classifier=" + classifier + ", type=" + type + '}';
        } else {
            return "Model{" + "name=" + name + ", metrics=" + metrics + ", classifier=" + classifier + ", type=" + type + ", smell=" + this.smell + '}';
        }
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
        if(!Objects.equals(this.smell, other.smell)) {
            return false;
        }
        return true;
    }
    
    
}
