/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.unisa.gitdm.bean.metrics.CKMetrics;

import it.unisa.gitdm.bean.FileBean;
import it.unisa.gitdm.bean.Metric;
import it.unisa.gitdm.bean.Period;
import it.unisa.gitdm.metrics.CKMetrics;
import it.unisa.gitdm.metrics.parser.bean.ClassBean;
import it.unisa.gitdm.scattering.ScatteringMetricsParser;
import java.util.ArrayList;

/**
 *
 * @author giuse
 */
public class NOA extends Metric {

    public NOA() {
        super("NOA");
    }

    @Override
    public double getValue(ClassBean cb, ArrayList<ClassBean> System, ScatteringMetricsParser structuralMP, ScatteringMetricsParser semanticalMP, FileBean file, Period p) {
        return CKMetrics.getNOA(cb, System);
    }

    
}
