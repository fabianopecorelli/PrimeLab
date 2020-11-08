<%-- 
    Document   : codeSmell
    Created on : 3-nov-2020, 9.10.43
    Author     : giuse
--%>

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

<div class="ln_solid"></div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">Select metrics: <span class="required">*</span>
                                                    </label>
                                                    <div  class="col-md-6 col-sm-6 col-xs-12">
                                                                        
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
                                                                <!-- Default checked -->
                                                                <li class="list-group-item">
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
                                                     
                                                    <div class="form-group col-xs-12">
                                                        <div class="ln_solid"></div>
                                                        <div class="col-md-12 col-sm-12 col-xs-12">
                                                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Smell *</label>
                                                        <div class="col-md-3 col-sm-6 col-xs-12">
                                                            <select id="smell" name="smell" class="form-control" required="">
                                                                <option value="">Choose...</option>
                                                                <option value="God Class" <% if (model.getSmell().equals("God Class")) out.print("selected=''");%>>God Class</option>
                                                                <option value="Spaghetti Code" <% if (model.getSmell().equals("Spaghetti Code")) out.print("selected=''");%>>Spaghetti Code</option>
                                                                <option value="Class Data Should Be Private" <% if (model.getSmell().equals("Class Data Should Be Private")) out.print("selected=''");%>>Class Data Should Be Private</option>
                                                                <option value="Complex Class" <% if (model.getSmell().equals("Complex Class")) out.print("selected=''");%>>Complex Class</option>
                                                            </select>
                                                        </div>
                                                        </div>
                                                    </div>
                                                                    
<div id="myModal" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
                                    <div class="modal-dialog modal-lg">
                                        <div class="modal-content">

                                            <div class="modal-header">
                                                <button type="button" onclick="onModalClose()" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
                                                </button>
                                                <h4 class="modal-title" id="myModalLabel">Comfirm your data</h4>
                                            </div>
                                            <div class="modal-body text-right">

                                                <div class="row">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">Github link: </label>
                                                    <label class="control-label col-md-6 col-sm-6 col-xs-12" id="githubConf">link</label>
                                                </div>
                                                <div class="ln_solid"></div>
                                                <div class="row">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">Version: </label>
                                                    <label class="control-label col-md-6 col-sm-6 col-xs-12" id="versionConf">none</label>
                                                </div>

                                                <div class="ln_solid"></div>
                                                <div class="row">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">Metrics:</label>
                                                    <label class="control-label col-md-6 col-sm-6 col-xs-12" id="metricsConf">CK Metricks, Scattering</label>
                                                </div>
                                                <div class="ln_solid"></div>
                                                <div class="row">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">Smell:</label>
                                                    <label class="control-label col-md-6 col-sm-6 col-xs-12" id="smellConf">God Class</label>
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
                                                <button type="submit" class="btn btn-success">Confirm</button>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                                    
                                    <script>
    
    isModalOnFocus = false;
    function mySubmit() {
        if (true === $('#demo-form2').parsley().isValid()) {
            console.log("OH");
            createModal();
            isModalOnFocus = true;
        }
    }
    function createModal(){
        document.getElementById("githubConf").innerHTML = $('#github').val();
        document.getElementById("versionConf").innerHTML = $('#version').val();
        var metrics = document.getElementById("metricsConf");
        metrics.innerHTML='';
        $('input[name="metrics"]').each(function () {
            metrics.innerHTML += (this.checked ? $(this).val()+"; " : "");
       });
       document.getElementById("smellConf").innerHTML = $('#smell').val();
        document.getElementById("classifierConf").innerHTML = $('#classifier').val();
        document.getElementById("bottomModal").innerHTML = '<input type = "email" id = "email"  required="required" class = "form-control" >';
        $('#myModal').modal();
    }
    function onModalClose(){
        isModalOnFocus = false;
        document.getElementById("bottomModal").innerHTML = '';
    }
    $(document).ready(function () {
        $.listen('parsley:field:validate', function () {
            validateFront();
        });
        $('#btnOpenModal').on('click', function () {
            $('#demo-form2').parsley().validate();
            validateFront();
            console.log("ok");
            if (!isModalOnFocus){
                mySubmit();
            }
        });
        var validateFront = function () {
            if (true === $('#demo-form2').parsley().isValid()) {
                $('.bs-callout-warning').addClass('hidden');
                $('.bs-callout-info').removeClass('hidden');
            } else {
                $('.bs-callout-info').addClass('hidden');
                $('.bs-callout-warning').removeClass('hidden');
            }
        };
    });
    try {
        hljs.initHighlightingOnLoad();
    } catch (err) {
    }
    function selectAll() {
        console.log("OK");
    }
</script>
