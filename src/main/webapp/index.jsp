<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 杨少帅
  Date: 2021/8/11
  Time: 18:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    pageContext.setAttribute("app_path", request.getContextPath());
%>
<html>
<head>
    <title>员工列表</title>
    <script src=${app_path}/static/jq/jquery-1.9.1.js type="text/javascript"></script>
    <link rel="stylesheet" href="${app_path}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css"/>
    <script src="${app_path}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
</head>
<body>
<%--员工添加模态框--%>
<div class="modal fade" id="empAddModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add"  class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text"  name="empName" class="form-control" id="empName_add" placeholder="empName">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="empName_add" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add" placeholder="email">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="empName_add" class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_male" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_female" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="empName_add" class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-4">
                            <select class="form-control"  id="dept_select" name="dId">

                            </select>
                        </div>
                    </div>


                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<%--员工修改模态框--%>
<div class="modal fade" id="empUpdateModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" >员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add"  class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="empName_add" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update" placeholder="email">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="empName_add" class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_male_up" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_female_update" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="empName_add" class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-4">
                            <select class="form-control" id="dept_select_update" name="dId">

                            </select>
                        </div>
                    </div>


                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <%--        标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--            按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button type="button" class="btn btn-info" id="emp_add_model_btn">新增</button>
            <button type="button" class="btn btn-danger" id="delAll_btn">删除</button>
        </div>
    </div>
    <%--        显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
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
    <%--    显示分页信息--%>
    <div class="row">
        <%--            分页文字信息--%>
        <div class="col-md-6" id="page_info"></div>
        <%--    分页条--%>
        <div class="col-md-6" id="page_info_nav"></div>
    </div>
</div>
<script type="text/javascript">
    var totalpage,currentPage;
    $(function () {
        toPage(1);
    });

    function toPage(pn) {
        $.ajax(
            {
                url: "${app_path}/emps",
                data: "pn=" + pn,
                type: "GET",
                success: function (result) {
                    //    1,解析并显示员工数据
                    build_emps_table(result);
                    //    2，解析并显示分页信息
                    build_page_info(result);
                    //   3,解析显示分页数据
                    build_page_nav(result);
                }
            }
        );
    }

    function build_emps_table(result) {
        //清空数据
        $("#emps_table tbody").empty();

        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var gender = item.gender == 'M' ? "男" : "女";
            var empGenderTd = $("<td></td>").append(gender);
            var empEmailTd = $("<td></td>").append(item.email);
            var empDeptTd = $("<td></td>").append(item.department.deptName);
            //按钮
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            editBtn.attr("edit_id",item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            delBtn.attr("del_id",item.empId);
            $("<tr></tr>").append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(empGenderTd)
                .append(empEmailTd)
                .append(empDeptTd)
                .append(editBtn)
                .append("&ensp;")
                .append(delBtn)
                .appendTo("#emps_table tbody");
        });
    }

    //解析显示分页信息
    function build_page_info(result) {
        $("#page_info").empty();
        var pageNum = result.extend.pageInfo.pageNum;
        var pageTotal = result.extend.pageInfo.total;
        var pagesNum = result.extend.pageInfo.pages;
        $("#page_info").append("当前" + pageNum + "页,总" + pagesNum + "页,总" + pageTotal + "条记录");
        totalpage = pagesNum;
        currentPage=pageNum;
    }

    function build_page_nav(result) {
        $("#page_info_nav").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<Li></Li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<Li></Li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            firstPageLi.click(function () {
                toPage(1);
            });
            prePageLi.click(function () {
                var pre = result.extend.pageInfo.pageNum;
                toPage(pre - 1);
            });
        }

        var nextPageLi = $("<Li></Li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<Li></Li>").append($("<a></a>").append("末页").attr("href", "#"));


        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            nextPageLi.click(function () {
                toPage(result.extend.pageInfo.pageNum + 1);
            });
            lastPageLi.click(function () {
                toPage(result.extend.pageInfo.pages);
            });
        }
        ul.append(firstPageLi).append(prePageLi);


        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<Li></Li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                toPage(item);
            });
            ul.append(numLi);
        });
        ul.append(nextPageLi).append(lastPageLi);

        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_info_nav");
    }
    //查出所有部门的信息并显示在下拉列表中
    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url: "${app_path}/depts",
            type:"get",
            success:function(result){
                $.each(result.extend.depts,function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }
    function reset_form(ele) {
        $(ele)[0].reset();
        $(ele).find("*").removeClass("has_error has_success");
        $(ele).find(".help-block").text("");
    }
    var fun =$("#emp_add_model_btn").click(function () {
        reset_form("#empAddModel form")
        $("#dept_select").empty();
        getDepts("#dept_select");
        $("#empAddModel").modal({
            backdrop:"static"
        });
    });
    jQuery(fun);
    //校验表单数据是否合法
    function validate_data_form(){
        var empName = $("#empName_add").val();
        var regName = 	/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u4e00-\u9fa5]{2,5})/;
        if(!regName.test(empName)){
         // alert("用户名可以是2-5位中文或者6-16英文");
            show_vaildate_msg("#empName_add","error","用户名是2-5位中文或者6-16英文");
          return false;
        }else {
           show_vaildate_msg("#empName_add","success","");
        }
        var email = $("#email_add").val();
        var regEmail = 	/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            //alert("邮箱格式不正确");
            show_vaildate_msg("#email_add","error","邮箱格式不正确");
            return  false;
        }else {
            show_vaildate_msg("#email_add","success","");
        }
        return  true;
    }

    function show_vaildate_msg(ele,status,msg){
        $(ele).parent().removeClass("has_success has_error");
        $(ele).next("span").text("");
        if("success"==status){
            $(ele).parent().addClass("has_success");
            $(ele).next("span").text(msg);
        }else if("error"==status) {
            $(ele).parent().addClass("has_error");
            $(ele).next("span").text(msg);

        }
    }
    $("#empName_add").change(function () {
        var empName = this.value;
        $.ajax({
            url:"${app_path}/checkUser",
            data:"empName="+empName,
            type:"post",
            success:function (result) {
                if(result.code==100){
                    $("#emp_save_btn").attr("ajax_va","success");
                    show_vaildate_msg("#empName_add","success","用户名可用");
                }else {
                    show_vaildate_msg("#empName_add","error",result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax_va","error");
                }
            }
        });
    });
    $("#emp_save_btn").click(function () {

        if(!validate_data_form()){
           return false;
        }

        if($(this).attr("ajax_va")=="error"){
            return false;
        }
        //ajax请求保存员工
        $.ajax({
            url:"${app_path}/emp",
            type:"post",
            data:$("#empAddModel form").serialize(),
            success:function (result) {
                if(result.code==100){

                    //关闭模态框
                    $("#empAddModel").modal('hide');
                    //    来到最后一页
                    toPage(totalpage+1);
                }else {
                    if(undefined!=result.extend.errorFields.email){
                        show_vaildate_msg("#email_add","error",result.extend.errorFields.email);
                    }
                    if(undefined!=result.extend.errorFields.empName){
                        show_vaildate_msg("#empName_add","error",result.extend.errorFields.empName);
                    }
                }
            }
        });
    });


    //更新员工
    $(document).on("click",".edit_btn",function () {
        //1，查出员工信息，显示员工信息
        getEmp($(this).attr("edit_id"));
        //2,查出部门信息
        getDepts("#dept_select_update");
        //3,传入员工的id
        $("#emp_update_btn").attr("edit_id",$(this).attr("edit_id"));
        //弹出模态框
        $("#empUpdateModel").modal({
            backdrop:"static"
        });
    });
    function getEmp(id) {
        $.ajax({
            url:"${app_path}/emp/"+id,
            type:"get",
            success:function (result) {
            var empData = result.extend.emp;
            $("#empName_update_static").text(empData.empName);
            $("#email_update").val(empData.email);
            $("#empUpdateModel input[name=gender]").val([empData.gender]);
            $("#empUpdateModel select").val([empData.dId]);
            }
            });
    }

//    点击更新
    $("#emp_update_btn").click(function () {
        //验证邮箱合法
        var email = $("#email_update").val();
        var regEmail = 	/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            //alert("邮箱格式不正确");
            show_vaildate_msg("#email_add","error","邮箱格式不正确");
            return  false;
        }else {
            show_vaildate_msg("#email_add","success","");
        }

        $.ajax({
            url:"${app_path}/emp/"+$(this).attr("edit_id"),
            type:"put",
            data:$("#empUpdateModel form").serialize(),
            success:function (result) {
               $("#empUpdateModel").modal("hide");
               toPage(currentPage);
            }
        });

    });
    //删除单个员工
    $(document).on("click",".delete_btn",function () {
        //确认删除对话框
       var empName = $(this).parents("tr").find("td:eq(2)").text();
       if(confirm("确认删除"+empName+"吗？")){
        //确认发送ajax请求删除
        $.ajax({
            url:"${app_path}/emp/"+$(this).attr("del_id"),
            type:"delete",
            success:function (result) {
                alert(result.msg);
                toPage(currentPage);
            }
        });
       }
    });

    //全选全不选
    $("#check_all").click(function () {
        //prop修改和读取dom原生属性值
        $(this).prop("checked");
        $(".check_item").prop("checked", $(this).prop("checked"));
    });

    $(document).on("click",".check_item",function () {
        var flag = $(".check_item:checked").length==$(".check_item").length;
        $("#check_all").prop("checked",flag);
    });

    //全部删除
    $("#delAll_btn").click(function () {
        var empNames = "";
        var del_idstr="";
        $.each($(".check_item:checked"),function () {
           empNames+= $(this).parents("tr").find("td:eq(2)").text()+",";
           //员工id字符串
            del_idstr+=$(this).parents("tr").find("td:eq(1)").text()+"-"
        });
        empNames = empNames.substring(0,empNames.length-1);
        del_idstr = del_idstr.substring(0,del_idstr.length-1);
        if(confirm("确认删除"+empNames+"员工吗？")){
            //发送ajax请求
            $.ajax({
                url:"${app_path}/emp/"+del_idstr,
                type:"delete",
                success:function (result) {
                    alert(result.msg);
                    toPage(currentPage);
                }
            });
        }
    })
</script>
</body>
</html>
