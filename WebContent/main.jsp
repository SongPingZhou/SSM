<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		<script src="js/global.js"></script>  
		<script>
		//树形结构显示
	    $(function(){
	    	var roleName=globalData.getCurRoleNames();
	    	$("#spName").text(globalData.getCurUName());
	        $.post(globalData.server+"GetSysRightsHtmlTreeString",{
	            roleNames:roleName,//传递的参数
	            treeUlId:"treeUlId", //这是个固定的参数，只要和下边navTab中对应起来即可。
	            token:globalData.token //
	            },
	            function(res){ //res是返回的html代码
	                $("#menuTree").jsp(res);  
	                $("#treeUlId").tree(); //让easyUI引擎重新将treeUIId中的html代码转变成树并显示
	            });
	    });  
    //树状结构的节点是否已在中部显示，参数re是标题，html 是路径
    function navTab(re, html) {
        var flag = $("#tt").tabs('exists', re);
        $('#treeUlId').tree({ //和前边加载数据的代码中的"treeUIId"参数,保持一致即可
            onSelect:function(node){
                var isLeaf = $('#treeUlId').tree('isLeaf',node.target); //是否是叶子节点
                if (isLeaf) {//只有叶子节点才会在选项卡中创建选项页（每个选项页对应1个功能）
                    if(!flag) {
                        $('#tt').tabs('add', { //在选项卡中，创建1个选项页
                            title: re,   //选项卡中，选项页的标题（在同一个选项卡中，选项页需要保持一致）。
                            closable: true,
                            content: "<iframe  src='"+html+"' style='height:100%;width:100%'/>"    //此处做了调整，推荐使用iframe的方式实现
                       });
                    } else {
                        $("#tt").tabs('select', re); //直接选中title对应的选项卡
                    }
                }
            }
        });
    }
    function tuichu(){
    	$.messager.confirm("确认","你确认要推出当前页面吗？",function(r){
    		if(r){
	    		sessionStorage.clear();
	    		window.location.href="index.jsp";
    		}
    	});
    }
		</script>
	</head>
	<body> 
		<div style="margin:20px 0;"></div>
	    <div class="easyui-layout" style="width:100%;height:700px;">
	        <div data-options="region:'north'" style="height:50px">
	        	CRM系统&nbsp;&nbsp;欢迎您：<span id="spName"></span>&nbsp;&nbsp;
	        	<a id="btn" href="javascript:void" onclick="tuichu()" style="cursor:pointer">安全退出</a>
	        </div>
	        <div data-options="region:'south',split:true" style="height:50px;"></div>
	        <div daata-options="region:'east',split:true,collapsed:true,title:'East'" style="width:150px;padding:10px;">东部区域</div>
		        <div data-options="region:'west',split:true" title="导航应用" style="width:150px;">
		           <div id="menuTree" ><!--这个地方显示树状结构-->
		           		
		           </div>
		        </div>
	        
	        <div id="center_1" data-options="region:'center',iconCls:'icon-ok'"">
	            <div id="tt" class="easyui-tabs" data-options="fit:true"> <!--这个地方采用tabs控件进行布局-->
	             	
	            </div>
	        </div>
	    </div>
	</body>
</html>
