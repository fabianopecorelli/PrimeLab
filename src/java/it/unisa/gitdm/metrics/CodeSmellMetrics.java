/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.unisa.gitdm.metrics;

import it.unisa.gitdm.metrics.parser.bean.ClassBean;
import it.unisa.gitdm.metrics.parser.bean.InstanceVariableBean;
import it.unisa.gitdm.metrics.parser.bean.MethodBean;
import java.io.File;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.regex.Pattern;

/**
 *
 * @author giuse
 */
public class CodeSmellMetrics {
    
    //Effective Lines Of Code
    public static int getELOC(ClassBean cb) {
        //count = cb.getTextContent().codePoints().filter(ch -> ch = '\n').count();
        return getNumberOfLinesCode(cb.getTextContent());
    }
    
    //!
    //Lines Of Code of METHOD
    public static int getLOC_METHOD(ClassBean cb) {
        int count = 0;
        Collection<MethodBean> methods = cb.getMethods();
        for(MethodBean m : methods) {
            count += getNumberOfLinesCode(m.getTextContent());
        }
        return count;
    }
    
    //Number Of Public Attributes
    public static int getNOPA(ClassBean cb) {
        int count = 0;
        Collection<InstanceVariableBean> variables = cb.getInstanceVariables();
        for(InstanceVariableBean iv : variables) {
            if(iv.getVisibility().equals("public")) {
                count++;
            }
        }
        return count;
    }
    
    //!
    //Number of Parameters
    public static int getNP(ClassBean cb) {
        int count = 0;
        Collection<MethodBean> methods = cb.getMethods();
        for(MethodBean m : methods) {
            count += m.getUsedInstanceVariables().size();
        }
        return count;
    }
    
    //Number of Methods with NO PARAMeters
    public static int getNMNOPARAM(ClassBean cb) {
        int count = 0;
        Collection<MethodBean> methods = cb.getMethods();
        for(MethodBean m : methods) {
            if(m.getUsedInstanceVariables().isEmpty()) {
                count++;
            }
        }
        return count;
    }
    
    private static int getNumberOfLinesCode(String code) {
        String[] lines = code.split("\n");
        int count = 0;
        int comments = 0;
        int j = 0;
        Pattern pattern1 = Pattern.compile("(\\s)(\\s+)[{]");
        Pattern pattern2 = Pattern.compile("(\\s*)[}]");
        Pattern pattern3 = Pattern.compile("(\\s+)//");
        Pattern pattern4 = Pattern.compile("\\/\\*[^/*]*(?:(?!\\/\\*|\\*\\/)[/*][^/*]*)*\\*\\/");
        
        //\/\*[^/*]*(?:(?!\/\*|\*\/)[/*][^/*]*)*\*\/
        //  (/\*+)|(\*/)|(\*[^\;])|(//)
        for(int i = 0; i < lines.length; i++) {
            if(!Pattern.matches(pattern1.pattern(), lines[i]) && !Pattern.matches(pattern2.pattern(), lines[i]) && !Pattern.matches(pattern3.pattern(), lines[i])) {
                count++;
            }
            if(lines[i].contains("/*")) {
                j  = i - 1;
            }
            if(lines[i].contains("*/")) {
                comments = comments + i - j;
            }
//            if(!lines[i].contains("//") && lines[i].charAt(0) != '{' && lines[i].charAt(0) != '}') {
//                count++;
//            }
        }
        return count - comments;
    }
}
