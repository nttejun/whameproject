<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../modal/fileupload_modal.jsp" %>
<!-- Compiled and minified JavaScript -->
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=
03947296fa39c02cca384bf32800c263&libraries=clusterer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.2/js/materialize.min.js"></script>
<style type="text/css">
.mainform{
	padding-bottom: 20px;
	width: 100%;
	}
	
.mainimg{
	width:50%;
}
.main_text{
	padding:20px; width:80%; margin-top:20px;
	background-color: #f5f5f5;
	border-radius:40px;
}
.main_mapform{
	margin-bottom:10px;
	width:50%;
	padding:10px;
}
#main_map{
	margin-bottom: 20px;
	height: 300px;
}
.mainrun{
		width:100%;
		height: 270px;
}


/*  */

.carousel .carousel-item{
	opacity:1 !important;
}

.carousel .carousel-item div.row{
	border-radius:20px;
}

div#onetop{
	background-image: url('resources/img/t3.gif');
	background-size: cover;
	width: 100%;
	padding-bottom: 25%;
}

/*  */

@media only screen and (min-width : 321px) and (max-width : 600px) {
	.mainimg{
	width:100%;
	}
	.main_text p{
		font-size:13px;
	}
	.main_text h3{
		font-size:15px;
		font-weight: bolder;
	}
	.mainform input{
		margin-bottom:10px;
	}
	.main_text{
		width:90%;
	}
	
	.main_mapform{
	width:90%;
	}
}
</style>

<div id="onetop" class="center-align">
	<div style="padding-top:25%;">
	<span style="font-size: 40px; color:white; font-weight: bold;">What Menu?</span><br>
	<a href="#downf" id="down" class="btn red lighten-2" style="border-radius:20px;">START</a>
	</div>
</div>
	<div class="center-align row" style="padding:10px" id="downf">
		<input type="button" class="btn green" value="메뉴찾기(간판이미지 업로드)" id="fileupload">
		<input type="button" class="btn pink darken-2" value="간판등록하기" id="enroll"><br>
		<div class="main_text z-depth-1 row" style="margin-left:auto; margin-right: auto;">
			<div class="col s12">
			<img src="resources/img/main.png" class="mainimg" style="border-radius:150px">
			<h3>Whame란?</h3>
			<p>Whame는 'What Menu'에서 비롯된 타이틀입니다. </p>
			<p>상가의 메뉴를 직접 들어가지 않고 밖에서 간판 사진을 이용하여 메뉴정보를 얻을 수 있습니다.</p>
			</div>
		</div>
		<div style="width:90%; margin-left: auto; margin-right: auto;" class="z-depth-1 row">
			<div class="main_mapform col s12 m8">
				<div class="counter" data-count="000${count}" id="test"></div>
				<div id="main_map"></div>
			</div>
			<div class="col s12 m4">
				<h4>Top View</h4>
				<c:set var="count" value="1"/>
				<table class="centered highlight">
				<c:forEach items="${countrank}" var="rank" end="4">
				<tr id="${rank.store_code}" class="mover">
					<th><i class="material-icons" name="${count}rank">stars</i></th>
					<td>${count}위</td>
					<td style="width:50%;">${rank.store_name}</td>
					<td>${rank.view_count}</td>
					<c:set var="count" value="${count+1}"/>
				</tr>
				</c:forEach>
				</table>
			</div>
		</div>
		<div style="width: 90%; margin-left: auto; margin-right: auto" >
			<span style="font-size: 35px;">New Store</span>
			<div class="carousel">
				<c:forEach items="${getNewStore}" var="store">
				    <a class="carousel-item" href="/whame/forkakao.whame?store_code=${store.store_code}">
				    	<div class="row" style="border:1px #bdbdbd solid; height: 300px; padding:10px;">
				    		<div class="col s12" style="height:150px;">
				    			<img src="${store.store_image}" width="100%" height="150px" style="border-radius:30px">
				    		</div>
				    		<div class="col s12" style="height: 100px;">
				    			<span style="font-size: 17px; color:black">${store.store_name}</span>
				    			<span style="blue">(${store.dong})</span>
				    		</div>
				    		<div class="col s12">
				    			<span style="blue">${store.store_category}</span>
				    		</div>
				    	</div>
				    </a>
				</c:forEach>
		 	 </div>
	 	</div>
	</div>


<script type="text/javascript">
	$('i[name=1rank]').css('color','gold');
	$('i[name=2rank]').css('color','silver');
	$('i[name=3rank]').css('color','brown');
	var cl = new Array();
	var positions = new Array();
	$(document).ready(function() {
		var counter = function(){
 			 $(".counter").rollingCounter({
 		        animate : true,
 		        attrCount : 'data-count',
 		        delayTime : 30 ,
 		        waitTime : 1 ,
 		        easing : 'easeOutBounce',
 		        duration : 1000
 		    });
	 	}();
	 	
		$("#fileupload").on('click',function(){
			$('#modal1').modal('open');
		});
	
		$("#enroll").on('click',function(){
			$(location).attr('href','enroll.whame');
		});

		var container = document.getElementById('main_map');
		var options = {
			center: new daum.maps.LatLng(37.509657,127.032893),
			level: 8
		};
		var map = new daum.maps.Map(container, options);

		var clusterer = new daum.maps.MarkerClusterer({
	        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
	        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
	        minLevel: 5 // 클러스터 할 최소 지도 레벨 
	    });
	    
		var locationlist = ${locationlist};
		var max = locationlist.length / 3;
		var markers = new Array();
		var num = 0;
		var pnum=0;
		for(var i =0; i<max; i++)
			{
				if(num <= locationlist.length)
					{
						  var marker = new daum.maps.Marker({
							  position: new daum.maps.LatLng(locationlist[num+1],locationlist[num+2])
						  });
						  markers.push(marker);
						  positions[pnum] = {'lat':locationlist[num+1],'lng':locationlist[num+2],'code':locationlist[num]};

						num += 3;
						pnum ++;
					}
				else{
						break;
					}
			}

		clusterer.addMarkers(markers);

 		$('tr[class=mover]').on('mouseover',function(){
			var id = $(this).attr('id');
			
			var locationlist2 = ${locationlist};
			var max2 = locationlist2.length / 3;
			var num2 = 0;
			for(var i =0; i<max2; i++)
			{
				if(num2 <= locationlist2.length)
					{
						if(locationlist2[num2] == id)
							{
								var moveLatLon = new daum.maps.LatLng(locationlist2[num2+1], locationlist2[num2+2]);
								map.panTo(moveLatLon);
								break;
							}
						num2 += 3;
					}
				else{
						break;
					}
			}
		});

		$('tr[class=mover]').on('click',function(){
			var id = $(this).attr('id');
			
			var locationlist2 = ${locationlist};
			var max2 = locationlist2.length / 3;
			var num2 = 0;
			for(var i =0; i<max2; i++)
			{
				if(num2 <= locationlist2.length)
					{
						if(locationlist2[num2] == id)
							{

								var points = [
												new daum.maps.LatLng(locationlist2[num2+1], locationlist2[num2+2])
								          ];

								          // 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
								          var bounds = new daum.maps.LatLngBounds();    

								          var i, marker;
								          for (i = 0; i < points.length; i++) {
								              // 배열의 좌표들이 잘 보이게 마커를 지도에 추가합니다
								              marker =     new daum.maps.Marker({ position : points[i] });
								              marker.setMap(map);
								              
								              // LatLngBounds 객체에 좌표를 추가합니다
								              bounds.extend(points[i]);
								          }

								          map.setBounds(bounds);
								break;
							}
						num2 += 3;
					}
				else{
						break;
					}
			}
		}); 

		$('.carousel').carousel({
	          dist:0,
	          shift:0,
	          padding:60,
	    });

	    $("#down").click(function(event){            
	        event.preventDefault();
	        $('html,body').animate({scrollTop:$(this.hash).offset().top+1}, 1000);
		});

	    setInterval(function(){
	    	$('.carousel').carousel('next');
		    },2000);
		
	})
</script>

