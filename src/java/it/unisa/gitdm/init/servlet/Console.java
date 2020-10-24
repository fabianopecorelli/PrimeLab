/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.unisa.gitdm.init.servlet;

import it.unisa.gitdm.bean.Model;
import it.unisa.gitdm.bean.Project;
import it.unisa.primeLab.Config;
import it.unisa.primeLab.ProjectHandler;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;

/**
 *
 * @author giuse
 */
public class Console {
    public static void main(String[] args) throws FileNotFoundException, IOException {
        //deleteModel("antModel8");
        updateModelName("antModel9", "antModel8");
        
    }
    
    private static void deleteModel(String modelName) throws FileNotFoundException, IOException {
        
        ArrayList<Project> projects;
        projects = ProjectHandler.getAllProjects();
        for(Project p : projects) {
            ArrayList<Model> models = p.getModels();
            for(Model m : models) {
                if(m.getName().equals(modelName)) {
                    models.remove(m);
                }
            }
        }
        
        Files.delete(Paths.get(Config.baseDir + "projects.txt"));
        File f = new File(Config.baseDir + "projects.txt");
        FileOutputStream fileOut;

        fileOut = new FileOutputStream(f);
        ObjectOutputStream out = new ObjectOutputStream(fileOut);
        out.writeObject(projects);
        out.flush();
        out.close();
        fileOut.close();
    }
    
        private static void updateModelName(String modelName, String newModelName) throws FileNotFoundException, IOException {
        
        ArrayList<Project> projects;
        projects = ProjectHandler.getAllProjects();
        for(Project p : projects) {
            ArrayList<Model> models = p.getModels();
            for(Model m : models) {
                if(m.getName().equals(modelName)) {
                    m.setName(newModelName);
                }
            }
        }
        
        Files.delete(Paths.get(Config.baseDir + "projects.txt"));
        File f = new File(Config.baseDir + "projects.txt");
        FileOutputStream fileOut;

        fileOut = new FileOutputStream(f);
        ObjectOutputStream out = new ObjectOutputStream(fileOut);
        out.writeObject(projects);
        out.flush();
        out.close();
        fileOut.close();
    }
}
