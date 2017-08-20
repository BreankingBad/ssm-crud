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
    <script src="${APP_PATH}/static/js/jquery-3.2.0.min.js"></script>
    
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
			<table class="table table-hover">
				<tr> 
					<th>#</th>
					<th>empName</th>
					<th>gender</th>
					<th>email</th>
					<th>deptName</th>
					<th>操作</th>
				</tr>
				<c:forEach items="${pageInfo.list}" var="emp">
					<tr> 
						<td>${emp.empId}</td>
						<td>${emp.empName}</td>
						<td>${emp.gender=="M"?"男":"女"}</td>
						<td>${emp.email}</td>
						<td>${emp.department.deptName}</td>
						<td>
							<button class="btn btn-success btn-sm">
							<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> 编辑</button>
							<button class="btn btn-danger btn-sm">
							<span class="glyphicon glyphicon-trash" aria-hidden="true"></span> 删除</button>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	
	<div class="row">
		<div class="col-md-6">
			当前页:${pageInfo.pageNum},总页数:${pageInfo.pages},总记录数:${pageInfo.total} 
		</div>
		<div class="col-md-6">
			<nav aria-label="Page navigation">
				  <ul class="pagination">
				  <li><a href="#">首页</a></li>
				    <li>
				      <a href="#" aria-label="Previous">
				        <span aria-hidden="true">&laquo;</span>
				      </a>
				    </li>
				    <c:forEach items="${pageInfo.navigatepageNums}" var="page_num">
				    		<c:if test="${page_num == pageInfo.pageNum}">
				    			<li class="active"><a href="#">${page_num}</a></li>
				    		</c:if>
				    		<c:if test="${page_num != pageInfo.pageNum}">
				    			<li><a href="${APP_PATH}/emps?page=${page_num}">${page_num}</a></li>
				    		</c:if>
				    		
				    </c:forEach>
				    <li>
				      <a href="#" aria-label="Next">
				        <span aria-hidden="true">&raquo;</span>
				      </a>
				    </li>
				    <li><a href="#">末页</a></li>
				  </ul>
			</nav>
		</div>
	</div>
</div>

</body>
</html>