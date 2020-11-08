/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.unisa.gitdm.bean.metrics.smellMetrics;

import it.unisa.gitdm.bean.FileBean;
import it.unisa.gitdm.bean.Metric;
import it.unisa.gitdm.bean.Period;
import it.unisa.gitdm.metrics.CodeSmellMetrics;
import it.unisa.gitdm.metrics.parser.bean.ClassBean;
import it.unisa.gitdm.scattering.ScatteringMetricsParser;
import java.util.ArrayList;

/**
 *
 * @author giuse
 */
public class LOC_METHOD extends Metric {

    public LOC_METHOD() {
        super("LOC_METHOD");
    }

    @Override
    public double getValue(ClassBean cb, ArrayList<ClassBean> System, ScatteringMetricsParser structuralMP, ScatteringMetricsParser semanticalMP, FileBean file, Period p) {
        return CodeSmellMetrics.getLOC_METHOD(cb);
    }
    
}
