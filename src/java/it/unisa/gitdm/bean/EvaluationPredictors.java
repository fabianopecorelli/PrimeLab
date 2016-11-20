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
public class EvaluationPredictors implements Serializable{

    private String classPath;
    private double LOC;
    private double CBO;
    private double LCOM;
    private double NOM;
    private double RFC;
    private double WMC;
    private double numOfChanges;
    private double numberOfFIChanges;
    private double structuralScatteringSum;
    private double semanticScatteringSum;
    private double numberOfDeveloper;
    private String isBuggy;

    public EvaluationPredictors(String classPath, double LOC, double CBO, double LCOM, double NOM, double RFC, double WMC, double numOfChanges, double numberOfFIChanges, double structuralScatteringSum, double semanticScatteringSum, double numberOfDeveloper, String isBuggy) {
        this.classPath = classPath;
        this.LOC = LOC;
        this.CBO = CBO;
        this.LCOM = LCOM;
        this.NOM = NOM;
        this.RFC = RFC;
        this.WMC = WMC;
        this.numOfChanges = numOfChanges;
        this.numberOfFIChanges = numberOfFIChanges;
        this.structuralScatteringSum = structuralScatteringSum;
        this.semanticScatteringSum = semanticScatteringSum;
        this.numberOfDeveloper = numberOfDeveloper;
        this.isBuggy = isBuggy;
    }

    public String getClassPath() {
        return classPath;
    }

    public void setClassPath(String classPath) {
        this.classPath = classPath;
    }

    public double getLOC() {
        return LOC;
    }

    public void setLOC(double LOC) {
        this.LOC = LOC;
    }

    public double getCBO() {
        return CBO;
    }

    public void setCBO(double CBO) {
        this.CBO = CBO;
    }

    public double getLCOM() {
        return LCOM;
    }

    public void setLCOM(double LCOM) {
        this.LCOM = LCOM;
    }

    public double getNOM() {
        return NOM;
    }

    public void setNOM(double NOM) {
        this.NOM = NOM;
    }

    public double getRFC() {
        return RFC;
    }

    public void setRFC(double RFC) {
        this.RFC = RFC;
    }

    public double getWMC() {
        return WMC;
    }

    public void setWMC(double WMC) {
        this.WMC = WMC;
    }

    public double getNumOfChanges() {
        return numOfChanges;
    }

    public void setNumOfChanges(double numOfChanges) {
        this.numOfChanges = numOfChanges;
    }

    public double getNumberOfFIChanges() {
        return numberOfFIChanges;
    }

    public void setNumberOfFIChanges(double numberOfFIChanges) {
        this.numberOfFIChanges = numberOfFIChanges;
    }

    public double getStructuralScatteringSum() {
        return structuralScatteringSum;
    }

    public void setStructuralScatteringSum(double structuralScatteringSum) {
        this.structuralScatteringSum = structuralScatteringSum;
    }

    public double getSemanticScatteringSum() {
        return semanticScatteringSum;
    }

    public void setSemanticScatteringSum(double semanticScatteringSum) {
        this.semanticScatteringSum = semanticScatteringSum;
    }

    public double getNumberOfDeveloper() {
        return numberOfDeveloper;
    }

    public void setNumberOfDeveloper(double numberOfDeveloper) {
        this.numberOfDeveloper = numberOfDeveloper;
    }

    public String isIsBuggy() {
        return isBuggy;
    }

    public void setIsBuggy(String isBuggy) {
        this.isBuggy = isBuggy;
    }
    
    

}
