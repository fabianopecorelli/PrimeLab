<jsp:include page="header.jsp" />
<!-- top navigation -->
<!--<div class="top_nav">
    <div class="nav_menu">
        <nav>
            <div class="nav toggle">
                <a id="menu_toggle"><i class="fa fa-bars"></i></a>
            </div>

            <ul class="nav navbar-nav navbar-right">
                <li class="">
                    <label class="breadcrumb"><a href="#"> Pagina 1 </a> | <a href="#"> Pagina 2 </a> | Pagina 3 </label>

                </li>
            </ul>
        </nav>
    </div>
</div>-->
<!-- /top navigation -->
<!-- page content -->
<div class="right_col" role="main">
    <div class="">
        <div class="page-title">
            <div class="title_left">
                <h3>Titolo</h3>
            </div>

            <div class="title_right">

            </div>
        </div>

        <div class="clearfix"></div>


    </div>
    <!-- CONTENT -->

    <div class="row">
        <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
                <div class="x_title">
                    <h2>Calculate new prediction </h2>

                    <div class="clearfix"></div>
                </div>
                <div class="x_content" style="display: block;">
                    <br>
                    <form action="http://localhost:8080/PrimeLabServer/BuildModelServlet" method="POST" id="demo-form2" data-parsley-validate="" class="form-horizontal form-label-left" novalidate="">

                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="first-name">Github link <span class="required">*</span>
                            </label>
                            <div class="col-md-6 col-sm-6 col-xs-12">
                                <input type="text" name="github" id="github" required="required" class="form-control col-md-7 col-xs-12">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">Issue Tracker <span class="required">*</span>
                            </label>
                            <div  class="col-md-6 col-sm-6 col-xs-12">
                                <div class="col-md-3"></div>
                                <div class="col-md-3">
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
<!--                        <div class="container">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">Select metrics: <span class="required">*</span>
                            <div class="row">
                              <div class="col-sm">
                                  <label class="">CK Metrics</label>
                                  <div class="checkbox">
                                    <label class="">
                                        <input type="checkbox" name="all" id="all" value="CK Metrics" required="required" class="flat" checked="checked"> All
                                    </label>
                                  </div>
                                  <div class="checkbox">
                                      <label class="">
                                          <input type="checkbox" name="metrics" value="WMC" required="required" class="flat" checked="checked"> WMC
                                      </label>
                                  </div>
                              </div>
                              <div class="col-sm">
                                One of three columns
                              </div>
                              <div class="col-sm">
                                One of three columns
                              </div>
                            </div>
                        </div>-->
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">Select metrics: <span class="required">*</span>
                            </label>
                            <div  class="col-md-6 col-sm-6 col-xs-12">
                                <div class="col-md-3">
                                    <label>CK Metrics</label>
                                    <ul class="list-group list-group-flush">
                                        <li class="list-group-item">
                                          <!-- Default checked -->
                                          <div class="custom-control custom-checkbox">
                                              <input type="checkbox" name="all" id="all_CKMetrics" value="" class="flat">
                                            <label class="" for="check1">All</label>
                                          </div>
                                        </li>
                                        <li class="list-group-item">
                                          <!-- Default checked -->
                                          <div class="custom-control custom-checkbox">
                                            <input type="checkbox" name="metrics" id="CKMetrics" value="WMC" required="required" class="flat">
                                            <label class="custom-control-label" for="check2">WMC</label>
                                          </div>
                                        </li>
                                        <li class="list-group-item">
                                          <!-- Default checked -->
                                          <div class="custom-control custom-checkbox">
                                            <input type="checkbox" name="metrics" id="CKMetrics" value="DIT" required="required" class="flat">
                                            <label class="custom-control-label" for="check3">DIT</label>
                                          </div>
                                        </li>
                                        <li class="list-group-item">
                                          <!-- Default checked -->
                                          <div class="custom-control custom-checkbox">
                                            <input type="checkbox" name="metrics" id="CKMetrics" value="RFC" required="required" class="flat">
                                            <label class="custom-control-label" for="check4">RFC</label>
                                          </div>
                                        </li>
                                        <li class="list-group-item">
                                          <!-- Default checked -->
                                          <div class="custom-control custom-checkbox">
                                            <input type="checkbox" name="metrics" id="CKMetrics" value="NOC" required="required" class="flat">
                                            <label class="custom-control-label" for="check5">NOC</label>
                                          </div>
                                        </li>
                                        <li class="list-group-item">
                                          <!-- Default checked -->
                                          <div class="custom-control custom-checkbox">
                                            <input type="checkbox" name="metrics" id="CKMetrics" value="CBO" required="required" class="flat">
                                            <label class="custom-control-label" for="check5">CBO</label>
                                          </div>
                                        </li>
                                        <li class="list-group-item">
                                          <!-- Default checked -->
                                          <div class="custom-control custom-checkbox">
                                            <input type="checkbox" name="metrics" id="CKMetrics" value="LCOM" required="required" class="flat">
                                            <label class="custom-control-label" for="check5">LCOM</label>
                                          </div>
                                        </li>
                                        <li class="list-group-item">
                                          <!-- Default checked -->
                                          <div class="custom-control custom-checkbox">
                                            <input type="checkbox" name="metrics" id="CKMetrics" value="NOA" required="required" class="flat">
                                            <label class="custom-control-label" for="check5">NOA</label>
                                          </div>
                                        </li>
                                        <li class="list-group-item">
                                          <!-- Default checked -->
                                          <div class="custom-control custom-checkbox">
                                            <input type="checkbox" name="metrics" id="CKMetrics" value="LOC" required="required" class="flat">
                                            <label class="custom-control-label" for="check5">LOC</label>
                                          </div>
                                        </li>
                                        <li class="list-group-item">
                                          <!-- Default checked -->
                                          <div class="custom-control custom-checkbox">
                                            <input type="checkbox" name="metrics" id="CKMetrics" value="NOM" required="required" class="flat">
                                            <label class="custom-control-label" for="check5">NOM</label>
                                          </div>
                                        </li>
                                        <li class="list-group-item">
                                          <!-- Default checked -->
                                          <div class="custom-control custom-checkbox">
                                            <input type="checkbox" name="metrics" id="CKMetrics" value="NOO" required="required" class="flat">
                                            <label class="custom-control-label" for="check5">NOO</label>
                                          </div>
                                        </li>
                                      </ul>
<!--                                    <div class="checkbox">
                                        <label class="">
                                            <input type="checkbox" name="metrics" value="CK Metrics" required="required" class="flat" checked="checked"> CK metrics
                                        </label>
                                    </div>-->
                                </div>
                                <div class="col-md-4">
                                    <label>Process</label>
                                    <ul class="list-group list-group-flush">
                                        <li class="list-group-item">
                                          <!-- Default checked -->
                                          <div class="custom-control custom-checkbox">
                                            <input type="checkbox" name="all" id="all_Process" value="" class="flat">
                                            <label class="custom-control-label" for="check1">All</label>
                                          </div>
                                        </li>
                                        <li class="list-group-item">
                                          <!-- Default checked -->
                                          <div class="custom-control custom-checkbox">
                                            <input type="checkbox" name="metrics" id="Process" value="numberOfChanges" required="required" class="flat">
                                            <label class="custom-control-label" for="check2">Number of Changes</label>
                                          </div>
                                        </li>
                                        <li class="list-group-item">
                                          <!-- Default checked -->
                                          <div class="custom-control custom-checkbox">
                                            <input type="checkbox" name="metrics" id="Process" value="numberOfCommittors" required="required" class="flat">
                                            <label class="custom-control-label" for="check4">Number of Committors</label>
                                          </div>
                                        </li>
                                        <li class="list-group-item">
                                          <!-- Default checked -->
                                          <div class="custom-control custom-checkbox">
                                            <input type="checkbox" name="metrics" id="Process" value="numberOfFix" required="required" class="flat">
                                            <label class="custom-control-label" for="check4">Number of Fix</label>
                                          </div>
                                        </li>
                                      </ul>
<!--                                    <div class="checkbox">
                                        <label class="">
                                            <input type="checkbox" name="metrics" value="Process" required="required" class="flat" checked="checked"> Process
                                        </label>
                                    </div>-->
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
                                            <input type="checkbox" name="metrics" id="Scattering" value="structuralScattering" required="required" class="flat">
                                            <label class="custom-control-label" for="check1">Structural Scattering</label>
                                          </div>
                                        </li>
                                        <li class="list-group-item">
                                          <!-- Default checked -->
                                          <div class="custom-control custom-checkbox">
                                            <input type="checkbox" name="metrics" id="Scattering" value="semanticScattering" required="required" class="flat">
                                            <label class="custom-control-label" for="check2">Semantic Scattering</label>
                                          </div>
                                        </li>
                                      </ul>
<!--                                    <div class="checkbox">
                                        <label class="">
                                            <input type="checkbox" name="metrics" value="Scattering" required="required" class="flat" checked="checked"> Scattering
                                        </label>
                                    </div>-->
                                </div>
<!--                                <div class="col-md-3">
                                    <div class="checkbox">
                                        <label class="">
                                            <input type="checkbox" name="metrics" value="Metrica 4" required="required" class="flat" checked="checked"> Metrica 4
                                        </label>
                                    </div>
                                </div>-->
                            </div>
                        </div>
                        <div class="ln_solid"></div>
                        <div class="form-group">
                            <label class="control-label col-md-3 col-sm-3 col-xs-12">Classifier *</label>
                            <div class="col-md-3 col-sm-6 col-xs-12">
                                <select id="classifier" name="classifier" class="form-control" required="">
                                    <option value="">Choose...</option>
                                    <option value="Decision Table Majority">Decision Table Majority</option>
                                    <option value="Logistic Regression">Logistic Regression</option>
                                    <option value="Multi Layer Perceptron">Multi Layer Perceptron</option>
                                    <option value="Naive Baesian">Naive Baesian</option>
                                    <option value="Random Forest">Random Forest</option>
                                </select>
                            </div>
                            <div class="col-md-3 col-sm-6 col-xs-12 col-md-offset-3">
                                <button type="reset" class="btn btn-danger">Cancel</button>
                                <button type="button" class="btn btn-success">Submit</button>

                                <div id="myModal" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
                                    <div class="modal-dialog modal-lg">
                                        <div class="modal-content">

                                            <div class="modal-header">
                                                <button type="button" onclick="onModalClose()" class="close" data-dismiss="modal"><span aria-hidden="true">�</span>
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
                                                <button type="submit" class="btn btn-success">Confirm</button>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>


    <!-- /CONTENT -->
</div>


<!-- /page content -->

<!-- footer content -->
<jsp:include page="footer.jsp" />

<!-- iCheck -->
<script src="scripts/icheck.js"></script>
<script src="scripts/parsleyjs/dist/parsley.js"></script>

<!-- Parsley -->
<script>
    
    isModalOnFocus = false;
    function mySubmit() {
        if (true === $('#demo-form2').parsley().isValid()) {
            createModal();
            isModalOnFocus = true;
        }
    }
    function createModal(){
        document.getElementById("githubConf").innerHTML = $('#github').val();
        var issueTracker = $('input[name="issueTracker"]').val();
        var nameIssueTracker = issueTracker.split("/");
        document.getElementById("issueTrackerConf").innerHTML = nameIssueTracker[nameIssueTracker.length - 2];
        document.getElementById("issueTrackerURLConf").innerHTML = $('input[name="issueTracker"]').val();
        var metrics = document.getElementById("metricsConf");
        metrics.innerHTML='';
        $('input[name="metrics"]').each(function () {
            metrics.innerHTML += (this.checked ? $(this).val()+"; " : "");
       });
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
        $('#demo-form2 .btn-success').on('click', function () {
            $('#demo-form2').parsley().validate();
            validateFront();
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
<!-- /Parsley -->
