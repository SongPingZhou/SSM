<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="../js/global.js"></script>
<script type="text/javascript">
	$(function(){
		init();
	})
	function init(){
		$('#dg').datagrid({    
		    url:"../selectStuAll",  
		    method:"post",
		    fitColumns:true,
		    pagination:true,
		    singleSelect:true,
		    
		    toolbar:"#stuTab",
		    queryParams: {
		    	s_name:$("#s_name").val(),
		    	s_iphone:$("#s_iphone").val(),
		    	a_askerId:$("#a_askerId").val(),
		    	s_ispay:$("#s_ispay").combobox("getValue"),
		    	s_isValid:$("#s_isValid").combobox("getValue"),
		    	s_isreturnVist:$("#s_isreturnVist").combobox("getValue"),
		    	s_qq:$("#s_qq").val(),
		    	
		    	mins_createTime:$("#mins_createTime").datebox("getValue"),
		    	maxs_createTime:$("#maxs_createTime").datebox("getValue"),
		    	mins_homeTime:$("#mins_homeTime").datebox("getValue"),
		    	maxs_homeTime:$("#maxs_homeTime").datebox("getValue"),
		    	mins_fistVisitTime:$("#mins_fistVisitTime").datebox("getValue"),
		    	maxs_fistVisitTime:$("#maxs_fistVisitTime").datebox("getValue"),
		    	mins_paytime:$("#mins_paytime").datebox("getValue"),
		    	maxs_paytime:$("#maxs_paytime").datebox("getValue"),
		    	mins_inClassTime:$("#mins_inClassTime").datebox("getValue"),
		    	maxs_inClassTime:$("#maxs_inClassTime").datebox("getValue")
			}
		});  
	}
	
	
	
	function formattercaozuo(value,row,index){
		return "<a href='javascript:void(0)' onclick='updateStu("+index+")'>编辑</a>   "+
				"<a href='javascript:void(0)' onclick='deleteStu("+index+")'>删除</a>   "+
				"<a href='javascript:void(0)' onclick='lookStu("+index+")'>查看</a>";
	}
	
	function formattershezhi(value,row,index){
		return "<a href='javascript:void(0)' onclick='genzong("+index+")'>跟踪</a>    <a href='javascript:void(0)' onclick='rizhi("+index+")'>日志</a>"
	}
	
	function formattergengduo(value,row,index){
		return "<a href='javascript:void(0)' onclick='many("+index+")'>更</a>";
	}

	
	function many(index){
		$("#diaUserRoles").window("open");
	}
	
	function insertStudent(d){
		/* 每次打开都清空form数据 */
		$("#stuForm").form("clear");
		/* 显示提交按钮 */
		$("#tj").show();
		/* 对添加时赋值1表示执行添加 */
		$("#mark").val("1");
		/* 修改标题并打开 */
		$("#stu_dialog").dialog({title:'添加学生'}).dialog("open");
	}
	
	
	function addStu(){
		$.ajax({
			url:"../insertStu",
			method:'post',
			data:$("#stuForm").serializeArray(),
			success:function(res){
				$("#dg").datagrid("reload");
				ClearStu();
				$.messager.alert("提示信息","添加成功");
			}
		},"json");
	}
	
	
	/* 删除 */
	function deleteStu(index){
		var data=$("#dg").datagrid("getData");
		$.messager.confirm('确认','您确认想要删除记录吗？',function(r){    
		    if (r){    
		    	$.ajax({
		        	url:'../deleteStu',
		        	method:'post',
		        	data:{s_id:data.rows[index].s_id},
		        	dataType:'json',
		        	success:function(res){
		        		if(res>0){
		        			$("#dg").datagrid("reload");
		        			$.messager.alert("提示信息","删除成功");
		        		}
		        	}
		        })
		    }    
		}); 
	}
	
	
	function updateStu(index){
		/* 每次打开都清空form数据 */
		$("#stuForm").form("clear");
		/* 显示提交按钮 */
		$("#tj").show();
		
		/* 获取选择的表单数据 */
		var data = $("#dg").datagrid("getData");
		$("#stuForm").form("load",data.rows[index]);
		
		/* 对表示input进行赋值，标识框主要用来在后面提交时判断url的 */
		$("#mark").val("2");
		
		/* 修改标题并打开 */
		$("#stu_dialog").dialog({title:'编辑学生'}).dialog("open");
	}
	
	function editStu(){
		$.ajax({
			url:"../updateStu",
			method:'post',
			data:$("#stuForm").serializeArray(),
			success:function(res){
				$("#dg").datagrid("reload");
				ClearStu();
				$.messager.alert("提示信息","修改成功");
			}
		},"json");
	}
	
	
	function lookStu(index){
		var data = $("#dg").datagrid("getData");
			$.ajax({
	        	url:"../selectStuByid",
	        	method:'post',
	        	data:{s_id:data.rows[index].s_id},
	        	dataType:'json',
	        	success:function(res){
	        		if(res!=null){
	        			/* 清空form数据 */
	        			$("#stuForm").form("clear");
	        			/* 隐藏提交按钮 */
	        			$("#tj").hide();
	        			$("#stuForm").form("load",res);/* 对form赋值 */
	        			$("#stu_dialog").dialog({title:'查看学生信息'}).dialog("open");
	        		}
	        	}
	        })
		} 
	
	
	/* 提交添加Student */
	function SaveStu(){
		/* 判断使用那个方法提交 */
		$("#mark").val() == "1" ? addStu() : ($("#mark").val() == "2" ? editStu() : null);
	}
	
	function ClearStu(){
		$("#stu_dialog").dialog("close");
	}
	
	
	
	
	/* function Save_Excel(){
		var data=$("#dg").datagrid("getData");
		var title=$("#dg").datagrid("getColumnFields");
		var d=title+"";
		$.ajax({
			url:'ExcelDc',
			method:'post',
			data:{stulist:JSON.stringify(data.rows),title:d},
			success:function(res){
				 $.messager.alert("提示信息","生成表格成功E：盘 查看");  
			}
		},"json")
	}
	
	function daochu(){
		var data=$("#dg").datagrid("getData");
		var title=$("#dg").datagrid("getColumnFields");
		var d=title+"";
		window.location.href="daochu?stulist="+JSON.stringify(data.rows)+"&title="+d;
	} */
	
</script>
</head>
<body>

<div id="diaUserRoles" class="easyui-window" data-options="modal:true,iconCls:'icon-save',collapsible:false,minimizable:false,maximizable:false,closed:true" style="width: auto;height: auto;top: 30px;">
	<table style="margin-top: 20px; margin-left: 20px; margin-right: 20px;">
		<tr>
			<td>
				<table  id="allRoles" class="easyui-datagrid"  title="系统所有角色" data-options="rownumbers:true,singleSelect:true,method:'post'" style="width: 150px;">
					<thead>
						<tr>
							<th data-options="field:'Id',width:80,hidden:true">ID</th>
							<th data-options="field:'Name',width:100">名称</th>
							
						</tr>
						
					</thead>
				</table>
			</td>
			<td>
				<a href="javascript:void(0)" onclick="adddiaUserRoles()" class="easyui-linkbutton" style="width: 40px;">>></a>
				<br />
				<br />
				<a href="javascript:void(0)" onclick="removediaUserRoles()" class="easyui-linkbutton" style="width: 40px;" ><<</a>
			</td>
			<td>
				<table  id="allUserRoles" class="easyui-datagrid"  title="当前用户的角色" data-options="rownumbers:true,singleSelect:true,method:'post'" style="width: 150px;">
					<thead>
						<tr>
							<th data-options="field:'Id',width:80,hidden:true">ID</th>
							<th data-options="field:'Name',width:100">名称</th>
						</tr>
					</thead>
				</table>
			</td>
			<td></td>
		</tr>
	</table>
</div>
	<table id="dg" class="easyui-datagrid">   
	    <thead>   
	        <tr>
	            <th data-options="field:'s_id'">编号</th>   
	            <th data-options="field:'s_name'">姓名</th>   
	            <th data-options="field:'s_age'">年龄</th>
	            <th data-options="field:'s_sex'">性别</th>
	            <th data-options="field:'s_iphone'">手机号</th>
	            <th data-options="field:'s_state'">s_state</th>   
	            <th data-options="field:'s_source'">s_source</th>   
	            <th data-options="field:'s_courceurl'">s_courceurl</th>  
	            <th data-options="field:'s_keywords'">s_keywords</th>   
	            <th data-options="field:'s_address'">s_address</th>   
	            <th data-options="field:'s_netpusherld'">s_netpusherld</th>
	            <th data-options="field:'a_askerId'">a_askerId</th>
	            
	          	<th data-options="field:'gengduo',width:'80px',formatter:formattergengduo">...</th>
	            
	           
	            <th data-options="field:'caozuo',width:'80px',formatter:formattercaozuo">操作</th>
	            
	            <th data-options="field:'shezhi',width:'80px',formatter:formattershezhi">设置</th>
	           
	            
	        </tr>   
	    </thead>   
	</table>
	<div id="stuTab" class="easyui-dialog" data-options="resizable:true,modal:true,closed:true">   
		<form id="ff" method="post">   
		
			<a id="btn" href="javascript:void(0)" onclick="daochu()" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true">自选导出</a>
			<a id="btn" href="javascript:void(0)" onclick="Save_Excel()" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true">导入：E盘</a>
			
		        <label for="name">姓名:</label>   
		        <input class="easyui-validatebox" type="text" id="s_name" />   
		      
		        <label for="name">电话:</label>   
		        <input class="easyui-validatebox" type="text" id="s_iphone" />   
		  
		     
		        <label for="name">咨询师:</label>   
		        <input class="easyui-validatebox" type="text" id="a_askerId" /> 
		        
		        <label for="name">QQ:</label>   
		        <input class="easyui-validatebox" type="text" id="s_qq" />    
		   		<br>
		  		
		  		 
		        <label for="name">是否缴费:</label>   
		        <select class="easyui-combobox" style="width: 100px" id="s_ispay"> 
				    <option value="">-- 请选择 --</option>
				    <option value="已缴费">已缴费</option>   
				    <option value="未缴费">未缴费</option>   
				</select>
			    
		     	
		     	<label for="name">是否有效:</label>   
		        <select class="easyui-combobox" style="width: 100px" id="s_isValid"> 
				    <option value="">-- 请选择 --</option>
				    <option value="有效">有效</option>   
				    <option value="无效">无效</option>   
				</select>   
		          
		      	<label for="name">是否回访:</label>   
		        <select class="easyui-combobox" style="width: 100px" id="s_isreturnVist"> 
				   	<option value="">-- 请选择 --</option>
				    <option value="已回访">已回访</option>   
				    <option value="未回访">未回访</option>   
				</select>
		        <br>
		       
		         
		     
		        <label for="name">创建时间:</label>   
		        <input class="easyui-datebox" type="text" id="mins_createTime" />~
		        <input class="easyui-datebox" type="text" id="maxs_createTime" />   
		      
		        <label for="name">上门时间:</label>   
		        <input class="easyui-datebox" type="text" id="mins_homeTime" />~
		        <input class="easyui-datebox" type="text" id="maxs_homeTime" />   
		     	<br>
		     	
		        <label for="name">受访时间:</label>   
		        <input class="easyui-datebox" type="text" id="mins_fistVisitTime" />~   
		        <input class="easyui-datebox" type="text" id="maxs_fistVisitTime" />   
		      
		        <label for="name">缴费时间:</label>   
		        <input class="easyui-datebox" type="text" id="mins_paytime" />~
		        <input class="easyui-datebox" type="text" id="maxs_paytime" />      
		      	<br>
		      
		        <label for="name">进班时间:</label>   
		        <input class="easyui-datebox" type="text" id="mins_inClassTime" />~
		        <input class="easyui-datebox" type="text" id="maxs_inClassTime" />   
		       	<br>
		    
		    <a id="btn" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="init()">搜索</a>
		    <a id="btna" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="insertStudent(1)">添加</a>
		</form>   
	</div> 
	
	
	<div id="stu_dialog" class="easyui-dialog" data-options="resizable:true,modal:true,closed:true,draggable:true">   
		<form id="stuForm" method="post">   
			<input type="hidden" id="mark"/>
			<div>
				<input type="hidden" name="s_id" />
			</div>
		    <div>   
		        <label for="name">s_name:</label>   
		        <input class="easyui-validatebox" type="text" name="s_name" />   
		    </div>   
		    <div>   
		        <label for="name">s_age:</label>   
		        <input class="easyui-validatebox" type="text" name="s_age" />   
		    </div>  
		    <div>   
		        <label for="name">s_sex:</label>   
		        <input class="easyui-validatebox" type="text" name="s_sex" />   
		    </div>   
		    <div>   
		        <label for="name">s_iphone:</label>   
		        <input class="easyui-validatebox" type="text" name="s_iphone" />   
		    </div>  
		    <div>   
		        <label for="name">s_state:</label>   
		        <input class="easyui-validatebox" type="text" name="s_state" />   
		    </div>   
		    <div>   
		        <label for="name">s_source:</label>   
		        <input class="easyui-validatebox" type="text" name="s_source" />   
		    </div>  
		    <div>   
		        <label for="name">s_courceurl:</label>   
		        <input class="easyui-validatebox" type="text" name="s_courceurl" />   
		    </div>   
		    <div>   
		        <label for="name">s_keywords:</label>   
		        <input class="easyui-validatebox" type="text" name="s_keywords" />   
		    </div>  
		    <div>   
		        <label for="name">s_address:</label>   
		        <input class="easyui-validatebox" type="text" name="s_address" />   
		    </div>  
		    <div>   
		        <label for="name">s_netpusherld:</label>   
		        <input class="easyui-validatebox" type="text" name="s_netpusherld" />   
		    </div>   
		    <div>   
		        <label for="name">a_askerId:</label>   
		        <input class="easyui-validatebox" type="text" name="a_askerId" />   
		    </div>  
		    <div>   
		        <label for="name">s_qq:</label>   
		        <input class="easyui-validatebox" type="text" name="s_qq" />   
		    </div>   
		    <div>   
		        <label for="name">s_wx:</label>   
		        <input class="easyui-validatebox" type="text" name="s_wx" />   
		    </div>  
		    <div>   
		        <label for="name">s_content:</label>   
		        <input class="easyui-validatebox" type="text" name="s_content" />   
		    </div>   
		    <div>   
		        <label for="name">s_createTime:</label>   
		        <input class="easyui-validatebox" type="text" name="s_createTime" />   
		    </div>  
		    <div>   
		        <label for="name">s_learnforward:</label>   
		        <input class="easyui-validatebox" type="text" name="s_learnforward" />   
		    </div>   
		    <div>   
		        <label for="name">s_isValid:</label>   
		        <input class="easyui-validatebox" type="text" name="s_isValid" />   
		    </div>  
		    <div>   
		        <label for="name">s_record:</label>   
		        <input class="easyui-validatebox" type="text" name="s_record" />   
		    </div>   
		    <div>   
		        <label for="name">s_isreturnVist:</label>   
		        <input class="easyui-validatebox" type="text" name="s_isreturnVist" />   
		    </div>  
		    <div>   
		        <label for="name">s_fistVisitTime:</label>   
		        <input class="easyui-validatebox" type="text" name="s_fistVisitTime" />   
		    </div>   
		    <div>   
		        <label for="name">s_ishome:</label>   
		        <input class="easyui-validatebox" type="text" name="s_ishome" />   
		    </div>  
		    <div>   
		        <label for="name">s_homeTime:</label>   
		        <input class="easyui-validatebox" type="text" name="s_homeTime" />   
		    </div>   
		    <div>   
		        <label for="name">s_lostValid:</label>   
		        <input class="easyui-validatebox" type="text" name="s_lostValid" />   
		    </div>  
		    <div>   
		        <label for="name">s_ispay:</label>   
		        <input class="easyui-validatebox" type="text" name="s_ispay" />   
		    </div>   
		    <div>   
		        <label for="name">s_paytime:</label>   
		        <input class="easyui-validatebox" type="text" name="s_paytime" />   
		    </div>  
		    <div>   
		        <label for="name">s_money:</label>   
		        <input class="easyui-validatebox" type="text" name="s_money" />   
		    </div>   
		    <div>   
		        <label for="name">s_isReturnMoney:</label>   
		        <input class="easyui-validatebox" type="text" name="s_isReturnMoney" />   
		    </div>  
		    <div>   
		        <label for="name">s_returnMoneyTime:</label>   
		        <input class="easyui-validatebox" type="text" name="s_returnMoneyTime" />   
		    </div>   
		    <div>   
		        <label for="name">s_isInClass:</label>   
		        <input class="easyui-validatebox" type="text" name="s_isInClass" />   
		    </div>  
		    <div>   
		        <label for="name">s_inClassTime:</label>   
		        <input class="easyui-validatebox" type="text" name="s_inClassTime" />   
		    </div>   
		    <div>   
		        <label for="name">s_inClassContent:</label>   
		        <input class="easyui-validatebox" type="text" name="s_inClassContent" />   
		    </div>
		    <div>   
		        <label for="name">s_askerContent:</label>   
		        <input class="easyui-validatebox" type="text" name="s_askerContent" />   
		    </div>   
		    <div>   
		        <label for="name">s_isdel:</label>   
		        <input class="easyui-validatebox" type="text" name="s_isdel" />   
		    </div>
		    <div>   
		        <label for="name">s_fromPart</label>   
		        <input class="easyui-validatebox" type="text" name="s_fromPart" />   
		    </div>   
		    <div>   
		        <label for="name">s_stuConcern:</label>   
		        <input class="easyui-validatebox" type="text" name="s_stuConcern" />   
		    </div>
		    <div>   
		        <label for="name">s_isbaobei:</label>   
		        <input class="easyui-validatebox" type="text" name="s_isbaobei" />   
		    </div>   
		    <div>   
		        <label for="name">s_zixunName:</label>   
		        <input class="easyui-validatebox" type="text" name="s_zixunName" />   
		    </div> 
		    <div>   
		        <label for="name">s_createUser:</label>   
		        <input class="easyui-validatebox" type="text" name="s_createUser" />   
		    </div> 
		    <div>   
		        <label for="name">s_returnMoneyReason:</label>   
		        <input class="easyui-validatebox" type="text" name="s_returnMoneyReason" />   
		    </div> 
		    <div>   
		        <label for="name">s_preMoney:</label>   
		        <input class="easyui-validatebox" type="text" name="s_preMoney" />   
		    </div>  
		    <div>   
		        <label for="name">s_preMoneyTime:</label>   
		        <input class="easyui-validatebox" type="text" name="s_preMoneyTime" />   
		    </div>  
		    <div>   
		        <label for="name">u_id:</label>   
		        <input class="easyui-validatebox" type="text" name="u_id" />   
		    </div>  
		</form>   
		<div id="tj" style="text-align: center; padding:3px">
			<a id="btn" href="javascript:void(0)" onclick="SaveStu()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">提交</a>  
			<a id="btn" href="javascript:void(0)" onclick="ClearStu()" class="easyui-linkbutton" data-options="iconCls:'icon-clear'">取消</a>  
		</div>
	</div> 
</body>
</html>