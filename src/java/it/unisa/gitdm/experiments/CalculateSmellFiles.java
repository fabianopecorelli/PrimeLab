/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.unisa.gitdm.experiments;

import it.unisa.gitdm.bean.FileBean;
import static it.unisa.primeLab.Config.scatteringFolderPath;
import java.io.BufferedReader;
import java.io.EOFException;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 *
 * @author giuse
 */
public class CalculateSmellFiles {
    
    private final List<FileBean> smellFiles;
    
    public CalculateSmellFiles(String projectName, String smell, String version) {
        System.out.println("Start CalculateSmellFile");
        Pattern p = Pattern.compile("(\\d+\\.)?(\\d+\\.)?(\\*|\\d+)$");
        Matcher m = p.matcher(version);
        m.find();
        System.out.println(m.group());
        version = m.group();
        smell = smell.replace(" ", "_");
        String path = buildPath(projectName, version);
        System.out.println("smell: " + smell);
        File smellFile = new File(scatteringFolderPath + File.separator + projectName + File.separator + "smellFiles.data");
        smellFiles = new ArrayList<FileBean>();
        this.init(path, smellFile, smell);
        
    }
    
    public List<FileBean> getSmellClasses() {
        return this.smellFiles;
    }
    
    private void init(String path, File smellFile, String smell) {
        try (Stream<Path> walk = Files.walk(Paths.get(path))) {

            List<String> result = walk.filter(Files::isRegularFile)
                    .map(x -> x.toString()).filter(f -> f.endsWith(".csv")).collect(Collectors.toList());
            
            this.saveSmellFile(extractFilesPath(result, path, smell), smellFile);
            //System.out.println(smellFiles.get(0).getPath());
            
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    private List<FileBean> extractFilesPath(List<String> filesPath, String basePath, String smell) {
//        List<String> myProblems = new ArrayList<String>();
//        myProblems.add("Large_Class");
//        myProblems.add("Complex_Class");
//        myProblems.add("Spaghetti_Code");
//        myProblems.add("Class_Data_Should_Be_Private");
        List<FileBean> listPath = new ArrayList<FileBean>();
        for(String s : filesPath) {
            if(s.contains(smell)) {
                //myProblems.remove(problem);
                listPath.add(new FileBean(s));
                break;
            }
        }
        return listPath;
    }
    
    private void saveSmellFile(List<FileBean> listPath, File smellFile) {
        
        BufferedReader br = null;
        String line = "";
        String cvsSplitBy = "; ";
        for(FileBean filePath : listPath) {
            try {
                br = new BufferedReader(new FileReader(filePath.getPath()));
                
                while ((line = br.readLine()) != null) {
                    String[] classe = line.split(cvsSplitBy);
                    classe[1] = classe[1].replace(".", "/");
                    classe[1] = classe[1].replace(";", "");
                    classe[1] = classe[1].replace(" ", "");
                    FileBean f = new FileBean(classe[1] + "/" + classe[0]);
                    
                    if(!smellFiles.contains(f)) {
                        smellFiles.add(f);
                        System.out.println(f.getPath());
                    }
                    //System.out.println(classe[1]);
                }
                br.close();
            } catch (FileNotFoundException ex) {
                Logger.getLogger(CalculateSmellFiles.class.getName()).log(Level.SEVERE, null, ex);
            } catch (IOException ex) {
                Logger.getLogger(CalculateSmellFiles.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
        //save in smellFile
        try (FileOutputStream fileOut = new FileOutputStream(smellFile); ObjectOutputStream out = new ObjectOutputStream(fileOut)) {
            for (FileBean f : smellFiles) {
                out.writeObject(f);
            }
            out.flush();
            out.close();
            fileOut.close();
        } catch (FileNotFoundException ex) {
            Logger.getLogger(CalculateSmellFiles.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(CalculateSmellFiles.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private void loadSmellClasses(File smellFile) {
        try (FileInputStream fileIn = new FileInputStream(smellFile); ObjectInputStream in = new ObjectInputStream(fileIn)) {
            FileBean sc ; 
            try{
                while((sc = (FileBean) in.readObject()) != null) {
                    smellFiles.add(sc);
                }
            } catch(EOFException ex){
                
            }
            
            in.close();
            fileIn.close();
        } catch (FileNotFoundException ex) {
            Logger.getLogger(CalculateSmellFiles.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(CalculateSmellFiles.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CalculateSmellFiles.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private String buildPath(String projectName, String version) {
        String baseSmellPatch = "C:/ProgettoTirocinio/dataset/";
        //apache-ant-data/apache_1.8.3/Validated
        
        try (Stream<Path> walk = Files.walk(Paths.get(baseSmellPatch), 1)) {

            List<String> result = walk.filter(Files::isDirectory)
                    .map(x -> x.toString()).collect(Collectors.toList());
            
            //prima cartella dopo dataset
            for(String path : result) {
                if(path.contains(projectName)) {
                    baseSmellPatch = path + File.separator;
                    break;
                }
            }
            
            try(Stream<Path> walk1 = Files.walk(Paths.get(baseSmellPatch), 1)) {
                result = walk1.filter(Files::isDirectory)
                    .map(x -> x.toString()).collect(Collectors.toList());
            } catch (IOException e) {
                e.printStackTrace();
            }
            //cartella con la versione giusta
            for(String path : result) {
                if(path.contains(version)) {
                    baseSmellPatch = path + File.separator;
                    break;
                }
            }
            
            System.out.println(baseSmellPatch + "Validated");
            
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        return baseSmellPatch + "Validated";
    }
    
}
