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
            <h3>
                <% if(model.getType().equals("BugPrediction")) {
                    out.print("Bug Prediction");
                } else {
                    out.print("Code Smell Detection <span>(" + model.getSmell() + ")</span>");
                }%>
            </h3>
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
                                                <%if(model.getType().equals("BugPrediction")) {%>
                                                    <jsp:include page="bugPrediction.jsp"/>
                                                <% } else {%>
                                                    <jsp:include page="codeSmell.jsp"/>
                                                <% } %>
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
                                <!--
                                <div class="x_title">
                                    <ul class="nav navbar-right panel_toolbox">
                                        <li><label>Type Prediction &nbsp;</label></li>
                                        <li><select id="typePrediction" name="typePrediction" class="form-control input-sm">
                                                <option value="BugPrediction" selected>Bug Prediction</option>
                                                <option value="CodeSmellDetection">Code Smell Detection</option>
                                            </select></li>
                                    </ul>
                                    <div class="clearfix"></div>
                                </div>
                                -->
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
                                                    <% if(model.getType().equals("CodeSmellDetection")) {out.print("<th>Smell</th>");} %>
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
                                                    if(model.getType().equals("BugPrediction")) {
                                                        for (Model m : project.getModels()){
                                                        //String visible = "hiddenRow";
                                                        //boolean disable = true;
                                                        
                                                        if(m.getType().equals("BugPrediction")) {
                                                            //visible = "";
                                                            //disable = false;
                                                            if (i % 2 != 0) {
                                                                out.print("<tr class='even pointer "+ m.getType()+"'>");
                                                            } else {
                                                                out.print("<tr class='odd pointer "+ m.getType() + "'>");
                                                            }
                                                            String metrics = m.getMetrics().toString();
                                                            metrics = metrics.substring(1, metrics.length()-1);
                                                            String classif = m.getClassifier().toString();
                                                            out.print("<td class='a-center'>"
                                                                    + "<input type='checkbox' class='flat " + m.getType() + "' name='table_records' value='"+m.getName()+"'>"
                                                                    + "</td>"
                                                                    + "<td>Run " + i + "</td>"
                                                                    + "<td>" + metrics + "</td>"
                                                                    + "<td>" + classif + "</td>"
                                                                    + "<td>" + m.getDate() + "</td>"
                                                                    + "</tr>");
                                                            i++;
                                                            }
                                                        
                                                        }
                                                    } else {
                                                            
                                                            for (Model m : project.getModels()){
                                                        //String visible = "hiddenRow";
                                                        //boolean disable = true;
                                                        
                                                        if(m.getType().equals("CodeSmellDetection")) {
                                                            if (i % 2 != 0) {
                                                                out.print("<tr class='even pointer "+ m.getType()+"'>");
                                                            } else {
                                                                out.print("<tr class='odd pointer "+ m.getType() + "'>");
                                                            }
                                                            String metrics = m.getMetrics().toString();
                                                            metrics = metrics.substring(1, metrics.length()-1);
                                                            String classif = m.getClassifier().toString();
                                                            out.print("<td class='a-center'>"
                                                                    + "<input type='checkbox' class='flat " + m.getType() + "' name='table_records' value='"+m.getName()+"'>"
                                                                    + "</td>"
                                                                    + "<td>Run " + i + "</td>"
                                                                    + "<td>" + metrics + "</td>"
                                                                    + "<td>" + classif + "</td>"
                                                                    + "<td>" + m.getSmell() + "</td>"
                                                                    + "<td>" + m.getDate() + "</td>"
                                                                    + "</tr>");
                                                            i++;
                                                            }
                                                        
                                                        }
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
            
            var github = $("#githubConf").text();
            var issueTracker = $("#issueTrackerConf").text();
            var issueTrackerURL = $("#issueTrackerURLConf").text();
            var metric_1 = $("#metricsConf").text();
            var metrics = metric_1.split("; ");
            metrics.splice(-1,1);
            var classifier = $("#heard").val();
            $.ajax({
                   type: 'Post',
                   url: "http://localhost:8080/PrimeLabServer/BuildModelServlet", data:{
                github : github,
                issueTracker : issueTrackerURL,
                metrics : metrics,
                classifier : classifier
            }, success: function(data) {
                var mex = "";
                if(succes === 200) {
                    mex="We\'ll send you an a e-mail when the<br> evalutation will be completed";
                } else {
                    mex="error";
                }
                console.log(success);
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
            }, traditional: true});
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
        
//        function enable_cb(input) {
//            if (this.checked) {
//              $(input).removeAttr("disabled");
//            } else {
//              $(input).attr("disabled", true);
//            }
//          }
//        
//        $("#typePrediction").on("change", function(){
//            var type = $("#typePrediction").val();
//            if(type === "BugPrediction") {
//                //$("tr.BugPrediction").css("visibility","visible");
//                //$("tr.CodeSmellDetection").css("visibility","hidden");
//                $("tr.BugPrediction").removeClass("hiddenRow");
//                $("tr.CodeSmellDetection").addClass("hiddenRow");
//                $("input.CodeSmellDetection").attr("disabled", true);
//                $("input.BugPrediction").removeAttr("disabled");
//            }
//            if(type === "CodeSmellDetection") {
//                $("tr.BugPrediction").addClass("hiddenRow");
//                $("tr.CodeSmellDetection").removeClass("hiddenRow");
//                $("input.BugPrediction").attr("disabled", true);
//                $("input.CodeSmellDetection").removeAttr("disabled");
//            }
//            
//        });
        
    });
</script>
<!-- Parsley -->
<script>
                                var metrics = document.getElementsByName("metrics");
//                                for (var i = 0; i < metrics.length; i++) {
//                                    //console.log(metrics[i]);
//                                    metrics[i].addEventListener("click", function () {
//                                        document.getElementById("newPred").style.visibility = "visible";
//                                        console.log("ok");
//                                    }, true);
//                                }
                                    
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
