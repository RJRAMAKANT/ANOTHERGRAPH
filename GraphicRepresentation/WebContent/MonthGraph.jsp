<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ page import="com.beanclass.CenterCode" %>
<%@ page import="com.daoclass.DistinctYear" %> 
<%@ page import="java.util.ArrayList" %>   
<%@ page import="com.beanclass.StokeYear" %>
<%@ page import="com.daoclass.StrokeDao" %>
<%@ page import="com.beanclass.CoiceByYear" %>
<%@ page import="com.daoclass.CooseByYearDao" %>
<%@ page import="com.beanclass.GraphByCenterYear" %>
<%@ page import="com.daoclass.GraphByCenterYearDao" %>
<%@ page import="com.beanclass.GraphMonthWise" %>
<%@ page import="com.daoclass.GraphByMonthDao" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<%-- NEW CHART SCRIPT  START--%>

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-3d.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>
<%-- NEW CHART SCRIPT END --%>
</head>
<style>

.firstradio {

display:flex;
justify-content:space-around;
}
.secondstep1{
display:flex;
justify-content:space-around;
margin-top:1vh;
}
body{
background-color:#ebfaf9

}
.insidefirstdiv{
 width:100%;
 margin-left:30%;
 text-align:center;	
}
form{
width:50%;
margin-top:2vh;
background-color:#c3ebe8;
border-radius:15px;
text-align:center;
padding:10px;
color:black;
font-weight:bold;
height:500px;
box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
}

.firstform{
display:flex;
justify-content: center; /* Center horizontally */
align-items: center; /* Center vertically */
font-weight:bold;
}
.gobutton{

margin-top:20vh;
padding:1rem;
color:red;
border-radius:10px;
cursor:pointer;
padding:10px;
font-family:arial Black;
}
.gobutton:hover{
color:yellow;
}
select{
 width:200px;
 height:30px;
 border-radius:5px;
 font-size:18px;
 font-weight:bold;
}
<%-- --%>
button {
 display: inline-block;
 width: 150px;
 height: 50px;
 border-radius: 10px;
 border: 1px solid #03045e;
 position: relative;
 overflow: hidden;
 transition: all 0.5s ease-in;
 z-index: 1;
}



button::after {
 right: -10px;

}


button:hover {
 color: #e0aaff;
 transition: 0.3s;
 background-color:#047ec4;
}

button span {
 color: #f251f5;
 font-size: 18px;
 transition: all 0.3s ease-in;
}
<%--
.graphchart{
display:flex;
justify-content:center;
align-items:center;
padding:20px;
} --%>

<%-- NEW CHART STYLE START --%>

#container {
    height: 400px;
    margin-left:-90px;
}

.highcharts-figure,
.highcharts-data-table table {
    min-width: 310px;
    max-width: 800px;
    margin: 1em auto;
}

#sliders td input[type="range"] {
    display: inline;
}

#sliders td {
    padding-right: 1em;
    white-space: nowrap;
}



<%-- NEW CHART STYLE END --%>

</style>
<body>
	<%
		DistinctYear distinctYear = new DistinctYear();
		ArrayList<CenterCode> cc = distinctYear.showAllCenter();

		StrokeDao stroke = new StrokeDao();
		ArrayList<StokeYear>sty = stroke.showAllYear();
	%>
		<% ArrayList<GraphMonthWise> myList = (ArrayList<GraphMonthWise>) session.getAttribute("monthdata"); %>
	<div class="firstform">
		<div class="insidefirstdiv">
			<form action="graphdata" method="post">
				<div class="firstradio">
					<div class="form-check">
						<input  id="radio1" name="option" value="center" required class="form-check-input" type="radio" checked
							onclick="showSelect()"> CENTER-WISE<br>
					</div>
					<div>
						<input  id="radio2" name="option" value="year" required class="form-check-input" type="radio"
							onclick="showSelect()" > YEAR- WISE<br>
					</div> 

      
 
				</div>
				<div id="secondstep" class="secondstep1">
					<div id="selectDiv" style="display:; margin-top: 10px;">
						<label for="cars">CHOOSE A CENTER:</label> <select id="cars"
							name="center">
							<option value="<%=request.getAttribute("data1")%>"><%=request.getAttribute("data1") %>--<%=request.getAttribute("data4") %></option>
							<%
								for (int i = 0; i < cc.size(); i++) {
							%>
							<%
								CenterCode cd = (CenterCode) cc.get(i);
							%>
							<option value="<%=cd.getCentercode()%>"><%=cd.getCentercode()%>--<%=cd.getCenterName() %></option>
							<%
								}
							%>
							
						</select>

						<div style="display: flex; margin-top: 10px; justify-content:space-around;">
							<div>
								<input id="radio3" name="option1" value="month" class="form-check-input" type="radio" checked
									onclick="showSelect1()">BY MONTH<br>
							</div>
							<div>
								<input  id="radio4" name="option1" value="year1" class="form-check-input" type="radio"
									onclick="showSelect1()">BY YEAR<br>
							</div>
						</div>
					</div>



					<div id="selectDiv1" style="display: none; margin-top: 10px;">
						<label for="cars">CHOOSE A YEAR:</label> <select id="cars"
							name="yearfromoption" >
							<%
								for (int i = 0; i < sty.size(); i++) {
							%>
							<%
								StokeYear stokey = (StokeYear) sty.get(i);
							%>
							<option value="<%=stokey.getYear()%>"><%=stokey.getYear()%></option>
							<%
								}
							%>

						</select>
					</div>


				</div>
				<%--  SECOND RADIO BUTTON FOR BY MONTH --%>
				<div id="selectDiv2"
					style="display: none; text-align: center; margin-top: 10px;">
					<label for="cars">CHOOSE A YEAR NOW:</label> <select id="cars"
						name="yearfromchoose">
                         <option value="<%=request.getAttribute("data")%>"><%=request.getAttribute("data")%></option>
						<%
							for (int i = 0; i < sty.size(); i++) {
						%>
						<%
							StokeYear stokey = (StokeYear) sty.get(i);
						%>
						<option value="<%=stokey.getYear()%>"><%=stokey.getYear()%></option>
						<%
							}
						%>


					</select>
				</div>
				<input type="hidden"id="ststus" value="<%=request.getAttribute("status")%>">
				
				
				<div>
					<button type="submit" class="gobutton">SEARCH</button>
				</div>
             
			</form>
		</div>
	</div>
	<%-- OLD CHART START --%>
	<%--  
	<div class="graphchart">
	         	<div id="chartContainer" class="chartdiv" style="height: 450px; width: 60%;"></div>
	</div>
	 --%>
	 <%-- OLD CHART END --%>
	 
	 <%-- NEW CHART START  --%>


	<figure class="highcharts-figure">
	<div id="container"></div>

	<div id="sliders">
		<table style=" margin-left:25%; margin-top:1rem;">
			<tr>
				<td><label for="alpha" style="font-weight:bold;">Alpha Angle</label></td>
				<td><input id="alpha" type="range" min="0" max="45" value="15" />
					<span id="alpha-value" class="value"></span></td>
			</tr>
			<tr>
				<td><label for="beta" style="font-weight:bold;">Beta Angle</label></td>
				<td><input id="beta" type="range" min="-45" max="45" value="15" />
					<span id="beta-value" class="value"></span></td>
			</tr>
			<tr>
				<td><label for="depth" style="font-weight:bold;">Depth</label></td>
				<td><input id="depth" type="range" min="20" max="100" 
					value="50" /> <span id="depth-value" class="value"></span></td>
			</tr>
		</table>
	</div>
	</figure>




	<%-- NEW CHART END --%>
	 
	
	<%
	 			String data = (String) request.getAttribute("data");
	 		%>
	
	<script>
		function showSelect() {
			var selectDiv = document.getElementById("selectDiv");
			var radio1 = document.getElementById("radio1");
			var radio2 = document.getElementById("radio2");

			if (radio1.checked) {
				selectDiv.style.display = "block";
				selectDiv1.style.display = "none";
			} else {
				selectDiv1.style.display = "block";
				selectDiv.style.display = "none";
				selectDiv2.style.display = "none";
			}
		}

		function showSelect1() {
			var selectDiv = document.getElementById("selectDiv2");
			var radio3 = document.getElementById("radio3");
			var radio4 = document.getElementById("radio4");

			if (radio3.checked) {
				selectDiv2.style.display = "block";

			} else {

				selectDiv2.style.display = "none";
			}
		}
	</script>
	<%-- <script src="https://cdn.canvasjs.com/canvasjs.min.js"></script> --%>	



		

<%-- OLD CHART FUNCTION START --%>
<%--
<script>
window.onload = function () {

	var chart = new CanvasJS.Chart("chartContainer", {
		animationEnabled: true,
		theme: "light2", // "light1", "light2", "dark1", "dark2"
		title:{
			text: "STROKE CASES BY CENTER (<%=request.getAttribute("data1")%>) IN THE YEAR <%=request.getAttribute("data")%>"
		},
		axisY: {
			title: "TOTAL CASES"
		},
		data: [{        
			type: "column",  
			showInLegend: true, 
			legendMarkerColor: "grey",
			legendText: "MONTH",
			dataPoints: [    
			         	<% for(int i=0;i<myList.size();i++){
							%>
							<%
							GraphMonthWise alltable=(GraphMonthWise)myList.get(i);
							
							%>
							{ y: <%=alltable.getTotalCases() %>, label: "<%=alltable.getMonth() %>" },
				               <% 
							}%>
			<%--{ y: 1000, label: "2018" },
				{ y: 1900,  label: "2019" },
				{ y: 5334,  label: "2020" },
				{ y: 11978,  label: "2021" },
				{ y: 17803,  label: "2020" },
				{ y: 7288, label: "2023" },
				 --%>	
	           
	<%--		]
		}]
	});
	chart.render();

	}

</script>
--%>
<%-- OLD CHART FUNCTION END --%>

<%-- NEW GRAPH FUNCTION START  --%>
<%-- NEW GRAPH FUNCTION END --%>
<script>
//Set up the chart
const chart = new Highcharts.Chart({
chart: {
    renderTo: 'container',
    type: 'column',
    options3d: {
        enabled: true,
        alpha: 0,
        beta: 1,
        depth: 20,
        viewDistance: 25
    }
},
xAxis: {
    categories: [
        <% for(int i=0; i<myList.size(); i++) {
              GraphMonthWise alltable = (GraphMonthWise)myList.get(i);
        %>
              '<%= alltable.getMonth() %>',
        <% } %>
    ]
},
yAxis: {
    title: {
        enabled: false
    }
},
tooltip: {
    headerFormat: '<b>{point.key}</b><br>',
    pointFormat: 'Cars sold: {point.y}'
},
title: {
    text: 'STROKE CASES BY CENTER (<%=request.getAttribute("data1")%>) IN THE YEAR <%=request.getAttribute("data")%>',
    align: 'center'
},
subtitle: {
    text: 'ICMR-NCDIR',
    align: 'center'
},
legend: {
    enabled: false
},
plotOptions: {
    column: {
        depth: 25
    }
},
series: [{
    data: [
        <% for(int j=0; j<myList.size(); j++) {
              GraphMonthWise alltable1 = (GraphMonthWise)myList.get(j);
        %>
              <%= alltable1.getTotalCases() %>,
        <% } %>
    ],
    colorByPoint: true
}]
});

function showValues() {
document.getElementById('alpha-value').innerHTML = chart.options.chart.options3d.alpha;
document.getElementById('beta-value').innerHTML = chart.options.chart.options3d.beta;
document.getElementById('depth-value').innerHTML = chart.options.chart.options3d.depth;
}

//Activate the sliders
document.querySelectorAll('#sliders input').forEach(input => input.addEventListener('input', e =>{
chart.options.chart.options3d[e.target.id] = parseFloat(e.target.value);
showValues();
chart.redraw(false);
}));

showValues();
</script>



<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>