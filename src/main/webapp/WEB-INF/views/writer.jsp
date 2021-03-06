<!-- JavaScript代码复制自books页面，只修改了部分 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
    <c:set var="ctp" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<c:import url="common/viewport.jsp"/>
<c:import url="common/content_type.jsp"/>
<c:import url="common/common.jsp"/>
<title>作家</title>
<style>
.breadcrumb{
background-color: inherit;
margin: 8px; 
padding:0px;
}
.breadcrumb li a{
color:#666;
}
#worders,#worders #word .btn-group button,#worders #word .btn-group button span,#wshow,#wshow button,#wshow button span{
background-color: #f5f4f2;
border:0px;
color:#666;
}
.writerslist{
margin:10px 0px;
}

.infos_div{
background-color:#e8e8e5;
color:#666;
}
.winfos{
padding:15px 0px;
}
#page{
text-align: center;
}

</style>

<script type="text/javascript">

var writersInfos = null;
var liststype = true;

/* 将book数据进行展示 */
function showWriterInfos(data){
	var con = $("#writerslist");
	var writers = data.list;//电子书表单列表
	var writer;//包含电子书的内容
	var len = writers.length;//数据长度
	var bhtml = "";//列表HTML代码
	
	//展示分页栏
	var total = data.total;//查询的总book数量；不是当前页面的总数，是根据条件查找到的数据库中的总数
	var pageNum = data.pageNum; //当前页码
	var pages = data.pages;//总页数
	var pre = data.pre;//前一页页码
	var next = data.next;//下一页页码
	var isFirstPage = data.isFirstPage;//是否为第一页
	var isLastPage = data.isLastPage;//是否为最后一页
	var hasPreviousPage = data.hasPreviousPage;//是否有前一页
	var hasNextPage = data.hasNextPage;//是否有后一页
	
	
	var startPage = "<div class='row' id='page'><ul class='pagination'>";//关于分页按钮的HTML开始位置代码
	var endPage = "</ul></div>";//关于分页按钮的HTML结束位置代码
	var pa = "";//分页按钮的HTML代码
	//var pagediv = $("#page");
	
//	if(data != null){alert(books);}
	if(len > 0){
		bhtml += "<span class='booksnum' style='color:#aaa; font-size:12px;'>共找到"+total+"位作家</span>";
		for(var i = 0; i < len; i++){
			writer = writers[i];
			var avgsales = 0;
			if(writer.avgSales != undefined && writer.avgSales != null){avgsales = writer.avgSales;}
			bhtml += "<div class='row search' >"
			+"<div class='col-lg-9 col-md-9'>"
			+"<div class='row'>"
			+"<div  class='col-lg-2 col-md-2' id='bimg'>"
			+"<img src='http://localhost:8080/iAdmin/images/writer/"+writer.cover+"' class='img-responsive img-rounded' /></div>"
			+"<div  class='col-lg-10 col-md-10' id='binfos'>"
			+"<div class='row'><span class='stitle'>"+writer.name+"</span></div>"
			+"<div class='row stars'>";
			
			for(var j=0;(j<writer.grade) && (writer.grade > 0);j++){
				bhtml += "<span class='glyphicon glyphicon-star'></span>";
			}
			/*bhtml += "<span class='color'>  "+book.grade+"</span><span class='color'>   |   </span><span class='color'>"+book.valuator+"</span></div>";*/
			bhtml += "</div>";

			bhtml += "<div class='row summary'><span class='inf'>介绍&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span class='color'>"+writer.summary+"</span></div>";
			bhtml += "<div class='row'><span class='inf'>性别&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span class='color'>"+writer.gender+"</span></div>";
			bhtml += "<div class='row'><span class='inf'>平均销量&nbsp;&nbsp;</span><span>"+parseInt(avgsales)
			+"</span><div class='col-lg-2 col-md-2 pull-right'><a class='btn btn-success btn-xs' href='${ctp}/writers/bookofwri?id="+writer.id+"' target='_blank'>了解更多...</a></div></div></div></div></div><div class='col-lg-3 col-md-3'></div></div>";
			if(len > 1){bhtml += "<hr>";}
		}
	}
	
	
	if(total > 0 && pages > 1){
		pa = startPage
			+ firstPage(isFirstPage,pageNum)
			+ prePage(hasPreviousPage,pre)
			+ NumPage(pageNum, pages)
			+ nextPage(hasNextPage,next)
			+ lastPage(isLastPage,pages,pageNum)
			+ endPage;
			
	}
 	var pagediv = $("#page");
	con.html(bhtml);
	pagediv.html(pa);
}










	//展示列表和分页
	function writershow(data){
		//展示作者列表
		var wlist = $("#writerslist");
		var size = data.list.length;//列表数量
		var writersL = data.list;//作家列表
		var row = "";//表示一行 
		var colsize=0;//用于标识row中包含writer列表的个数,一行有4个数据
		var writer;
		var i = 0;
		
		
		if(size != 0){
			for(; i<size; i++){
				colsize = i%4;
				writer = writersL[i];
				 if(colsize == 0){
					row= row + "<div class='row writerslist'>";
				} 
				var avgsales = 0;
				if(writer.avgSales != undefined && writer.avgSales != null){avgsales = writer.avgSales;}
				row = row + "<div class='col-lg-3 col-sm-3' ><div class='infos_div'><div class='row'>"+
						"<a target='_blank' href='${ctp}/writers/bookofwri?id="+writer.id+"'><img style='cursor:pointer;height:150px;' src='http://localhost:8080/iAdmin/images/writer/"+writer.cover+"' class='img-responsive col-lg-12 col-sm-12'></a></div><div class='winfos row' style='height:75px;'>" + 
						"<span class='col-lg-1 col-sm-1'></span><span class='wname col-lg-4 col-sm-4'>"
						+ writer.name +"</span><span class='col-lg-2 col-sm-2'></span><span class='wname col-lg-5 col-sm-5'>作品销量: "+avgsales+"</span></div></div></div>";
				 if(colsize == 3){
					row = row + "</div>";
				} 
				//alert(row);
			}
			wlist.html(row);
		}else{
			wlist.html("");
			}
		
		//展示分页栏
		var total = data.total;//查询的总book数量；不是当前页面的总数，是根据条件查找到的数据库中的总数
		var pageNum = data.pageNum; //当前页码
		var pages = data.pages;//总页数
		var pre = data.pre;//前一页页码
		var next = data.next;//下一页页码
		var isFirstPage = data.isFirstPage;//是否为第一页
		var isLastPage = data.isLastPage;//是否为最后一页
		var hasPreviousPage = data.hasPreviousPage;//是否有前一页
		var hasNextPage = data.hasNextPage;//是否有后一页
		
		var startPage = "<ul class='pagination'>";//关于分页按钮的HTML开始位置代码
		var endPage = "</ul>";//关于分页按钮的HTML结束位置代码
		var pa = "";//分页按钮的HTML代码
		var pagediv = $("#page");
		
		if(total > 0 && pages > 1){
			pa = startPage
				+ firstPage(isFirstPage,pageNum)
				+ prePage(hasPreviousPage,pre)
				+ NumPage(pageNum, pages)
				+ nextPage(hasNextPage,next)
				+ lastPage(isLastPage,pages,pageNum)
				+ endPage;
				
		}
		pagediv.html(pa);
	}
	
	//包含页码分页按钮
	function NumPage(pageNum, pages){
		var p = "";
		if(pages <= 10 && pages > 1){
			for(var i=1; i<=pages;i++){
				if(i == pageNum){
					p = p + "<li style='cursor:pointer' class='active' onclick='pagebooks("+i+")'><a>"+i+"</a></li>";
				}else{
					p = p + "<li style='cursor:pointer' onclick='pagebooks("+i+")'><a>"+i+"</a></li>";
				}
			}
		}else if(pages > 10){
			if(pageNum > 5){
				var start = pageNum-4;
				var end = pageNum+5 < pages ? pageNum+5:pages;
				for(var i = start;i <=end;i++){
					if(i == pageNum){
						p = p + "<li style='cursor:pointer' class='active' onclick='pagebooks("+i+")'><a>"+i+"</a></li>";
					}else{
						p = p + "<li style='cursor:pointer' onclick='pagebooks("+i+")'><a>"+i+"</a></li>";
					}
				}
			}else{
				for(var i = 1;i <=10;i++){
					if(i == pageNum){
						p = p + "<li style='cursor:pointer' class='active' onclick='pagebooks("+i+")'><a>"+i+"</a></li>";
					}else{
						p = p + "<li style='cursor:pointer' onclick='pagebooks("+i+")'><a>"+i+"</a></li>";
					}
				}
			}
		}
		return p;
	}

	//判断和显示前一页按钮
	function prePage(hasPreviousPage,pre){
		var p = "";//“前一页按钮HTML代码”
		if(hasPreviousPage == true){
			p = "<li style='cursor:pointer' onclick='pagebooks("+pre+")'><a>上一页</a></li>";
		}
		return p;
	}

	//分页获取books列表,i表示页码
	function pagebooks(i){
		var u = orderWriters(orderId,i);//获取带参数的链接
		getDataByURL(u);//根据URL获取相关的json数据(不存在数据则刷新)，并展示
	}
	
	var url = null; //请求的URL
	var orderId = 0;//排序的方式
	
	//根据URL链接用get方法跳转页面
	function getDataByURL(url){
		
		if(url != null){
			$.getJSON(url, function(data){
				writersInfos = data;
				if(liststype){
					writershow(data);
				}else{
					showWriterInfos(data);
				}
				
			});
		}else{
			 window.location.reload();
		}
	}
	
	//截取URL不包含参数部分
	function hasUrlChars(uri){
		var chars = new Array("#","?");
		for(ind = 0; ind < chars.length; ind++){
			if(uri.indexOf(chars[ind],0) != -1){
				uri = uri.substring(0, uri.indexOf(chars[ind],0));
			}
		}
		return uri;
	}
	
	//排序和分页;生成有参数的链接，若传入的order值为-1，表示用orderId来进行排序；
	function orderWriters(order, page){
		$(":focus").css("color","#4CAF50");
		$(":focus span").css("color","#4CAF50");
		$(":focus").siblings("button").css("color","#666");
		$(":focus").siblings("button").children().css("color","#666");
		if(order != -1){orderId = order;}
		if(url ==null || url == ""){
			url = hasUrlChars(window.location.pathname + "/list");
		}
		var u;//获取URL链接
		//if(orderId != 0 || page != 1){
			u = url + "?";
			if(orderId != 0 && page != 1){
				u = u + "ord=" + orderId + "&p=" + page;
			}
			if(orderId == 0 && page != 1){
				u= u + "p=" + page;
			}
			if(orderId != 0 && page == 1){
				u= u + "ord=" + orderId;
			}
			return u;
		//}else{return null;}
	}

	//判断和显示后一页按钮
	function nextPage(hasNextPage,next){
		var p="";//“后一页按钮HTML代码”
		if(hasNextPage == true){
			return p = "<li style='cursor:pointer' onclick='pagebooks("+next+")'><a>下一页</a></li>";
		}
		return p;
	}
	//判断和显示第一页按钮;isFirstPage:判断是否是第一页;pageNum:大于5显示
	function firstPage(isFirstPage,pageNum){
		var p = "";//“首页按钮HTML代码”
		if(isFirstPage == false && pageNum > 5){
			return p = "<li style='cursor:pointer' onclick='pagebooks("+1+")'><a>首页</a></li>";
		}
		return p;
	}
	//判断和显示最后一页按钮;pages:总页数也是最后一页;pageNum:小于pages-5时显示
	function lastPage(isLastPage,pages,pageNum){
		var p = "";//“尾页按钮HTML代码”
		if(isLastPage == false && (pageNum < pages - 5)){
			p = "<li style='cursor:pointer' onclick='pagebooks("+pages+")'><a>尾页</a></li>";
		}
		return p;
	}
	
	function listWriters(){
		$.getJSON("${ctp}/writers/list",function(data){
			writersInfos = data;
			if(liststype){
				writershow(data);
			}else{
				showWriterInfos(data);
			}
			
		});
	}
	
	var gender = true;//价格变量，用于控制价格排序（升序、降序），TRUE表示升序、FALSE表示降序
	
	//用于价格的排序处理,url表示取出参数的URL
	function  ordergender(){
		$(":focus").css("color","#4CAF50");
		$(":focus span").css("color","#4CAF50");
		$(":focus").siblings("button").css("color","#666");
		$(":focus").siblings("button").children().css("color","#666");
		if(gender == true){
			getDataByURL(orderWriters(4,1));
			gender = false;//表示下一次点击要进行降序
		}else{getDataByURL(orderWriters(5,1));gender = true;}
	}
	
	function changeshowstyle(bool){
		if(bool == true){
			liststype = true;
			writershow(writersInfos);
			}else{
				liststype = false;
				showWriterInfos(writersInfos);
			}
	}

	$(document).ready(function(){
		listWriters();
	});
	
</script>


</head>
<body>
<c:import url="top.jsp"/>
	<div id="writers" class="container main">
	
	
		<div class="row" id="adress">
				<ol class="breadcrumb">
				  <li><a href="${ctp}">iread阅读</a></li>
				  <li><a href="${ctp}/writers" class="active">作家专栏</a></li>
				</ol>
				
			</div>
	
		<!-- 排序 -->
		<div id="worders" class="row">
			<div id="word" class="col-sm-10 col-lg-10 pull-left">
				
				<div class="btn-group btn-group-lg">
					<button type="button" class="btn btn-default" onclick="getDataByURL(orderWriters(0,1));">全部作家</button>
					<!-- <button type="button" class="btn btn-default" onclick="getDataByURL(orderWriters(1,1));">推荐作家<span class="glyphicon glyphicon-arrow-down"></span></button> -->
					<button type="button" class="btn btn-default" onclick="getDataByURL(orderWriters(2,1));">书籍销量<span class="glyphicon glyphicon-arrow-down"></span></button>
					<!-- <button type="button" class="btn btn-default" onclick="getDataByURL(orderWriters(3,1));">作品评分<span class="glyphicon glyphicon-arrow-down"></span></button> -->
					<button type="button" class="btn btn-default" onclick="ordergender();">男/女<span class="glyphicon glyphicon-resize-vertical"></span></button>
				</div>
				
			</div>
			<div id="wshow" class="col-sm-2 col-lg-2 pull-right btn-group btn-group-lg">
				<button type="button" class="btn btn-default" onclick="changeshowstyle(true);"><span class="glyphicon glyphicon-th-large"></span></button>
				<button type="button" class="btn btn-default" onclick="changeshowstyle(false);"><span class="glyphicon glyphicon-th-list"></span></button>
			</div>
		</div>
	
		<!-- 作家列表 -->
		<div id="writerslist">
			<!-- 一行数据 -->
			<%-- <div class="row writerslist">
				<!-- 一个数据 -->
				<div class="col-lg-3 col-sm-3" >
					<div class="infos_div">
						<div class="row ">
							<img src="${ctp}/resources/imgs/authors/default1.jpg" class='img-responsive col-lg-12 col-sm-12'>
						</div>
						<div class="winfos row">
								<span class="col-lg-1 col-sm-1"></span>
								<span class="wname col-lg-4 col-sm-4">作者姓名</span>
								<span class="col-lg-2 col-sm-2"></span>
								<span class='glyphicon glyphicon-thumbs-up col-lg-4 col-sm-4'></span>
								<span class="col-lg-1 col-sm-1"></span>
						</div>
					</div>		
				</div>
				
			</div> --%>
		</div>
		
		<!-- 分页栏 -->
		<div class="row" id="page">
			
		</div>
		
	</div>
<c:import url="bottom.jsp"/>
</body>
</html>