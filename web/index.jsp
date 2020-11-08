<%-- 
    Document   : index
    Created on : 30-ott-2020, 21.34.50
    Author     : giuse
--%>
<jsp:include page="header.jsp" />
<div class="right_col" role="main">
    
    <div class="row">
        <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
                <div class="x_content" style="display: block;">
                    <div class="row">
                        <br><br><br><br><br>
                    </div>
                    <div class="row">
                        <div class="col-6 col-md-6 d-flex justify-content-center align-items-center">
                            <h1 class="display-3">This is PrimeLab, a tool that aims to solve some software engineering problems.</h1>
                            <h2>This tool allows the creation and comparison of different machine learning models.</h2>
                            
                            <!--<img id="imgHome" src="style/images/logo.png" class="img-fluid center-block" style="width:400px;height:400px;"> -->
                        </div>
                        <div class="col-6 col-md-6">
                            <img src="style/images/img_home.png" class="img-fluid center-block" style="width:600px;height:338px;">
                            
                        </div>
                        
                    </div>
                    <div class="row">
                        <div class="col-md-3"></div><div class="col-md-3"></div>
                    </div>
                    <div class="ln_solid"></div>
                    <div class="row">
                        <div class="col-md-6 text-center d-flex justify-content-center p-2">
                            <div class="card" style="width: 30rem;">
                                <div class="card-body">
                                  <h5 class="card-title">Bug prediction</h5>
                                  <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                                  <br>
                                  <a href="createBugPredictionModel.jsp" class="btn btn-success btn-lg">Bug prediction</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 d-flex text-center">
                            <div class="card" style="width: 30rem;">
                                <div class="card-body">
                                  <h5 class="card-title">Code smell detection</h5>
                                  <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                                  <br>
                                  <a href="createSmellModel.jsp" class="btn btn-success btn-lg">Code smell detection</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp" />