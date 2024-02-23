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
</head>
<style>

.firstradio {
display:flex;
justify-content:space-around;
}
.secondstep1{
display:flex;
justify-content:space-around;
}
body{
background-color:#ebfaf9

}
.insidefirstdiv{
 width:80%;
}
form{
width:100%;
margin-top:5vh;

}

.firstform{
display:flex;
justify-content: center; /* Center horizontally */
align-items: center; /* Center vertically */
font-weight:bold;
}
.gobutton{
margin-left:45%;
margin-top:20vh;
padding:1rem;
font-family:Cooper Black;
font-size:20px;
color:red;
border-radius:10px;
cursor:pointer;
}
select{
 width:200px;
 height:30px;
 border-radius:5px;
 font-size:18px;
 font-weight:bold;
}
.graphchart{
margin-top:10vh;
}
<%-- trying --%>

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

button::before,
button::after {
 content: '';
 position: absolute;
 top: 0;
 width: 0;
 height: 100%;
 transform: skew(15deg);
 transition: all 0.5s;
 overflow: hidden;
 z-index: -1;
}

button::before {
 left: -10px;
 background: #240046;
}

button::after {
 right: -10px;
 background: #5a189a;
}

button:hover::before,
button:hover::after {
 width: 58%;
 color:white;
}

button:hover span {
 color: #e0aaff;
 transition: 0.3s;
}

button span {
 color: #03045e;
 font-size: 18px;
 transition: all 0.3s ease-in;
}



</style>
<body>
	
		<% ArrayList<GraphMonthWise> myList = (ArrayList<GraphMonthWise>) session.getAttribute("monthdata"); %>
	
	<div class="graphchart">
	         	<div id="chartContainer" style="height: 500px; width: 100%;"></div>
	</div>
	
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
		<script src="https://cdn.canvasjs.com/canvasjs.min.js"></script>
		
		<script>
window.onload = function () {

	var chart = new CanvasJS.Chart("chartContainer", {
		animationEnabled: true,
		theme: "light2", // "light1", "light2", "dark1", "dark2"
		title:{
			text: "STROKE CASES PROVED BY CENTERS "
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
	           
			]
		}]
	});
	chart.render();

	}

</script>
</body>
</html>