/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.unisa.gitdm.bean;

import java.io.Serializable;

/**
 *
 * @author fabiano
 */
public class EvaluationSummary implements Serializable{
    
    private double accuracy;
    private double precision;
    private double recall;
    private double fmeasure;
    private double areaUnderRoc;

    public EvaluationSummary(double accuracy, double precision, double recall, double fmeasure, double areaUnderRoc) {
        this.accuracy = accuracy;
        this.precision = precision;
        this.recall = recall;
        this.fmeasure = fmeasure;
        this.areaUnderRoc = areaUnderRoc;
    }

    public double getAccuracy() {
        return accuracy;
    }

    public void setAccuracy(double accuracy) {
        this.accuracy = accuracy;
    }

    public double getPrecision() {
        return precision;
    }

    public void setPrecision(double precision) {
        this.precision = precision;
    }

    public double getRecall() {
        return recall;
    }

    public void setRecall(double recall) {
        this.recall = recall;
    }

    public double getFmeasure() {
        return fmeasure;
    }

    public void setFmeasure(double fmeasure) {
        this.fmeasure = fmeasure;
    }

    public double getAreaUnderRoc() {
        return areaUnderRoc;
    }

    public void setAreaUnderRoc(double areaUnderRoc) {
        this.areaUnderRoc = areaUnderRoc;
    }
    
    
}
