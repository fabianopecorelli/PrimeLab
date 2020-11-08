<%@page import="it.unisa.gitdm.bean.Model"%>
<%@page import="it.unisa.primeLab.ProjectHandler"%>
<%@page import="it.unisa.gitdm.bean.Project"%>
<%@page import="java.util.ArrayList"%>
<jsp:include page="header.jsp" />
<% ArrayList<Model> models = (ArrayList<Model>) session.getAttribute("models");%>
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
                    <h2>Default Example <small>Users</small></h2>

                    <div class="clearfix"></div>
                </div>
                <div class="x_title">
                    <ul class="nav navbar-right panel_toolbox">
                        <li><label>Type Prdiction &nbsp;</label></li>
                        <li><select id="typePrediction" name="typePrediction" class="form-control input-sm">
                                <option value="BugPrediction" selected>Bug Prediction</option>
                                <option value="CodeSmellDetection">Code Smell Detection</option>
                            </select></li>
                    </ul>
                    <div class="clearfix"></div>
                </div>
                <div class="x_content">
                    <table id="datatable" class="table table-striped table-bordered">
                        <thead>
                            <tr>
                                <th>Project Name</th>
                                <th>URL</th>
                                <th>Metrics</th>
                                <th>Classifier</th>
                                <th id="smellColumns" class="smell hiddenRow">Code Smell</th>
                                <th>Date</th>
                            </tr>
                        </thead>

                        <style>td#project:hover {cursor:pointer;}</style>
                        <tbody> 
                            <%
                                for (Model m : models){
                                    String visible = "hiddenRow";
                                    if(m.getType().equals("BugPrediction")) {
                                        visible = "";
                                    }
                                    String metrics = m.getMetrics().toString();
                                    metrics = metrics.substring(1,metrics.length() -1);
                                    out.print("<tr class=\"" + m.getType() + " " + visible +"\"><td id='project'>"+m.getProjName()+"</a></td>");
                                    out.print("<td id='gitURL'>"+m.getProjURL()+"</td>");
                                    out.print("<td id='metrics'>"+metrics+"</td>");
                                    out.print("<td id='classifier'>"+m.getClassifier()+"</td>");
                                    out.print("<td id='codeSmell' class=\"smell hiddenRow" + visible +"\">"+m.getSmell()+"</td>");
                                    out.print("<td id='date'>"+m.getDate()+"</td></tr>");
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <!-- /CONTENT -->
</div>

                        <form id="hidden_form" action="http://localhost:8080/PrimeLabServer/BuildModelServlet" method="POST" hidden>
                            <input type="text" value="" name="type" id="type">
                            <input type="text" value="" name="smell" id="smell">
                            <input type="text" value="" name="github" id="github">
                            <input type="checkbox" value="WMC" name="metrics" id="metrics">
                            <input type="checkbox" value="DIT" name="metrics" id="metrics">
                            <input type="checkbox" value="RFC" name="metrics" id="metrics">
                            <input type="checkbox" value="NOC" name="metrics" id="metrics">
                            <input type="checkbox" value="CBO" name="metrics" id="metrics">
                            <input type="checkbox" value="LCOM" name="metrics" id="metrics">
                            <input type="checkbox" value="NOA" name="metrics" id="metrics">
                            <input type="checkbox" value="LOC" name="metrics" id="metrics">
                            <input type="checkbox" value="NOM" name="metrics" id="metrics">
                            <input type="checkbox" value="NOO" name="metrics" id="metrics">
                            <input type="checkbox" value="ELOC" name="metrics" id="metrics">
                            <input type="checkbox" value="NOPA" name="metrics" id="metrics">
                            <input type="checkbox" value="NMNOPARAM" name="metrics" id="metrics">
                            <input type="checkbox" value="numberOfChanges" name="metrics" id="metrics">
                            <input type="checkbox" value="numberOfCommittors" name="metrics" id="metrics">
                            <input type="checkbox" value="numberOfFix" name="metrics" id="metrics">
                            <input type="checkbox" value="structuralScattering" name="metrics" id="metrics">
                            <input type="checkbox" value="semanticScattering" name="metrics" id="metrics">
                            <input type="text" value="" name="classifier" id="classifier">
                            <input type="text" value="" name="issueTracker" id="issueTracker">
                        </form>
<!-- /page content -->

<!-- footer content -->
<jsp:include page="footer.jsp" />


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
        $('td#project').on('click', function() {
            var tr = $(this).parent();
            
            //row data
            var projectName = tr.find($('td#project')).text();
            var gitUrl = tr.find($('td#gitURL')).text();
            var metric = tr.find($('td#metrics')).text();
            var classifier = tr.find($('td#classifier')).text();
            var smell = tr.find($('td#codeSmell')).text();
            var date = tr.find($('td#date')).text();
           // console.log(metric);
            var metrics = metric.split(", ");
            //console.log(metrics[1]);
            //send data
            var f = $("form:hidden#hidden_form");
            var i;
            var j = 0;
            var str;
            for(i = 0; i < 18; i++) {
                str = f.find("input#metrics").eq(i).val();
                //console.log(str);
                if(str === metrics[j]) {
                    f.find("input#metrics").eq(i).attr('checked', true);
                    //console.log(f.find("input#metrics").eq(i));
                    j++;
                }
            }
            f.find("#type").val($("#typePrediction").val());
            f.find("input#smell").val(smell);
            f.find("input#github").val(gitUrl);
            f.find("input#classifier").val(classifier);
            //console.log(f.find("input#smell").val());
            f.submit();
            //console.log("ok");
        });
        
        $("#typePrediction").on("change", function(){
            var type = $("#typePrediction").val();
            if(type === "BugPrediction") {
                //$("tr.BugPrediction").css("visibility","visible");
                //$("tr.CodeSmellDetection").css("visibility","hidden");
                $("tr.BugPrediction").removeClass("hiddenRow");
                $("tr.CodeSmellDetection").addClass("hiddenRow");
                $(".smell").addClass("hiddenRow");
                $(".smell").removeClass("col-md-2");
               
            }
            if(type === "CodeSmellDetection") {
                $("tr.BugPrediction").addClass("hiddenRow");
                $("tr.CodeSmellDetection").removeClass("hiddenRow");
                $(".smell").removeClass("hiddenRow");
                $(".smell").addClass("col-md-2");
            }
        });
    });
</script>