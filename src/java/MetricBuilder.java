/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


import it.unisa.gitdm.bean.Metric;
import it.unisa.gitdm.bean.metrics.CKMetrics.CBO;
import it.unisa.gitdm.bean.metrics.CKMetrics.DIT;
import it.unisa.gitdm.bean.metrics.CKMetrics.LCOM;
import it.unisa.gitdm.bean.metrics.CKMetrics.LOC;
import it.unisa.gitdm.bean.metrics.CKMetrics.NOA;
import it.unisa.gitdm.bean.metrics.CKMetrics.NOC;
import it.unisa.gitdm.bean.metrics.CKMetrics.NOM;
import it.unisa.gitdm.bean.metrics.CKMetrics.NOO;
import it.unisa.gitdm.bean.metrics.process.NumberOfChanges;
import it.unisa.gitdm.bean.metrics.CKMetrics.RFC;
import it.unisa.gitdm.bean.metrics.CKMetrics.WMC;
import it.unisa.gitdm.bean.metrics.process.NumberOfCommittors;
import it.unisa.gitdm.bean.metrics.process.NumberOfFix;
import it.unisa.gitdm.bean.metrics.scattering.SemanticScattering;
import it.unisa.gitdm.bean.metrics.scattering.StructuralScattering;
import it.unisa.gitdm.bean.metrics.smellMetrics.ELOC;
import it.unisa.gitdm.bean.metrics.smellMetrics.NMNOPARAM;
import it.unisa.gitdm.bean.metrics.smellMetrics.NOPA;

/**
 *
 * @author giuse
 */
public class MetricBuilder {
    
    public static Metric MyMetric(String name) {
        Metric m = null;
        switch(name) {
                case "CBO":
                    m = new CBO();
                    break;
                case "DIT":
                    m = new DIT();
                    break;    
                case "WMC":
                    m = new WMC();
                    break;
                case "RFC":
                    m = new RFC();
                    break;
                case "NOC":
                    m = new NOC();
                    break;
                case "LCOM":
                    m = new LCOM();
                    break;
                case "NOA":
                    m = new NOA();
                    break;  
                case "LOC":
                    m = new LOC();
                    break;
                case "NOM":
                    m = new NOM();
                    break;
                case "NOO":
                    m = new NOO();
                    break;
                case "numberOfChanges":
                    m = new NumberOfChanges();
                    break;
                case "numberOfCommittors":
                    m = new NumberOfCommittors();
                    break;
                case "numberOfFix":
                    m = new NumberOfFix();
                    break;
                case "structuralScattering":
                    m = new StructuralScattering();
                    break;
                case "semanticScattering":
                    m = new SemanticScattering();
                    break;
                case "ELOC":
                    m = new ELOC();
                    break;
                case "NMNOPARAM":
                    m = new NMNOPARAM();
                    break;
                case "NOPA":
                    m = new NOPA();
                    break;
        }
        
        return m;
    }
    
}
