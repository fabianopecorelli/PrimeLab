/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.unisa.gitdm.bean.metrics.scattering;

import it.unisa.gitdm.bean.Developer;
import it.unisa.gitdm.bean.FileBean;
import it.unisa.gitdm.bean.Metric;
import it.unisa.gitdm.bean.Period;
import it.unisa.gitdm.bean.ScatteringType;
import it.unisa.gitdm.metrics.parser.bean.ClassBean;
import it.unisa.gitdm.scattering.DeveloperFITreeManager;
import it.unisa.gitdm.scattering.DeveloperTreeManager;
import it.unisa.gitdm.scattering.ScatteringMetricsParser;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author giuse
 */
public class StructuralScattering extends Metric{

    public StructuralScattering() {
        super("structuralScattering");
    }

    @Override
    public double getValue(ClassBean cb, ArrayList<ClassBean> System, ScatteringMetricsParser structuralMP, ScatteringMetricsParser semanticalMP, FileBean file, Period p) {
        List<Developer> developersOnFile = DeveloperTreeManager.getDevelopersOnFile(file, p.getId());
        double structuralFileScattering = 0;
        for (Developer developer : developersOnFile) {
            double structuralScattering = structuralMP.getMetrics(developer.getEmail(), p.getId(),
                    ScatteringType.AVERAGE).getValue();

            structuralFileScattering += structuralScattering;
        }
        return structuralFileScattering;
    }

    
}
