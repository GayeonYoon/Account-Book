<%@page import="openBanking.apiClient"%>
<%@page import="account.*"%>
<%@page import="java.time.Month"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.*"%>
<%@page import="org.json.simple.*"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="member.MemberDTO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="apiClient" class="openBanking.apiClient" />
<jsp:useBean id="account" class="account.Account" />
<%
	request.setCharacterEncoding("UTF-8");
	String jsonArray = AllTransationListJSON.getInstance().getJson();
	jsonArray = jsonArray.replaceAll("\'", "\"");
	
	int goalExpense = mMgr.getMember(id).getGoalExpense();
	
	// 초기 설정은 현재 년도, 월을 기준으로 한다.
	SimpleDateFormat yearFormat = new SimpleDateFormat("yyyy");
	SimpleDateFormat monthFormat = new SimpleDateFormat("MM");
	Date d = new Date();
	int currentYear = Integer.parseInt(yearFormat.format(d));
	int currentMonth = Integer.parseInt(monthFormat.format(d));
%>
<style TYPE="text/css">
table {
	font-size: 15pt;
}

#chartdiv {
	width: 100%;
	height: 500px;
}

#chartdiv1 {
	width: 100%;
	height: 500px;
}
</style>
<!-- MY PAGE 상단 -->
<div
	class="jumbotron jumbotron-fluid mb-5 border-bottom-0 rounded-bottom bg-info text-white pb-1">
	<div class="container pb-5" align="center">
		<h2><%=mMgr.getMember(id).getName()%> 님은</h2>
		<hr class="my-4">
		<p class="h2 m-3"><abbr id="expenditureTitle" title="attribute" style="color:gold;"></abbr> 입니다</p> 
	</div>
</div>

<!-- MY PAGE 컨텐츠 -->
<div class="container pt-5" style="margin-top: 50px;">
	<h1>
		<b><font color='#6771dc'><%=currentMonth%>월</font> 목표 지출액 <%=goalExpense %></b>
	</h1>
	<br />
	<!-- 현재까지 총 지출액 -->
	<p id="sumExpenditure" style="font-size: 30px;"></p>
	<!-- 목표 지출액과 현재 총 지출과의 비교 -->
	<div class="progress" style="height: 30px;"></div>
	<br>
	<div class="m-auto">
		<div class="row col mt-5 mb-5">
			<!-- 현재 까지 지출 내역과 카테고리를 나타냄 -->
			<div class="col-12 col-xl-5">
				<div class="card text-monospace">
					<div class="card-header">
						<h3 class="card-header-title" align="center">카테고리</h3>
					</div>
					<div class="card-body">
						<div id="categoryDiv"></div>
					</div>
				</div>
			</div>

			<!-- 현재 까지 지출 내역 카테고리 별 그래프 -->
			<div class="col-12 col-xl-7">
				<!-- Resources -->
				<script src="https://cdn.amcharts.com/lib/4/core.js"></script>
				<script src="https://cdn.amcharts.com/lib/4/charts.js"></script>
				<script src="https://cdn.amcharts.com/lib/4/themes/animated.js"></script>
				<!-- <script src="https://cdn.amcharts.com/lib/4/themes/dark.js"></script> -->
				<!-- Chart code -->
				<script>
						// AllTransationListJSON 싱글톤에 저장된 json을 변수에 받는다.
						var list = '<%=jsonArray%>';
						var data = JSON.parse(list);
						// 지출 카테고리별 금액 [이번 달, 전 달, 전전 달]
					    var foodCost = [0,0,0];
					    var transportationCost = [0,0,0];
					    var cultureCost = [0,0,0];
					    var shoppingCost = [0,0,0];
					    var etcCost = [0,0,0];
					    
					    // 화면 로딩되면서 현재까지의 지출내역과 카테고리 별 지출내역을 출력해준다.
						$('document').ready(function(){
						    var month = <%=currentMonth%>;
						    for(var i = 0; i < data.length;i++){
						    	// 월을 10월 이상은 두자리, 이하는 한자리로 잘라 변수에 담는다.
						    	var dataMonth = data[i].tran_date.substring(4, 5)=="0" ? data[i].tran_date.substring(5, 6) : data[i].tran_date.substring(4, 6);
						    	if(data[i].inout_type.includes('출금')){
							    	if(dataMonth==month){ // 이번 달
							    		if(data[i].tran_type.includes('식비')){
							    			foodCost[0] += Number(data[i].tran_amt);
							    		}else if(data[i].tran_type.includes('교통')){
							    			transportationCost[0] += Number(data[i].tran_amt);
							    		}else if(data[i].tran_type.includes('문화')){
							    			cultureCost[0] += Number(data[i].tran_amt);
							    		}else if(data[i].tran_type.includes('쇼핑')){
							    			shoppingCost[0] += Number(data[i].tran_amt);
							    		}else{
							    			etcCost[0] += Number(data[i].tran_amt);
							    		}
							    	}else if(dataMonth==(month-1)){ // 전 달
							    		if(data[i].tran_type.includes('식비')){
							    			foodCost[1] += Number(data[i].tran_amt);
							    		}else if(data[i].tran_type.includes('교통비')){
							    			transportationCost[1] += Number(data[i].tran_amt);
							    		}else if(data[i].tran_type.includes('여가')){
							    			cultureCost[1] += Number(data[i].tran_amt);
							    		}else if(data[i].tran_type.includes('쇼핑')){
							    			shoppingCost[1] += Number(data[i].tran_amt);
							    		}else{
							    			etcCost[1] += Number(data[i].tran_amt);
							    		}
							    	}else if(dataMonth==(month-2)){ // 전전 달
							    		if(data[i].tran_type.includes('식비')){
							    			foodCost[2] += Number(data[i].tran_amt);
							    		}else if(data[i].tran_type.includes('교통')){
							    			transportationCost[2] += Number(data[i].tran_amt);
							    		}else if(data[i].tran_type.includes('문화')){
							    			cultureCost[2] += Number(data[i].tran_amt);
							    		}else if(data[i].tran_type.includes('쇼핑')){
							    			shoppingCost[2] += Number(data[i].tran_amt);
							    		}else{
							    			etcCost[2] += Number(data[i].tran_amt);
							    		}
							    	}
						    	}
						    }
						    // 지출 카테고리를 출력할 때 필요한 내용을 배열형태로 준비
							var icons = ['fa-utensils','fa-bus-alt','fa-landmark','fa-shopping-bag','fa-guitar'];
							var type = ['식비', '교통', '문화', '쇼핑', '기타'];
							var costArr = [foodCost[0], transportationCost[0], cultureCost[0], shoppingCost[0], etcCost[0]];
							// 현재까지의 총 지출액을 담을 변수
							var sumExpenditure = 0;
						    for(var i = 0;i<icons.length;i++){
						    	sumExpenditure += costArr[i];
						    	var div = $('#categoryDiv').append('<ul id="ul' + (i+1) + '" class="lead list-inline mt-2 col" style="font-size:30px;"></ul>');
						    	div.children('#ul'+(i+1)).append('<li class="list-inline-item"><i class="fas ' + icons[i] + ' fa-1x"></i></li>');
						    	div.children('#ul'+(i+1)).append('<li class="list-inline-item"><p>' + type[i] + ' : ' + '</p></li>');
						    	div.children('#ul'+(i+1)).append('<li class="list-inline-item float-right"><p>' + costArr[i] + '원 </p></li>');
						    }
						 
						  // -------------------------------------------------------------------------------
							   
						 // 현재 총 지출액과 지출별 비교하여 bootstrap progress로 보여준다.
						    var foodPercent = Math.ceil((foodCost[0]/sumExpenditure)*100);
						    var transportationPercent = Math.ceil((transportationCost[0]/sumExpenditure)*100);
						    var culturePercent = Math.ceil((cultureCost[0]/sumExpenditure)*100);
						    var shoppingPercent = Math.ceil((shoppingCost[0]/sumExpenditure)*100);
						    var etcPercent = Math.ceil((etcCost[0]/sumExpenditure)*100);
						    var perMax = Math.max(foodPercent,transportationPercent,culturePercent,shoppingPercent,etcPercent)
						    var printTagLocation =  $('#expenditureTitle');
						    if(perMax==foodPercent){
						    	printTagLocation.html('먹기위해 사는 사람');
						    }
						    if(perMax==transportationPercent){
						    	printTagLocation.html('동에번쩍 서에번쩍 이동하는 사람');
						    }
						    if(perMax==culturePercent){
						    	printTagLocation.html('여가생활을 해야 속이시원한 사람');
						    }
						    if(perMax==shoppingPercent){
						    	printTagLocation.html('지름신 강림자');
						    }
						    if(perMax==etcPercent){
						    	printTagLocation.html('통장이 텅장이 되기 직전 ');
						    }
						  
						  // -------------------------------------------------------------------------------
						    
						    // 현재까지 지출 총액 화면 출력
						    $('#sumExpenditure').append('현재까지 지출은 총 ' + sumExpenditure + '원 입니다.');
						    
						    // 내 목표 지출액과 현재 총 지출액을 비교하여 bootstrap progress로 보여준다.
						    var myPurposeExpenditure = Number(<%=goalExpense%>);
						    var persent = Math.ceil((sumExpenditure/myPurposeExpenditure)*100);
						    var progressColor ='';
						    if(persent>50 && persent <=75){
						    	progressColor = 'bg-info';
						    }else if(persent>75 && persent <=90){
						    	progressColor = 'bg-warning';
						    }else if(persent>90){
						    	progressColor = 'bg-danger';
						    }
						    $('.progress').append('<div class="progress-bar progress-bar-striped progress-bar-animated ' + progressColor + '" role="progressbar" style="width:' + persent + '%" aria-valuenow="' + persent + '" aria-valuemin="0" aria-valuemax="100">' + persent + '%</div>');
						    // 지출액을 구한 후, 파이 차트 실행
						    pieChart();
						}).keyup();
						
						// 파이 차트
			            var pieChart = function() {
			               // Themes begin
			               //am4core.useTheme(am4themes_dark);
			               am4core.useTheme(am4themes_animated);
			               // Themes end
			               // Create chart instance
			               var chart = am4core.create("chartdiv", am4charts.PieChart);
			
			               // Add data
			               chart.data = [ {
			                  "category" : "식비",
			                  "litres" : foodCost[0]
			               }, {
			                  "category" : "교통",
			                  "litres" : transportationCost[0]
			               }, {
			                  "category" : "문화",
			                  "litres" : cultureCost[0]
			               }, {
			                  "category" : "쇼핑",
			                  "litres" : shoppingCost[0]
			               }, {
			                  "category" : "기타",
			                  "litres" : etcCost[0]
			               } ];
			
			               // Add and configure Series
			               let pieSeries = chart.series.push(new am4charts.PieSeries());
			               pieSeries.dataFields.value = "litres";
			               pieSeries.dataFields.category = "country";
			               pieSeries.slices.template.stroke = am4core.color("#fff");
			               pieSeries.slices.template.strokeOpacity = 1;
			
			               // This creates initial animation
			               pieSeries.hiddenState.properties.opacity = 1;
			               pieSeries.hiddenState.properties.endAngle = -90;
			               pieSeries.hiddenState.properties.startAngle = -90;
			
			               chart.hiddenState.properties.radius = am4core.percent(0);
			
			            }; // end am4core.ready()
			         </script>
				<!-- 그래프 출력되는 DIV -->
				<div id="chartdiv" style="color: white;"></div>
			</div>
		</div>
	</div>
	<hr>

	<!-- 전 달, 전전 달과 비교하는 막대 그래프 -->
	<div class="row" style="margin-top: 80px;">
		<button type="button" class="btn btn-primary btn-lg btn-block mb-3"
			onclick="expenditureConfirm()" data-toggle="collapse"
			data-target="#chartdiv1" aria-expanded="false"
			aria-controls="collapseExample"><%=mMgr.getMember(id).getName()%>
			님의 지출습관
		</button>
		<script>
		function expenditureConfirm(){
         	am4core.ready(function() {
         		var chart = am4core.create('chartdiv1', am4charts.XYChart)
                chart.colors.step = 2;
                chart.legend = new am4charts.Legend()

                chart.legend.position = 'top'
                chart.legend.paddingBottom = 20
                chart.legend.labels.template.maxWidth = 95

                var xAxis = chart.xAxes.push(new am4charts.CategoryAxis())
                xAxis.dataFields.category = 'category'
                xAxis.renderer.cellStartLocation = 0.1
                xAxis.renderer.cellEndLocation = 0.9
                xAxis.renderer.grid.template.location = 0;

                var yAxis = chart.yAxes.push(new am4charts.ValueAxis());
                yAxis.min = 0;
                chart.colors.list = [ am4core.color("#67b7dc"),
                      am4core.color("#6794dc"),
                      am4core.color("#6771dc"),
                      am4core.color("#67b7dc"), ];

                function createSeries(value, name) {
                   var series = chart.series.push(new am4charts.ColumnSeries())
                   series.dataFields.valueY = value
                   series.dataFields.categoryX = 'category'
                   series.name = name

                   series.events.on("hidden", arrangeColumns);
                   series.events.on("shown", arrangeColumns);

                   var bullet = series.bullets.push(new am4charts.LabelBullet())
                   bullet.interactionsEnabled = false
                   bullet.dy = 30;
                   bullet.label.text = '{valueY}'
                   bullet.label.fill = am4core.color('#ffffff')
                   return series;
                }

                chart.data = [{
              	  /* 전전 달 */
              	  category : '<%=currentMonth - 2%> 월',
              	  first : foodCost[2],
              	  second : transportationCost[2],
              	  third : cultureCost[2],
              	  forth : shoppingCost[2],
              	  five : etcCost[2]
              	  }, {
           		  /* 전 달 */
           		  category : '<%=currentMonth - 1%> 월',
           		  first : foodCost[1],
           		  second :transportationCost[1],
           		  third : cultureCost[1],
           		  forth : shoppingCost[1],
           		  five : etcCost[1]
           		  }, {
       			  /* 현재 달 */
       			  category : '<%=currentMonth%> 월',
								first : foodCost[0],
								second : transportationCost[0],
								third : cultureCost[0],
								forth : shoppingCost[0],
								five : etcCost[0]
							} ]

							createSeries('first', '식비');
							createSeries('second', '문화');
							createSeries('third', '교통');
							createSeries('forth', '쇼핑');
							createSeries('five', '기타');

							function arrangeColumns() {
								var series = chart.series.getIndex(0);

								var w = 1 - xAxis.renderer.cellStartLocation
										- (1 - xAxis.renderer.cellEndLocation);
								if (series.dataItems.length > 1) {
									var x0 = xAxis.getX(series.dataItems
											.getIndex(0), "categoryX");
									var x1 = xAxis.getX(series.dataItems
											.getIndex(1), "categoryX");
									var delta = ((x1 - x0) / chart.series.length)
											* w;
									if (am4core.isNumber(delta)) {
										var middle = chart.series.length / 2;

										var newIndex = 0;
										chart.series.each(function(series) {
											if (!series.isHidden
													&& !series.isHiding) {
												series.dummyData = newIndex;
												newIndex++;
											} else {
												series.dummyData = chart.series
														.indexOf(series);
											}
										})
										var visibleCount = newIndex;
										var newMiddle = visibleCount / 2;

										chart.series
												.each(function(series) {
													var trueIndex = chart.series
															.indexOf(series);
													var newIndex = series.dummyData;

													var dx = (newIndex
															- trueIndex
															+ middle - newMiddle)
															* delta

													series
															.animate(
																	{
																		property : "dx",
																		to : dx
																	},
																	series.interpolationDuration,
																	series.interpolationEasing);
													series.bulletsContainer
															.animate(
																	{
																		property : "dx",
																		to : dx
																	},
																	series.interpolationDuration,
																	series.interpolationEasing);
												})
									}
								}
							}

						}); // end am4core.ready()
				$('.collapseGraph').collapse()
			}
		</script>
		<div class="collapseGraph" id="chartdiv1"></div>
	</div>
</div>
