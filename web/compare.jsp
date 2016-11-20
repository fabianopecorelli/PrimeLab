<%@page import="it.unisa.gitdm.bean.Evaluation"%>
<%@page import="java.util.ArrayList"%>
<% ArrayList<Evaluation> evaluations = (ArrayList<Evaluation>) session.getAttribute("evaluations");%>
<% int length = evaluations.size(); %>
<% evaluations.add(evaluations.get(0)); %>
<% evaluations.add(evaluations.get(0)); %>

<jsp:include page="header.jsp" />
<!-- top navigation -->
<div class="top_nav">
    <div class="nav_menu">
        <nav>

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
                    <h2 id="tableTitle">Compare Models <small></small></h2>

                    <div class="clearfix"></div>
                </div>
                <div class="x_content">

                    <div class="" role="tabpanel" data-example-id="togglable-tabs">

                        <div class="col-md-12 col-sm-6 col-xs-12">
                            <div class="x_panel">
                                <div class="x_title">
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
                    </div>

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

<script src="scripts/raphael.js"></script>
<script src="scripts/morris.js"></script>
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
        var length = <%= length %>;
        if (length ==2){
            compare2();
        }
        else if (length ==3){
            compare3();
        }
        else if (length ==4){
            compare4();
        }
    })
    
    function compare2(){
        var metr1 = "<%= evaluations.get(0).getMetrics().toString() %>";
        var class1 = "<%= evaluations.get(0).getClassifier().toString() %>";
        var model1 = metr1.substr(1, metr1.length -2)+" - "+class1;
        var acc1 = <%= evaluations.get(0).getEvaluationSummary().getAccuracy() %>;
        var prec1 = <%= evaluations.get(0).getEvaluationSummary().getPrecision()%>;
        var rec1 = <%= evaluations.get(0).getEvaluationSummary().getRecall()%>;
        var fmes1 = <%= evaluations.get(0).getEvaluationSummary().getFmeasure()%>;
        var aur1 = <%= evaluations.get(0).getEvaluationSummary().getAreaUnderRoc()%>;
        
        var metr2 = "<%= evaluations.get(1).getMetrics().toString() %>";
        var class2 = "<%= evaluations.get(1).getClassifier().toString() %>";
        var model2 = metr2.substr(1, metr2.length -2)+" - "+class2;
        var acc2 = <%= evaluations.get(1).getEvaluationSummary().getAccuracy() %>;
        var prec2 = <%= evaluations.get(1).getEvaluationSummary().getPrecision()%>;
        var rec2 = <%= evaluations.get(1).getEvaluationSummary().getRecall()%>;
        var fmes2 = <%= evaluations.get(1).getEvaluationSummary().getFmeasure()%>;
        var aur2 = <%= evaluations.get(1).getEvaluationSummary().getAreaUnderRoc()%>;
        
        Morris.Bar({
            element: 'graphx',
            data: [
                {x: 'Accuracy', y: acc1, z: acc2},
                {x: 'Precision', y: prec1, z: prec2},
                {x: 'Recall', y: rec1, z: rec2},
                {x: 'Fmeasure', y: fmes1, z: fmes2},
                {x: 'AreaUnderROC', y: aur1, z: aur2}
            ],
            xkey: 'x',
            ykeys: ['y', 'z'],
            barColors: ['#26B99A', '#34495E', '#ACADAC', '#3498DB'],
            hideHover: 'auto',
            labels: [[model1], [model2]],
            resize: true,
        }).on('click', function (i, row) {
            console.log(i, row);
        });
    }
    function compare3(){
        var metr1 = "<%= evaluations.get(0).getMetrics().toString() %>";
        var class1 = "<%= evaluations.get(0).getClassifier().toString() %>";
        var model1 = metr1.substr(1, metr1.length-2)+" - "+class1;
        var acc1 = <%= evaluations.get(0).getEvaluationSummary().getAccuracy() %>;
        var prec1 = <%= evaluations.get(0).getEvaluationSummary().getPrecision()%>;
        var rec1 = <%= evaluations.get(0).getEvaluationSummary().getRecall()%>;
        var fmes1 = <%= evaluations.get(0).getEvaluationSummary().getFmeasure()%>;
        var aur1 = <%= evaluations.get(0).getEvaluationSummary().getAreaUnderRoc()%>;
        
        var metr2 = "<%= evaluations.get(1).getMetrics().toString() %>";
        var class2 = "<%= evaluations.get(1).getClassifier().toString() %>";
        var model2 = metr2.substr(1, metr2.length-2)+" - "+class2;
        var acc2 = <%= evaluations.get(1).getEvaluationSummary().getAccuracy() %>;
        var prec2 = <%= evaluations.get(1).getEvaluationSummary().getPrecision()%>;
        var rec2 = <%= evaluations.get(1).getEvaluationSummary().getRecall()%>;
        var fmes2 = <%= evaluations.get(1).getEvaluationSummary().getFmeasure()%>;
        var aur2 = <%= evaluations.get(1).getEvaluationSummary().getAreaUnderRoc()%>;
        
        
        var metr3 = "<%= evaluations.get(2).getMetrics().toString() %>";
        var class3 = "<%= evaluations.get(2).getClassifier().toString() %>";
        var model3 = metr3.substr(1, metr3.length-2)+" - "+class3;
        var acc3 = <%= evaluations.get(2).getEvaluationSummary().getAccuracy() %>;
        var prec3 = <%= evaluations.get(2).getEvaluationSummary().getPrecision()%>;
        var rec3 = <%= evaluations.get(2).getEvaluationSummary().getRecall()%>;
        var fmes3 = <%= evaluations.get(2).getEvaluationSummary().getFmeasure()%>;
        var aur3 = <%= evaluations.get(2).getEvaluationSummary().getAreaUnderRoc()%>;
        
        Morris.Bar({
            element: 'graphx',
            data: [
                {x: 'Accuracy', y: acc1, z: acc2, a: acc3},
                {x: 'Precision', y: prec1, z: prec2, a: prec3},
                {x: 'Recall', y: rec1, z: rec2, a: rec3},
                {x: 'Fmeasure', y: fmes1, z: fmes2, a: fmes3},
                {x: 'AreaUnderROC', y: aur1, z: aur2, a: aur3}
            ],
            xkey: 'x',
            ykeys: ['y', 'z', 'a'],
            barColors: ['#26B99A', '#34495E', '#ACADAC', '#3498DB'],
            hideHover: 'auto',
            labels: [[model1], [model2], [model3]],
            resize: true,
        }).on('click', function (i, row) {
            console.log(i, row);
        });
    }
    function compare4(){
        var metr1 = "<%= evaluations.get(0).getMetrics().toString() %>";
        var class1 = "<%= evaluations.get(0).getClassifier().toString() %>";
        var model1 = metr1.substr(1, metr1.length-2)+" - "+class1;
        var acc1 = <%= evaluations.get(0).getEvaluationSummary().getAccuracy() %>;
        var prec1 = <%= evaluations.get(0).getEvaluationSummary().getPrecision()%>;
        var rec1 = <%= evaluations.get(0).getEvaluationSummary().getRecall()%>;
        var fmes1 = <%= evaluations.get(0).getEvaluationSummary().getFmeasure()%>;
        var aur1 = <%= evaluations.get(0).getEvaluationSummary().getAreaUnderRoc()%>;
        
        var metr2 = "<%= evaluations.get(1).getMetrics().toString() %>";
        var class2 = "<%= evaluations.get(1).getClassifier().toString() %>";
        var model2 = metr2.substr(1, metr2.length-2)+" - "+class2;
        var acc2 = <%= evaluations.get(1).getEvaluationSummary().getAccuracy() %>;
        var prec2 = <%= evaluations.get(1).getEvaluationSummary().getPrecision()%>;
        var rec2 = <%= evaluations.get(1).getEvaluationSummary().getRecall()%>;
        var fmes2 = <%= evaluations.get(1).getEvaluationSummary().getFmeasure()%>;
        var aur2 = <%= evaluations.get(1).getEvaluationSummary().getAreaUnderRoc()%>;
        
        
        var metr3 = "<%= evaluations.get(2).getMetrics().toString() %>";
        var class3 = "<%= evaluations.get(2).getClassifier().toString() %>";
        var model3 = metr3.substr(1, metr3.length-2)+" - "+class3;
        var acc3 = <%= evaluations.get(2).getEvaluationSummary().getAccuracy() %>;
        var prec3 = <%= evaluations.get(2).getEvaluationSummary().getPrecision()%>;
        var rec3 = <%= evaluations.get(2).getEvaluationSummary().getRecall()%>;
        var fmes3 = <%= evaluations.get(2).getEvaluationSummary().getFmeasure()%>;
        var aur3 = <%= evaluations.get(2).getEvaluationSummary().getAreaUnderRoc()%>;
        
        
        var metr4 = "<%= evaluations.get(3).getMetrics().toString() %>";
        var class4 = "<%= evaluations.get(3).getClassifier().toString() %>";
        var model4 = metr4.substr(1, metr4.length-2)+" - "+class4;
        var acc4 = <%= evaluations.get(3).getEvaluationSummary().getAccuracy() %>;
        var prec4 = <%= evaluations.get(3).getEvaluationSummary().getPrecision()%>;
        var rec4 = <%= evaluations.get(3).getEvaluationSummary().getRecall()%>;
        var fmes4 = <%= evaluations.get(3).getEvaluationSummary().getFmeasure()%>;
        var aur4 = <%= evaluations.get(3).getEvaluationSummary().getAreaUnderRoc()%>;
        
        Morris.Bar({
            element: 'graphx',
            data: [
                {x: 'Accuracy', y: acc1, z: acc2, a: acc3, b: acc4},
                {x: 'Precision', y: prec1, z: prec2, a: prec3, b: prec4},
                {x: 'Recall', y: rec1, z: rec2, a: rec3, b: rec4},
                {x: 'Fmeasure', y: fmes1, z: fmes2, a: fmes3, b: fmes4},
                {x: 'AreaUnderROC', y: aur1, z: aur2, a: aur3, b: aur4}
            ],
            xkey: 'x',
            ykeys: ['y', 'z', 'a', 'b'],
            barColors: ['#26B99A', '#34495E', '#ACADAC', '#3498DB'],
            hideHover: 'auto',
            labels: [[model1], [model2], [model3], [model4]],
            resize: true,
        }).on('click', function (i, row) {
            console.log(i, row);
        });
    }
</script>
<!-- /Parsley -->
