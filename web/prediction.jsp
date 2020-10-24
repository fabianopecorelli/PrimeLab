<%@page import="java.io.File"%>
<%@page import="it.unisa.gitdm.bean.MyClassifier"%>
<%@page import="it.unisa.gitdm.bean.Project"%>
<%@page import="it.unisa.primeLab.ProjectHandler"%>
<%@page import="it.unisa.gitdm.bean.EvaluationPredictors"%>
<%@page import="java.util.ArrayList"%>
<%@page import="weka.classifiers.trees.RandomForest"%>
<%@page import="weka.classifiers.bayes.NaiveBayes"%>
<%@page import="weka.classifiers.functions.MultilayerPerceptron"%>
<%@page import="weka.classifiers.functions.Logistic"%>
<%@page import="weka.classifiers.rules.DecisionTable"%>
<%@page import="weka.classifiers.Classifier"%>
<%@page import="it.unisa.gitdm.bean.Metric"%>
<%@page import="it.unisa.gitdm.bean.Model"%>
<% double ac = (Double) session.getAttribute("accuracy");%>
<% double pr = (Double) session.getAttribute("precision");%>
<% double re = (Double) session.getAttribute("recall");%>
<% double fm = (Double) session.getAttribute("fmeasure");%>
<% double aur = (Double) session.getAttribute("areaUnderROC");%>
<% Model model = (Model) session.getAttribute("modello");%>
<%String issueTracker = (String) session.getAttribute("issueTracker");%>
<% ArrayList<EvaluationPredictors> predictors = (ArrayList<EvaluationPredictors>) session.getAttribute("predictors");%>
<% Project project = ProjectHandler.getCurrentProject();%>
<%
    String metricOfModel = "";
    for (Metric m : model.getMetrics()) {
        metricOfModel += m.getNome() + " ";
    }

%>
<%    MyClassifier classifier = model.getClassifier();
%>
<jsp:include page="header.jsp" />
<!-- top navigation -->
<div class="top_nav">
    <div class="nav_menu">
        <nav>

            <!--            <ul class="nav navbar-nav navbar-right">
                            <li class="">
                                <label class="breadcrumb"><a href="#"> Pagina 1 </a> | <a href="#"> Pagina 2 </a> | Pagina 3 </label>
            
                            </li>
                        </ul>-->
        </nav>
    </div>
</div>
<!-- /top navigation -->
<!-- page content -->
<div class="right_col" role="main">
    <div class="">
        <div class="page-title">
        </div>

        <div class="clearfix"></div>


    </div>
    <!-- CONTENT -->
    <div class="row">

        <div class="col-md-12 col-sm-6 col-xs-12">
            <div class="x_panel">
                <div class="x_title">
                    <h2 id="tableTitle">Prediction Summary <small></small></h2>

                    <div class="clearfix"></div>
                </div>
                <div class="x_content">

                    <div class="" role="tabpanel" data-example-id="togglable-tabs">
                        <ul id="myTab1" class="nav nav-tabs bar_tabs right" role="tablist">
                            <li role="presentation" class=""><a href="#history" onclick="document.getElementById('tableTitle').innerHTML = 'History';" id="home-tabb" role="tab" data-toggle="tab" aria-controls="home" aria-expanded="true">History</a>
                            </li>
                            <li role="presentation" class=""><a href="#prediction" onclick="document.getElementById('tableTitle').innerHTML = 'Prediction';" role="tab" id="profile-tabb" data-toggle="tab" aria-controls="profile" aria-expanded="false">Prediction</a>
                            </li>
                            <li role="presentation" class="active"><a href="#summary" onclick="document.getElementById('tableTitle').innerHTML = 'Prediction Summary';" role="tab" id="profile-tabb3" data-toggle="tab" aria-controls="profile" aria-expanded="false">Summary</a>
                            </li>
                        </ul>
                        <div id="myTabContent2" class="tab-content">
                            <div role="tabpanel" class="tab-pane fade active in" id="summary" aria-labelledby="home-tab">
                                <div class="col-md-12 col-sm-6 col-xs-12">
                                    <div class="x_panel">
                                        <div class="x_title">
                                            <h2>Bar Chart Group <small>Sessions</small></h2>
                                            <ul class="nav navbar-right panel_toolbox">
                                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                                </li>
                                                <li class="dropdown">
                                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                                                    <ul class="dropdown-menu" role="menu">
                                                        <li><a href="#">Settings 1</a>
                                                        </li>
                                                        <li><a href="#">Settings 2</a>
                                                        </li>
                                                    </ul>
                                                </li>
                                                <li><a class="close-link"><i class="fa fa-close"></i></a>
                                                </li>
                                            </ul>
                                            <div class="clearfix"></div>
                                        </div>
                                        <div class="x_content2">
                                            <div id="graphx" style="width:100%; height:300px;"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12 col-sm-12 col-xs-12">
                                    <div class="x_panel">
                                        <div class="x_title">
                                            <h2>Prediction calculated using: <small>(change fields for new prediction)</small></h2>
                                            <ul class="nav navbar-right panel_toolbox">
                                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                                </li>
                                            </ul>
                                            <div class="clearfix"></div>
                                        </div>
                                        <div class="x_content" style="display: block;">
                                            <br>
                                            <form id="demo-form2" data-parsley-validate="" class="form-horizontal form-label-left" novalidate="">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">Select metrics: <span class="required">*</span>
                                                    </label>
                                                    <div  class="col-md-6 col-sm-6 col-xs-12">
<!--                                                        <div class="col-md-3">
                                                            <div class="checkbox">
                                                                <label name="metric" class="">
                                                                    <input name="metrics" value="CK metrics" type="checkbox" required="required" class="flat" > CK metrics
                                                                </label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <div class="checkbox">
                                                                <label name="metric" class="">
                                                                    <input name="metrics" value="Process" type="checkbox" required="required" class="flat" > Process
                                                                </label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <div class="checkbox">
                                                                <label name="metric" class="">
                                                                    <input name="metrics" value="Scattering" type="checkbox" required="required" class="flat" > Scattering
                                                                </label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3">
                                                                                                                        <div class="checkbox">
                                                                                                                            <label name="metric" class="">
                                                                                                                                <input type="checkbox" required="required" class="flat"> Metrica 4
                                                                                                                            </label>
                                                                                                                        </div>
                                                        </div>-->
                                                                        
                                                        <!-- checkbox -->
                                                        <div class="col-md-3">
                                                            <label>CK Metrics</label>
                                                            <ul class="list-group list-group-flush">
                                                                <li class="list-group-item">
                                                                  <!-- Default checked -->
                                                                  <div class="custom-control custom-checkbox">
                                                                      <input type="checkbox" name="all" id="all_CKMetrics" value="CK Metrics" class="flat" onclick="selectAll()">
                                                                    <label class="" for="check1">All</label>
                                                                  </div>
                                                                </li>
                                                                <li class="list-group-item">
                                                                  <!-- Default checked -->
                                                                  <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" name="metrics" id="CKMetrics" value="WMC" required="required" class="flat" <% if(metricOfModel.contains("WMC")) {
                                                                        out.print(" checked='checked'");
                                                                    }%>>
                                                                    <label class="custom-control-label" for="check2">WMC</label>
                                                                  </div>
                                                                </li>
                                                                <li class="list-group-item">
                                                                  <!-- Default checked -->
                                                                  <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" name="metrics" id="CKMetrics" value="DIT" required="required" class="flat" <% if(metricOfModel.contains("DIT")) {
                                                                        out.print(" checked='checked'");
                                                                    }%>>
                                                                    <label class="custom-control-label" for="check3">DIT</label>
                                                                  </div>
                                                                </li>
                                                                <li class="list-group-item">
                                                                  <!-- Default checked -->
                                                                  <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" name="metrics" id="CKMetrics" value="RFC" required="required" class="flat" <% if(metricOfModel.contains("RFC")) {
                                                                        out.print(" checked='checked'");
                                                                    }%>>
                                                                    <label class="custom-control-label" for="check4">RFC</label>
                                                                  </div>
                                                                </li>
                                                                <li class="list-group-item">
                                                                  <!-- Default checked -->
                                                                  <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" name="metrics" id="CKMetrics" value="NOC" required="required" class="flat" <% if(metricOfModel.contains("NOC")) {
                                                                        out.print(" checked='checked'");
                                                                    }%>>
                                                                    <label class="custom-control-label" for="check5">NOC</label>
                                                                  </div>
                                                                </li>
                                                                <li class="list-group-item">
                                                                  <!-- Default checked -->
                                                                  <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" name="metrics" id="CKMetrics" value="CBO" required="required" class="flat" <% if(metricOfModel.contains("CBO")) {
                                                                        out.print(" checked='checked'");
                                                                    }%>>
                                                                    <label class="custom-control-label" for="check5">CBO</label>
                                                                  </div>
                                                                </li>
                                                                <li class="list-group-item">
                                                                  <!-- Default checked -->
                                                                  <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" name="metrics" id="CKMetrics" value="LCOM" required="required" class="flat" <% if(metricOfModel.contains("LCOM")) {
                                                                        out.print(" checked='checked'");
                                                                    }%>>
                                                                    <label class="custom-control-label" for="check5">LCOM</label>
                                                                  </div>
                                                                </li>
                                                                <li class="list-group-item">
                                                                  <!-- Default checked -->
                                                                  <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" name="metrics" id="CKMetrics" value="NOA" required="required" class="flat" <% if(metricOfModel.contains("NOA")) {
                                                                        out.print(" checked='checked'");
                                                                    }%>>
                                                                    <label class="custom-control-label" for="check5">NOA</label>
                                                                  </div>
                                                                </li>
                                                                <li class="list-group-item">
                                                                  <!-- Default checked -->
                                                                  <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" name="metrics" id="CKMetrics" value="LOC" required="required" class="flat" <% if(metricOfModel.contains("LOC")) {
                                                                        out.print(" checked='checked'");
                                                                    }%>>
                                                                    <label class="custom-control-label" for="check5">LOC</label>
                                                                  </div>
                                                                </li>
                                                                <li class="list-group-item">
                                                                  <!-- Default checked -->
                                                                  <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" name="metrics" id="CKMetrics" value="NOM" required="required" class="flat" <% if(metricOfModel.contains("NOM")) {
                                                                        out.print(" checked='checked'");
                                                                    }%>>
                                                                    <label class="custom-control-label" for="check5">NOM</label>
                                                                  </div>
                                                                </li>
                                                                <li class="list-group-item">
                                                                  <!-- Default checked -->
                                                                  <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" name="metrics" id="CKMetrics" value="NOO" required="required" class="flat" <% if(metricOfModel.contains("NOO")) {
                                                                        out.print(" checked='checked'");
                                                                    }%>>
                                                                    <label class="custom-control-label" for="check5">NOO</label>
                                                                  </div>
                                                                </li>
                                                              </ul>
                                                        </div>
                                                        <div class="col-md-5">
                                                            <label>Process</label>
                                                            <ul class="list-group list-group-flush">
                                                                <li class="list-group-item">
                                                                  <!-- Default checked -->
                                                                  <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" name="all" id="all_metrics" value="CK Metrics" class="flat">
                                                                    <label class="custom-control-label" for="check1">All</label>
                                                                  </div>
                                                                </li>
                                                                <li class="list-group-item">
                                                                  <!-- Default checked -->
                                                                  <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" name="metrics" value="numberOfChanges" required="required" class="flat" <% if(metricOfModel.contains("numberOfChanges")) {
                                                                        out.print(" checked='checked'");
                                                                    }%>>
                                                                    <label class="custom-control-label" for="check2">Number of Changes</label>
                                                                  </div>
                                                                </li>
                                                                <li class="list-group-item">
                                                                  <!-- Default checked -->
                                                                  <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" name="metrics" value="numberOfCommittors" required="required" class="flat" <% if(metricOfModel.contains("numberOfCommittors")) {
                                                                        out.print(" checked='checked'");
                                                                    }%>>
                                                                    <label class="custom-control-label" for="check4">Number of Committors</label>
                                                                  </div>
                                                                </li>
                                                                <li class="list-group-item">
                                                                  <!-- Default checked -->
                                                                  <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" name="metrics" value="numberOfFix" required="required" class="flat" <% if(metricOfModel.contains("numberOfFix")) {
                                                                        out.print(" checked='checked'");
                                                                    }%>>
                                                                    <label class="custom-control-label" for="check4">Number of Fix</label>
                                                                  </div>
                                                                </li>
                                                              </ul>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label>Scattering</label>
                                                            <ul class="list-group list-group-flush">
                                                                <li class="list-group-item">
                                                                  <!-- Default checked -->
                                                                  <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" name="all" id="all_metrics" value="CK Metrics" class="flat">
                                                                    <label class="custom-control-label" for="check1">All</label>
                                                                  </div>
                                                                </li>
                                                                <li class="list-group-item">
                                                                  <!-- Default checked -->
                                                                  <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" name="metrics" value="structuralScattering" required="required" class="flat" <% if(metricOfModel.contains("structuralScattering")) {
                                                                        out.print(" checked='checked'");
                                                                    }%>>
                                                                    <label class="custom-control-label" for="check1">Structural Scattering</label>
                                                                  </div>
                                                                </li>
                                                                <li class="list-group-item">
                                                                  <!-- Default checked -->
                                                                  <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" name="metrics" value="semanticScattering" required="required" class="flat" <% if(metricOfModel.contains("semanticScattering")) {
                                                                        out.print(" checked='checked'");
                                                                    }%>>
                                                                    <label class="custom-control-label" for="check2">Semantic Scattering</label>
                                                                  </div>
                                                                </li>
                                                              </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="ln_solid"></div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">Classifier *</label>
                                                    <div class="col-md-3 col-sm-6 col-xs-12">
                                                        <select id="heard" class="form-control" required="">
                                                            <option value="">Choose...</option>
                                                            <option value="Decision Table Majority" <% if (classifier.getClassifier().getClass() == DecisionTable.class) out.print("selected=''");%>>Decision Table Majority</option>
                                                            <option value="Logistic Regression"<% if (classifier.getClassifier().getClass() == Logistic.class) out.print("selected=''");%>>Logistic Regression</option>
                                                            <option value="Multi Layer Perceptron"<% if (classifier.getClassifier().getClass() == MultilayerPerceptron.class) out.print("selected=''");%>>Multi Layer Perceptron</option>
                                                            <option value="Naive Baesian"<% if (classifier.getClassifier().getClass() == NaiveBayes.class) out.print("selected=''");%>>Naive Baesian</option>
                                                            <option value="Random Forest"<% if (classifier.getClassifier().getClass() == RandomForest.class) out.print("selected=''");%>>Random Forest</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-md-3 col-sm-6 col-xs-12 col-md-offset-3">
                                                        <button type="button" class="btn btn-success" id="newPred" style="visibility: hidden;">New predicton</button>
                                                    </div>
                                                        <!--Modal -->
                                                        <div id="myModal" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
                                                            <div class="modal-dialog modal-lg">
                                                                <div class="modal-content">

                                                                    <div class="modal-header">
                                                                        <button type="button" onclick="onModalClose()" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
                                                                        </button>
                                                                        <h4 class="modal-title" id="myModalLabel">Comfirm your data</h4>
                                                                    </div>
                                                                    <div class="modal-body">

                                                                        <div class="row">
                                                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Github link: </label>
                                                                            <label class="control-label col-md-6 col-sm-6 col-xs-12" id="githubConf">link</label>
                                                                        </div>

                                                                        <div class="ln_solid"></div>
                                                                        <div class="row">
                                                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Issue Tracker: </label>
                                                                            <label class="control-label col-md-6 col-sm-6 col-xs-12" id="issueTrackerConf">issue tracker name</label>
                                                                        </div>
                                                                        
                                                                        <div class="ln_solid"></div>
                                                                        <div class="row">
                                                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Issue tracker URL: </label>
                                                                            <label class="control-label col-md-6 col-sm-6 col-xs-12" id="issueTrackerURLConf">issue tracker name</label>
                                                                        </div>

                                                                        <div class="ln_solid"></div>
                                                                        <div class="row">
                                                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Metrics:</label>
                                                                            <label class="control-label col-md-6 col-sm-6 col-xs-12" id="metricsConf">CK Metricks, Scattering</label>
                                                                        </div>

                                                                        <div class="ln_solid"></div>
                                                                        <div class="row">
                                                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Classifier:</label>
                                                                            <label class="control-label col-md-6 col-sm-6 col-xs-12" id="classifierConf">j48</label>
                                                                        </div>
                                                                        <div class="ln_solid"></div>
                                                                        <div class="ln_solid"></div>

                                                                        <div class="row">
                                                                            <label class="control-label col-md-12 col-sm-3 col-xs-12">Please enter your e-mail address to be alerted when the results will be available: </label>
                                                                        </div>
                                                                        <br>
                                                                        <div class="row">
                                                                            <div class = "col-md-6 col-sm-3 col-xs-12"></div>
                                                                            <div class = "col-md-6 col-sm-3 col-xs-12" id="bottomModal">

                                                                            </div>
                                                                        </div>

                                                                    </div>

                                                                    <div class="modal-footer">
                                                                        <button type="button" class="btn btn-default" onclick="onModalClose()" data-dismiss="modal">Close</button>
                                                                        <button id="btn_confirm" type="submit" class="btn btn-success"  data-dismiss="modal">Confirm</button>
                                                                    </div>
                                                                </div>

                                                            </div>
                                                        </div>
                                                        <!--Modal -->
                                                </div>

                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div role="tabpanel" class="tab-pane fade" id="prediction" aria-labelledby="profile-tab">
                                <div class="x_panel">
                                    <div class="x_title">
                                        <ul class="nav navbar-right panel_toolbox">
                                            <!-- <a out.print("href=\"C:/ProgettoTirocinio/projects/" + project.getName() + "/models/" + model.getName() + "/predictors.csv\"");%>"> -->
                                            
                                            <li><a class="btn btn-outline-dark btn-lg" href="download.jsp" download>CSV</a></li>
                                        </ul>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="x_content col-md-12">
                                        <table id="datatable" class="table table-striped table-bordered dataTable">

                                            <thead>
                                                <tr>
<!--                                                    <th>Name</th>
                                                    <th>LOC</th>
                                                    <th>CBO</th>                                            
                                                    <th>LCOM</th>                                         
                                                    <th>NOM</th>
                                                    <th>RFC</th>
                                                    <th>WMC</th>
                                                    <th>changes</th>
                                                    <th>FIChanges</th>
                                                    <th>structuralScatteringSum</th>
                                                    <th>semanticScatteringSum</th>
                                                    <th>developers</th>
                                                    <th>Predicted</th>-->
                                                    <% 
                                                        ArrayList<String> list = predictors.get(0).getMetrics();
                                                        for (String metric : list) {
                                                            out.print("<th>" + metric + "</th>");
                                                        }
                                                    
                                                    %>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                //AGGIUNGERE ACTUAL IN PREDICTORS.CSV (AL MOMENTO STAMPO SEMPRE TRUE)
                                                    for (int i = 1; i < predictors.size(); i++){
                                                        /*out.print("<tr><td>"+p.getClassPath()+"</td><td>"+p.getLOC()+"</td><td>"+p.getCBO()+"</td>"
                                                                + "<td>"+p.getLCOM()+"</td><td>"+p.getNOM()+"</td><td>"+p.getRFC()+"</td>"
                                                                + "<td>"+p.getWMC()+"</td><td>"+p.getNumOfChanges()+"</td><td>"+p.getNumberOfFIChanges()+"</td>"
                                                                + "<td>"+p.getStructuralScatteringSum()+"</td><td>"+p.getSemanticScatteringSum()+"</td>"
                                                                + "<td>"+p.getNumberOfDeveloper()+"</td><td>"+p.isIsBuggy()+"</td></tr>");*/
                                                        ArrayList<String> lista = predictors.get(i).getMetrics();
                                                        out.print("<tr>");
                                                        for (String metric : lista) {
                                                            out.print("<td>" + metric + "</td>");
                                                        }
                                                        out.print("</tr>");
                                                    }
                                                %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div role="tabpanel" class="tab-pane fade" id="history" aria-labelledby="profile-tab">
                                <div class="table-responsive">
                                    <form action="http://localhost:8080/PrimeLabServer/CompareServlet" method="POST" >
                                        <table class="table table-striped jambo_table bulk_action">
                                            <thead>
                                                <tr class="headings">
                                                    <th>
                                                        <input type="checkbox" id="check-all" class="flat">
                                                    </th>
                                                    <th class="column-title">Predictions </th>
                                                    <th>Metrics</th>
                                                    <th>Classifier</th>
                                                    <th class="column-title">Date </th>
                                                    </th>
                                                    <th class="bulk-actions" colspan="7">
                                                        <a class="antoo" style="color:#fff; font-weight:500;"><button type="submit" class="btn btn-primary">Compare</button> ( <span class="action-cnt"> </span> ) <i class="fa fa-chevron-down"></i></a>
                                                    </th>
                                                </tr>
                                            </thead>

                                            <tbody>
                                                <%
                                                    int i = 1;
                                                    for (Model m : project.getModels()){
                                                        if (i % 2 != 0) {
                                                            out.print("<tr class='even pointer'>");
                                                        } else {
                                                            out.print("<tr class='odd pointer'>");
                                                        }
                                                        String metrics = m.getMetrics().toString();
                                                        metrics = metrics.substring(1, metrics.length()-1);
                                                        String classif = m.getClassifier().toString();
                                                        out.print("<td class='a-center'>"
                                                                + "<input type='checkbox' class='flat' name='table_records' value='"+m.getName()+"'>"
                                                                + "</td>"
                                                                + "<td>Run " + i + "</td>"
                                                                + "<td>" + metrics + "</td>"
                                                                + "<td>" + classif + "</td>"
                                                                + "<td>" + m.getDate() + "</td>"
                                                                + "</tr>");
                                                        i++;
                                                    }
                                                    %>


                                            </tbody>
                                        </table>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <!-- /CONTENT -->
</div>

<div class="alert alert-success" id="success-alert" style="display:none">
</div>
<!-- /page content -->

<!-- footer content -->
<jsp:include page="footer.jsp" />

<!-- iCheck -->
<script src="scripts/icheck.js"></script>
<script src="scripts/parsleyjs/dist/parsley.js"></script>

<script src="scripts/raphael.js"></script>
<script src="scripts/morris.js"></script>
<script src="scripts/datatables.net/js/jquery.dataTables.min.js"></script>

<script src="scripts/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
<script>
    var isModalOnFocus = false;
    function mySubmit() {
           createModal();
    }
    function createModal(){
        document.getElementById("githubConf").innerHTML ="<%out.print("" + project.getGitURL() + "");%>";
        var issueTracker = "<%out.print("" + issueTracker + "");%>";
        var nameIssueTracker = issueTracker.split("/");
        document.getElementById("issueTrackerConf").innerHTML = nameIssueTracker[nameIssueTracker.length - 2];
        document.getElementById("issueTrackerURLConf").innerHTML = issueTracker;
        var metrics = document.getElementById("metricsConf");
        metrics.innerHTML='';
        $('input[name="metrics"]').each(function () {
            metrics.innerHTML += (this.checked ? $(this).val()+"; " : "");
       });
        document.getElementById("classifierConf").innerHTML = $('#heard').val();
        document.getElementById("bottomModal").innerHTML = '<input type = "email" id = "email"  required="required" class = "form-control" >';
        $('#myModal').modal();
    }
    function onModalClose(){
        document.getElementById("bottomModal").innerHTML = '';
    }
</script>

<script>
    $(document).ready(function () {
        var handleDataTableButtons = function () {
            if ($("#datatable-buttons").length) {
                $("#datatable-buttons").DataTable({
                    dom: "Bfrtip",
                    buttons: [
                        {
                            extend: "copy",
                            className: "btn-sm"
                        },
                        {
                            extend: "csv",
                            className: "btn-sm"
                        },
                        {
                            extend: "excel",
                            className: "btn-sm"
                        },
                        {
                            extend: "pdfHtml5",
                            className: "btn-sm"
                        },
                        {
                            extend: "print",
                            className: "btn-sm"
                        },
                    ],
                    responsive: true
                });
            }
        };

        TableManageButtons = function () {
            "use strict";
            return {
                init: function () {
                    handleDataTableButtons();
                }
            };
        }();

        $('#datatable').dataTable({
            'order': [[1, 'asc']],
            'columnDefs': [
                {orderable: false, targets: [2,3]}
            ],
            'iDisplayLength': 10,
        });

        $('#datatable-keytable').DataTable({
            keys: true
        });

        $('#datatable-responsive').DataTable();

        $('#datatable-scroller').DataTable({
            ajax: "js/datatables/json/scroller-demo.json",
            deferRender: true,
            scrollY: 380,
            scrollCollapse: true,
            scroller: true
        });

        $('#datatable-fixed-header').DataTable({
            fixedHeader: true
        });

        var $datatable = $('#datatable-checkbox');

        $datatable.dataTable({
            'order': [[1, 'asc']],
            'columnDefs': [
                {orderable: false, targets: [0]}
            ]
        });
        
        $datatable.on('draw.dt', function () {
            $('input').iCheck({
                checkboxClass: 'icheckbox_flat-green'
            });
        });

        TableManageButtons.init();
        //modal
        $('#newPred').on('click', function () {
            mySubmit();
        });
        //message
        $("#btn_confirm").on("click", function(){
            if ($("input#email").val() !== "") {
                var mex="We\'ll send you an a e-mail when the<br> evalutation will be completed";
                $("#success-alert").css("position","fixed");
                $("#success-alert").css("top","30px");
                $("#success-alert").css("right","30px");
                $("#success-alert").css("whidt","100px");
                $("#success-alert").css("display","block");
                $("#success-alert").html($("<strong>"+mex+"</strong>"));
                setTimeout(function() {
                        $("#success-alert").css("display","none");
                //$("#success-alert").alert('close');
            }, 2000);
            }
        });
    });
</script>
<!-- Parsley -->
<script>
                                var metrics = document.getElementsByName("metric");
                                for (var i = 0; i < metrics.length; i++)
                                    metrics[i].addEventListener("click", function () {
                                        document.getElementById("newPred").style.visibility = "visible";
                                    }, true);
                                $(document).ready(function () {
                                    $.listen('parsley:field:validate', function () {
                                        validateFront();
                                    });
                                    $('#demo-form2 .btn-success').on('click', function () {
                                        $('#demo-form2').parsley().validate();
                                        validateFront();
                                    });
                                    var validateFront = function () {
                                        if (true === $('#demo-form2').parsley().isValid()) {
                                            $('.bs-callout-info').removeClass('hidden');
                                            $('.bs-callout-warning').addClass('hidden');
                                        } else {
                                            $('.bs-callout-info').addClass('hidden');
                                            $('.bs-callout-warning').removeClass('hidden');
                                        }
                                    };
                                    $('#heard').on('change', function () {
                                        document.getElementById("newPred").style.visibility = "visible";
                                    });
                                });
                                try {
                                    hljs.initHighlightingOnLoad();
                                } catch (err) {
                                }
                                $(document).ready(function () {
                                    var model1 = "<%out.print(metricOfModel + " - " + classifier.getName()); %>";
                                    var accuracy = "<%= ac%>";
                                    var precision = "<%= pr%>";
                                    var recall = "<%= re%>";
                                    var fmeasure = "<%= fm%>";
                                    var areaUnderROC = "<%= aur%>";
                                    Morris.Bar({
                                        element: 'graphx',
                                        data: [
                                            {x: 'Accuracy', y: accuracy},
                                            {x: 'Precision', y: precision},
                                            {x: 'Recall', y: recall},
                                            {x: 'Fmeasure', y: fmeasure},
                                            {x: 'AreaUnderROC', y: areaUnderROC}
                                        ],
                                        xkey: 'x',
                                        ykeys: ['y'],
                                        barColors: ['#26B99A', '#34495E', '#ACADAC', '#3498DB'],
                                        hideHover: 'auto',
                                        labels: [[model1]],
                                        resize: true,
                                    }).on('click', function (i, row) {
                                        console.log(i, row);
                                    });
                                })
</script>
<!-- /Parsley -->
