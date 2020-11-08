<%-- 
    Document   : bugPrediction
    Created on : 3-nov-2020, 8.59.48
    Author     : giuse
--%>

<%@page import="it.unisa.gitdm.bean.Project"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="it.unisa.gitdm.bean.Metric"%>
<%@page import="it.unisa.gitdm.bean.Model"%>
<% Model model = (Model) session.getAttribute("modello");%>
<%
    String metricOfModel = "";
    for (Metric m : model.getMetrics()) {
        metricOfModel += m.getNome() + " ";
    }

%>
<div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">Issue Tracker
                            </label>
                            <div  class="col-md-6 col-sm-6 col-xs-12">
                                <div class="col-md-3"></div>
                                <div class="col-md-4">
                                    Bugzilla
                                    <input type="radio" name="issueTracker" class="flat" value="https://issues.apache.org/bugzilla/" checked="" required />
                                </div>

                                <div class="col-md-3">
                                    Jira
                                    <input type="radio" class="flat" name="issueTracker" value="https://issues.apache.org/jira/" />
                                </div>
                            </div>
                        </div>
                                                        <div class="ln_solid"></div>
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
                                                        <div class="col-md-4">
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
                                                                    <input type="checkbox" name="metrics" id="CKMetrics" value="WMC" required="required" class="flat metrics" <% if(metricOfModel.contains("WMC")) {
                                                                        out.print(" checked='checked'");
                                                                    }%>>
                                                                    <label class="custom-control-label" for="check2">WMC</label>
                                                                  </div>
                                                                </li>
                                                                <li class="list-group-item">
                                                                  <!-- Default checked -->
                                                                  <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" name="metrics" id="CKMetrics" value="DIT" required="required" class="flat metrics" <% if(metricOfModel.contains("DIT")) {
                                                                        out.print(" checked='checked'");
                                                                    }%>>
                                                                    <label class="custom-control-label" for="check3">DIT</label>
                                                                  </div>
                                                                </li>
                                                                <li class="list-group-item">
                                                                  <!-- Default checked -->
                                                                  <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" name="metrics" id="CKMetrics" value="RFC" required="required" class="flat metrics" <% if(metricOfModel.contains("RFC")) {
                                                                        out.print(" checked='checked'");
                                                                    }%>>
                                                                    <label class="custom-control-label" for="check4">RFC</label>
                                                                  </div>
                                                                </li>
                                                                <li class="list-group-item">
                                                                  <!-- Default checked -->
                                                                  <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" name="metrics" id="CKMetrics" value="NOC" required="required" class="flat metrics" <% if(metricOfModel.contains("NOC")) {
                                                                        out.print(" checked='checked'");
                                                                    }%>>
                                                                    <label class="custom-control-label" for="check5">NOC</label>
                                                                  </div>
                                                                </li>
                                                                <li class="list-group-item">
                                                                  <!-- Default checked -->
                                                                  <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" name="metrics" id="CKMetrics" value="CBO" required="required" class="flat metrics" <% if(metricOfModel.contains("CBO")) {
                                                                        out.print(" checked='checked'");
                                                                    }%>>
                                                                    <label class="custom-control-label" for="check5">CBO</label>
                                                                  </div>
                                                                </li>
                                                                <li class="list-group-item">
                                                                  <!-- Default checked -->
                                                                  <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" name="metrics" id="CKMetrics" value="LCOM" required="required" class="flat metrics" <% if(metricOfModel.contains("LCOM")) {
                                                                        out.print(" checked='checked'");
                                                                    }%>>
                                                                    <label class="custom-control-label" for="check5">LCOM</label>
                                                                  </div>
                                                                </li>
                                                                <li class="list-group-item">
                                                                  <!-- Default checked -->
                                                                  <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" name="metrics" id="CKMetrics" value="NOA" required="required" class="flat metrics" <% if(metricOfModel.contains("NOA")) {
                                                                        out.print(" checked='checked'");
                                                                    }%>>
                                                                    <label class="custom-control-label" for="check5">NOA</label>
                                                                  </div>
                                                                </li>
                                                                <li class="list-group-item">
                                                                  <!-- Default checked -->
                                                                  <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" name="metrics" id="CKMetrics" value="LOC" required="required" class="flat metrics" <% if(metricOfModel.contains("LOC")) {
                                                                        out.print(" checked='checked'");
                                                                    }%>>
                                                                    <label class="custom-control-label" for="check5">LOC</label>
                                                                  </div>
                                                                </li>
                                                                <li class="list-group-item">
                                                                  <!-- Default checked -->
                                                                  <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" name="metrics" id="CKMetrics" value="NOM" required="required" class="flat metrics" <% if(metricOfModel.contains("NOM")) {
                                                                        out.print(" checked='checked'");
                                                                    }%>>
                                                                    <label class="custom-control-label" for="check5">NOM</label>
                                                                  </div>
                                                                </li>
                                                                <li class="list-group-item">
                                                                  <!-- Default checked -->
                                                                  <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" name="metrics" id="CKMetrics" value="NOO" required="required" class="flat metrics" <% if(metricOfModel.contains("NOO")) {
                                                                        out.print(" checked='checked'");
                                                                    }%>>
                                                                    <label class="custom-control-label" for="check5">NOO</label>
                                                                  </div>
                                                                </li>
                                                                <li class="list-group-item">
                                  <!-- Default checked -->
                                  <div class="custom-control custom-checkbox">
                                    <input type="checkbox" name="metrics" id="CKMetrics" value="ELOC" required="required" class="flat metrics" <% if(metricOfModel.contains("ELOC")) {
                                        out.print(" checked='checked'");
                                    }%>>
                                    <label class="custom-control-label" for="check2">ELOC</label>
                                  </div>
                                </li>
                                <li class="list-group-item">
                                  <!-- Default checked -->
                                  <div class="custom-control custom-checkbox">
                                    <input type="checkbox" name="metrics" id="CKMetrics" value="NOPA" required="required" class="flat metrics" <% if(metricOfModel.contains("NOPA")) {
                                        out.print(" checked='checked'");
                                    }%>>
                                    <label class="custom-control-label" for="check5">NOPA</label>
                                  </div>
                                </li>
                                <li class="list-group-item">
                                  <!-- Default checked -->
                                  <div class="custom-control custom-checkbox">
                                    <input type="checkbox" name="metrics" id="CKMetrics" value="NMNOPARAM" required="required" class="flat metrics" <% if(metricOfModel.contains("NMNOPARAM")) {
                                        out.print(" checked='checked'");
                                    }%>>
                                    <label class="custom-control-label" for="check5">NMNOPARAM</label>
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
                                                                    <input type="checkbox" name="all" id="all_Process"_metrics" value="" class="flat">
                                                                    <label class="custom-control-label" for="check1">All</label>
                                                                  </div>
                                                                </li>
                                                                <li class="list-group-item">
                                                                  <!-- Default checked -->
                                                                  <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" name="metrics" id="Process" value="numberOfChanges" required="required" class="flat metrics" <% if(metricOfModel.contains("numberOfChanges")) {
                                                                        out.print(" checked='checked'");
                                                                    }%>>
                                                                    <label class="custom-control-label" for="check2">Number of Changes</label>
                                                                  </div>
                                                                </li>
                                                                <li class="list-group-item">
                                                                  <!-- Default checked -->
                                                                  <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" name="metrics" id="Process" value="numberOfCommittors" required="required" class="flat metrics" <% if(metricOfModel.contains("numberOfCommittors")) {
                                                                        out.print(" checked='checked'");
                                                                    }%>>
                                                                    <label class="custom-control-label" for="check4">Number of Committors</label>
                                                                  </div>
                                                                </li>
                                                                <li class="list-group-item">
                                                                  <!-- Default checked -->
                                                                  <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" name="metrics" id="Process" value="numberOfFix" required="required" class="flat metrics" <% if(metricOfModel.contains("numberOfFix")) {
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
                                                                    <input type="checkbox" name="all" id="all_Scattering" value="" class="flat">
                                                                    <label class="custom-control-label" for="check1">All</label>
                                                                  </div>
                                                                </li>
                                                                <li class="list-group-item">
                                                                  <!-- Default checked -->
                                                                  <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" name="metrics" id="Scattering" value="structuralScattering" required="required" class="flat metrics" <% if(metricOfModel.contains("structuralScattering")) {
                                                                        out.print(" checked='checked'");
                                                                    }%>>
                                                                    <label class="custom-control-label" for="check1">Structural Scattering</label>
                                                                  </div>
                                                                </li>
                                                                <li class="list-group-item">
                                                                  <!-- Default checked -->
                                                                  <div class="custom-control custom-checkbox">
                                                                    <input type="checkbox" name="metrics" id="Scattering" value="semanticScattering" required="required" class="flat metrics" <% if(metricOfModel.contains("semanticScattering")) {
                                                                        out.print(" checked='checked'");
                                                                    }%>>
                                                                    <label class="custom-control-label" for="check2">Semantic Scattering</label>
                                                                  </div>
                                                                </li>
                                                              </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                                                    <!-- my modal -->
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
                                                                        <button id="btn_confirm" type="button" class="btn btn-success"  data-dismiss="modal">Confirm</button>
                                                                    </div>
                                                                </div>

                                                            </div>
                                                        </div>
                                                                    
                                                                    <script>
    var isModalOnFocus = false;
    function mySubmit() {
           createModal();
    }
    function createModal(){
        var issueTracker = $("input[name=issueTracker]:checked").val();
        document.getElementById("githubConf").innerHTML = "<%out.print(model.getProjURL()); %>";
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