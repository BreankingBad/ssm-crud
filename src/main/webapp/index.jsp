<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>

<%  pageContext.setAttribute("APP_PATH",request.getContextPath()); %>

<!-- 	不以／开始的相对路径，以当前资源为基准，经常出错。
	已／开始的相对路径，以服务器的路径为基准（http://localhost:3306） -->
	
    <!-- 引入jQuery -->
    <script src="${APP_PATH}/static/js/jquery-3.2.0.min.js" type="text/javascript"></script>
    
    <!-- 引入Bootstrap -->
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container">
	  <div class="row">
	  	 <div class="col-md-12"><h1>crud</h1></div>
	 </div>
	 
	 <div class="row">
	  	 <div class="col-md-4 col-md-offset-8">
	  	 	<button class="btn btn-success">新增</button>
	  	 	<button class="btn btn-danger">删除</button>
	  	 </div>
	 </div>
	 
	 <div class="row">
	  	 <div class="col-md-12">
			<table class="table table-hover" id="emps_table">
				<thead> 
					<tr> 
						<th>#</th>
						<th>empName</th>
						<th>gender</th>
						<th>email</th>
						<th>deptName</th>
						<th>操作</th>
					</tr>
				</thead>
				
				<tbody>
					
				</tbody>


			</table>
		</div>
	</div>
	
	<div class="row">
		<div class="col-md-6" id="page_info_area">
 
		</div>

		<div class="col-md-6" id="page_num_area">
		</div>
	</div>
</div>

	
	<script type="text/javascript">
	
		// 页面加载后调用ajax请求得到json数据，根据json数据动态添加dom节点。
		$(function() {
			$.ajax({
				url:"${APP_PATH}/emps",
				data:"page=1",
				type:"get",
				success:function(result){
				/* 	console.log(result); */
					buildEmpsTable(result);
					buildPageInfo(result);
					buildPageNum(result);
				}
			});
		});
		
		function buildEmpsTable(result) {
			var emps = result.data.pageInfo.list;
			$.each(emps,function(index,item){
				// alert(item.empName); 
				
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var empGenderTd = $("<td></td>").append(item.gender=="M"?"男":"女");
				var empEmailTd = $("<td></td>").append(item.email);
				var empDepartmentTd = $("<td></td>").append(item.deptName);
				
				var editBtn = $("<button></button>").addClass("btn btn-success btn-sm").
				append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append(" 编辑");
				var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm").
				append($("<span></span>").addClass("glyphicon glyphicon-trash")).append(" 删除");
				var btnTd = $("<td></td>").append(editBtn).append(" ").append(deleteBtn);
				$("<tr></tr>").append(empIdTd)
							 .append(empNameTd)
							 .append(empGenderTd)
							 .append(empEmailTd)
							 .append(empDepartmentTd)
							 .append(btnTd)
							 .appendTo("#emps_table tbody");
			});
		}
		
		function buildPageInfo(result) {
			$("#page_info_area").append("当前页:").append(result.data.pageInfo.pageNum).append(",")
								.append("总页数:").append(result.data.pageInfo.pages).append(",")
								.append("总记录数:").append(result.data.pageInfo.total);
		}
		
		function buildPageNum(result) {
			
				var pageUl = $("<ul></ul>").addClass("pagination");
				var firstPageLi = $("<li></li>").append($("<a></a>").append($("<span></span>").append("首页")).attr("href","#"));
				var previousPageLi = $("<li></li>").append($("<a></a>").append($("<span></span>").append("&laquo;")).attr("href","#"));
				
				pageUl.append(firstPageLi);
				
				if(result.data.pageInfo.hasPreviousPage){
					pageUl.append(previousPageLi);
				}
				var pageNums = result.data.pageInfo.navigatepageNums;
				$.each(pageNums,function(index,item){
					var pageNumLi = $("<li></li>").append($("<a></a>").append($("<span></span>").append(item)).attr("href","#"));
					if(item == result.data.pageInfo.pageNum){
						pageNumLi.addClass("active");
					}
					pageUl.append(pageNumLi);
				});
				
				var nextPageLi = $("<li></li>").append($("<a></a>").append($("<span></span>").append("&raquo;")).attr("href","#"));
				var lastPageLi = $("<li></li>").append($("<a></a>").append($("<span></span>").append("末页")).attr("href","#"));
				pageUl.append(nextPageLi);
				if(result.data.pageInfo.hasNextPage){
					pageUl.append(lastPageLi);
				}
				
				$("<nav></nav>").append(pageUl)
							 .appendTo("#page_num_area");
			
		}
	</script>
</body>
</html>