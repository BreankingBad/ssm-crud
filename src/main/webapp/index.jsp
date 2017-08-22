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

<!-- 添加员工的模态框 -->
<div class="modal fade" tabindex="-1" role="dialog" id="addEmpModal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">员工添加</h4>
      </div>
      <div class="modal-body">
	      <form class="form-horizontal" id="addEmpForm">
			  <div class="form-group">
			    <label class="col-sm-2 control-label">员工名字</label>
			    	<div class="col-sm-10">
			      <input type="text" name="empName" class="form-control" id="empNameInput" placeholder="员工名字">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">员工邮箱</label>
			    	<div class="col-sm-10">
			    		<input type="text" name="email" class="form-control" id="empEmailInput" placeholder="员工邮箱">
			    		<span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">员工性别</label>
			    	<div class="col-sm-10">
			    		<label class="radio-inline">
					  <input type="radio" name="gender" id="genderMaleRadio" value="M" checked="checked"> 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="genderFeMaleRadio" value="F"> 女
					</label>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">部门</label>
			    	<div class="col-sm-4">
			    		<select class="form-control" name="dId" id="departmentSelect">
					</select>
			    </div>
			  </div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="saveEmpBtn">保存</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div class="container">
	  <div class="row">
	  	 <div class="col-md-12"><h1>crud</h1></div>
	 </div>
	 
	 <div class="row">
	  	 <div class="col-md-4 col-md-offset-8">
	  	 	<button class="btn btn-success" id="addEmpBtn">新增</button>
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
			toPage(1);
		});
		
		function toPage(pageNum) {
			$.ajax({
				url:"${APP_PATH}/emps",
				data:"page="+pageNum,
				type:"get",
				success:function(result){
				/* 	console.log(result); */
					buildEmpsTable(result);
					buildPageInfo(result);
					buildPageNum(result);
				}
			});
		}
		
		function buildEmpsTable(result) {
			// 先清空
			$("#emps_table tbody").empty();
			
			var emps = result.data.pageInfo.list;
			$.each(emps,function(index,item){
				// alert(item.empName); 
				
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var empGenderTd = $("<td></td>").append(item.gender=="M"?"男":"女");
				var empEmailTd = $("<td></td>").append(item.email);
				var empDepartmentTd = $("<td></td>").append(item.department.deptName);
				
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
			// 先清空
			$("#page_info_area").empty();
			
			$("#page_info_area").append("当前页:").append(result.data.pageInfo.pageNum).append(",")
								.append("总页数:").append(result.data.pageInfo.pages).append(",")
								.append("总记录数:").append(result.data.pageInfo.total);
		}
		
		function buildPageNum(result) {
				// 先清空
				$("#page_num_area").empty();
			
				var currentPageNum = result.data.pageInfo.pageNum;
				
				var pageUl = $("<ul></ul>").addClass("pagination");
				var firstPageLi = $("<li></li>").append($("<a></a>").append($("<span></span>").append("首页")).attr("href","#"));
				var previousPageLi = $("<li></li>").append($("<a></a>").append($("<span></span>").append("&laquo;")).attr("href","#"));
				
				firstPageLi.click(function() {
					toPage(1);
				});
				previousPageLi.click(function() {
					toPage(currentPageNum-1);
				});
				
				pageUl.append(firstPageLi);
				if(result.data.pageInfo.hasPreviousPage){
					pageUl.append(previousPageLi);
				}else {
					firstPageLi.addClass("disabled");
				}
				
				var pageNums = result.data.pageInfo.navigatepageNums;
				$.each(pageNums,function(index,item){
					var pageNumLi = $("<li></li>").append($("<a></a>").append($("<span></span>").append(item)).attr("href","#"));
					if(item == currentPageNum){
						pageNumLi.addClass("active");
					}
					pageNumLi.click(function() {
						toPage(item);
					});
					pageUl.append(pageNumLi);
				});
				
				var nextPageLi = $("<li></li>").append($("<a></a>").append($("<span></span>").append("&raquo;")).attr("href","#"));
				var lastPageLi = $("<li></li>").append($("<a></a>").append($("<span></span>").append("末页")).attr("href","#"));
				
				nextPageLi.click(function() {
					toPage(currentPageNum+1);
				});
				lastPageLi.click(function() {
					toPage(result.data.pageInfo.pages);
				});
				
				if(result.data.pageInfo.hasNextPage){
					pageUl.append(nextPageLi);
				}else {
					lastPageLi.addClass("disabled");
				}
				pageUl.append(lastPageLi);
				
				$("<nav></nav>").append(pageUl)
							 .appendTo("#page_num_area");
		}
		
		$("#addEmpBtn").click(function() {
			
			// 表单重置
			$('#addEmpForm')[0].reset();
			
			getDepts();
			
			$('#addEmpModal').modal({
				backdrop:'static'
			});
		});
		
		function getDepts() {
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"get",
				success:function(result){
					console.log(result); 
					$.each(result.data.depts,function(){
						$("<option></option>").append(this.deptName).attr("value",this.deptId)
											 .appendTo($("#departmentSelect"));
					});
				}
			});
		}
		
		function checkFormValid() {
			var nameValue = $("#empNameInput").val();
			var nameReg = /(^[a-z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if(!nameReg.test(nameValue)){
				showCheckMsg("#empNameInput","error","用户名不合法！");
				return false;
			}else{
				showCheckMsg("#empNameInput","success","");
			}
			
			var emailValue = $("#empEmailInput").val();
			var emailReg = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!emailReg.test(emailValue)){
				showCheckMsg("#empEmailInput","error","邮箱不合法！");
				return false;
			}else{
				showCheckMsg("#empEmailInput","success","");
			}
			
			return true;
		}
		
		function showCheckMsg(ele,status,msg) {
			$(ele).parent().removeClass("has-success");
			$(ele).parent().removeClass("has-error");
			$(ele).next("span").text("");
			if("success"==status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if ("error"==status) {
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
			
		}
		
		$("#saveEmpBtn").click(function() {
			if($("#saveEmpBtn").attr("check_result") == "error"){
				return false;
			}
			
			if(checkFormValid()){
				$.ajax({
					url:"${APP_PATH}/emp",
					type:"POST",
					data:$("#addEmpForm").serialize(),
					success:function(result){
						$("#addEmpModal").modal('hide');
						toPage(9999999);
					}
				});	 
			}
		});
		
		$("#empNameInput").change(function() {
			var value = $("#empNameInput").val();
			$.ajax({
				url:"${APP_PATH}/checkEmp",
				type:"POST",
				data:"empName="+value,
				success:function(result){
					if(result.code == 100){
						showCheckMsg("#empNameInput","success","用户名可用");
						$("#saveEmpBtn").attr("check_result","success");
					}else {
						showCheckMsg("#empNameInput","error","用户名已存在！");
						$("#saveEmpBtn").attr("check_result","error");
					}
				}
			});	 
		});
	</script>
</body>
</html>