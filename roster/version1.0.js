index.html
1.功能导航：首页（留白）、项目管理（管理项目）、后台管理（管理后台人员）
2.项目管理：
    (projectList.html)
    2.1 项目导航：正在进行、即将开始（新增）、已经结束
    2.2 项目内容：项目名称、项目简介、项目开始时间（新增）、项目结束时间（新增）
        PS：不统计学生数和课程数；没有项目头像，如果不好改的话可以设置一个默认的图片
    2.3 项目详情：
        project.html
        2.3.1 项目详情导航:项目介绍、课程、学生、班主任
        2.3.2 课程内容：
        2.3.3 学生内容：
        2.3.4 班主任内容：
3.后台管理
    manage.html
    3.1 管理员内容：管理员账号、管理员昵称、管理员职称（超级管理员、项目管理员）



首页链接：xmu.novaxmu.cn/roster 或 xmu.novaxmu.cn/roster/admin?m=index
PS :会根据是否登录来判断应该显示登录界面还是内容页面

页面跳转：
1.首页: xmu.novaxmu.cn/roster/admin?m=index
    返回：roster/admin/index.tpl
        user = array(
            'id'=>'数字', 
            'account'=>'登录账户（通常为手机号码）', 
            'nickname'=>'昵称', 
            'password' => '密码', 
            'privilege'=>'数字 职称代号', 
            'job'=>'职称 超级管理员/项目管理员'
            )

2.项目列表：xmu.novaxmu.cn/roster/project?m=projectList
    参数：GET
        page:1
    返回：roster/admin/projectList.tpl
        page：页数
        list：array(
                '0'=>array(
                    'id'=>'项目ID', 
                    'name'=>'项目名称',
                    'introduction'=>'项目介绍',
                    'startTime'=>'项目开始时间',
                    'endTime' => '项目结束时间',
                    'time' => '项目添加时间'
                    )

3.项目详情：xmu.novaxmu.cn/roster/project?m=project
    参数：GET
        id:项目id
    返回：roster/admin/project.tpl
        project = array(
                'id'=>'项目ID', 
                'name'=>'项目名称',
                'introduction'=>'项目介绍',
                'startTime'=>'项目开始时间',
                'endTime' => '项目结束时间',
                'time' => '项目添加时间'
                )

4.后台列表：xmu.novaxmu.cn/roster/super?m=managerList
    返回：roster/admin/managerList.tpl
        page：页数
        list：array(
                    'id' => 'id'，
                    'account' => 'account',
                    'nickname' => 'nickname',
                    'password' => 'password',
                    'privilege' => 1(超级管理员)/2(项目管理员),
                    'deleted' => 1(已启用)/-1(已停用)
                    )

4.课程：xmu.novaxmu.cn/roster/project?m=courseList
    参数：GET
        id：项目id
    返回：roster/admin/courseList.tpl
        courseList = array(
            '0' => array(
                'id' => '课程id',
                'name' => '课程名称',
                'teacherName' => '授课老师名字',
                'address' => '授课地点',
                'startTime' => '授课开始时间',
                'endTime' => '授课结束时间',
                'type' => '1(普通课程)/2(兴趣课程)'
                ),
            '1' => array()
            )

// 5.课程详情：xmu.novaxmu.cn/roster/project?m=course
//     返回：roster/admin/course.tpl

6.学生：xmu.novaxmu.cn/roster/projet?m=studentList
    参数：GET
        projectId:项目id
        page:1
    返回：roster/admin/studentList.tpl
        page：页数
        list：array(
                    'id' => 'id',
                    'name' => 'name',
                    'telephone' => 'telephone',
                    'email' => 'email'
                    )


7.班主任：xmu.novaxmu.cn/roster/project?m=teacherList
    参数：GET
        projectId:项目id
    返回：roster/admin/teacherList.tpl
        list:array(
                '0' => array(
                    'id' => '班级ID',
                    'num' => '班级编号'
                    'teacher' => array(
                        'id' => '班主任ID',
                        'name' => '班主任名字',
                        'telephone' => '班主任手机',
                        'emial' => '班主任邮箱'
                        )
                    ),
                '1' => array()
                )




数据接口：
1.登录：xmu.novaxmu.cn/roster/api/admin/login
    返回数据：
        array('errno' => 0/1, 'errmsg' => 'ok'/'errmsg')
    <script type="text/javascript"> 
            function validator(account, password){
                if(account == null || account ==''){
                    alert("请输入后台账户");
                    return false;
                }
                if(password == null || password == ''){
                    alert("请输入密码");
                    return false;
                }
                return true;
            }
            function cmsLogin(){ 
                //添加验证信息
                var account = $('#account').val();
                var password = $('#password').val();
                if(!validator(account, password)){
                    return false;
                }
                $.post(
                        "/roster/api/admin/login",
                        {
                            'account':account,
                            'password':password
                        },
                        function(data){
                            var data = jQuery.parseJSON(data);
                            if(data.errno == 0){
                              window.location.href = '/roster/admin?m=index';
                            }else{
                              alert(data.errmsg);
                            }
                        });
            } 

2.项目数组：xmu.novaxmu.cn/roster/api/admin/project?m=getProjectList
    参数:GET
        page:页数 
        time:时间（0:正在进行 1:即将开始 -1:已经结束）
    返回数据:
        array('errno' => 0/1, 
            'errmsg' => array(
                '0'=>array(
                    'id'=>'项目ID', 
                    'name'=>'项目名称',
                    'introduction'=>'项目介绍',
                    'startTime'=>'项目开始时间',
                    'endTime' => '项目结束时间',
                    'time' => '项目添加时间'
                    ), 
                '1'=>array(……))/'errmsg'

3.添加项目：xmu.novaxmu.cn/roster/api/admin/project?m=addProject
    参数：POST
        name
        introduction
        startTime
        endTime
    返回数据：
        array('errno' => 0/1, 'errmsg' => 'ok'/'')

4.后台管理人员数组：xmu.novaxmu.cn/roster/api/admin/super?m=getManagerList
    参数：GET
        page:页数
    返回数据：
        array('errno' => 0/1,
            'errmsg' => array(
                '0' => array(
                    'id' => 'id'，
                    'account' => 'account',
                    'nickname' => 'nickname',
                    'password' => 'password',
                    'privilege' => 1(超级管理员)/2(项目管理员),
                    'deleted' => 1(已启用)/-1(已停用)
                    ),
                '1' => array()
            )/'')

5.添加管理人员:xmu.novaxmu.cn/roster/api/admin/super?m=addManager
    参数：POST
        account
        nickname
        password
        privilege(1(超级管理员),2(项目管理员))
    返回数据：
        array('errno' => 0/1, 'errmsg' = 'ok'/'')

6.启用管理员：xmunovaxmu.cn/roster/api/admin/super?m=useManager
    参数：POST
        id:管理员ID
    返回数据：
        array('errno' => 0/1, 'errmsg' = 'ok'/'')

7.停用管理员：xmu.novaxmu.cn/roster/api/admin/super?m=unuseManager
    参数：POST
        id:管理员ID
    返回数据：
        array('errno' => 0/1, 'errmsg' = 'ok'/'')

8.获取项目页数：xmu.novaxmu.cn/roster/api/admin/project?m=getProjectPage
    参数：time(1:即将开始 0:正在进行 -1:已经结束)
    返回数据：页数（自然数）

9.获取管理员页数：xmu.novaxmu.cn/roster/api/admin/super?m=getManagerPage
    返回数据：页数(自然数)

10.添加班级：xmu.novaxmu.cn/roster/api/admin/project?m=addClass
    参数：POST
        projectId:项目ID
        num:班级编号
        name:班主任名字
        telephone:班主任手机
        email:班主任邮箱
    返回数据：
        array('errno' => 0/1, 'errmsg' = 'ok'/'')

12. 根据手机号码获取班主任信息：xmu.novaxmu.cn/roster/api/admin/project?m=getTeacher
    参数：POST
        telephone:班主任手机号码
    返回数据：
        array('errno' => 0/1,
            'errmsg' => array(
                'id'=>'用户ID',
                'telephone' => '手机号码',
                'name' => '姓名',
                'email' => '邮箱'
                )/'参数错误')



12.获取班级列表：xmu.novaxmu.cn/roster/api/admin/project?m=getClassList
    参数：POST
        projectId:项目ID
    返回数据：
        array('errno'=> 0/1,
            'errmsg' => array(
                '0' => array(
                    'id' => '班级ID',
                    'num' => '班级编号'
                    // 'teacher' => array(
                    //     'id' => '班主任ID',
                    //     'name' => '班主任名字',
                    //     'telephone' => '班主任手机',
                    //     'emial' => '班主任邮箱'
                    //     )
                    ),
                '1' => array()
                )/'')

13.添加学生(按班级添加)：xmu.novaxmu.cn/roster/api/admin/project?m=addStudent
    参数：POST
        classId:班级ID
        file_stu:XLS文件
    返回数据：array('errno' => 0/1, 'errmsg' = 'ok'/'')

14.获取学生列表：xmu.novaxmu.cn/roster/api/admin/project?m=getStudentList
    参数：POST
        projectId:项目ID（0:获取的是班级学生）
        classId:班级ID（0:该项目的所有学生）
        page
        PS(projectId classId不能同时为0)
    返回数据：
        array('errno'=> 0/1,
            'errmsg' => array(
                '0' => array(
                    'id' => '学生ID',
                    'name' => '姓名',
                    'telephone' => '手机',
                    'email' => '邮箱'
                        )
                    ),
                '1' => array()
                )/'')

15.获取学生列表页数：xmu.novaxmu.cn/roster/api/admin/project?m=getStudentPage
    参数：POST
        projectId:项目ID（0:获取的是班级学生）
        classId:班级ID（0:该项目的所有学生）
        PS(projectId classId不能同时为0)
    返回数据：页数（自然数）



微信端

1.绑定页面：xmu.novaxmu.cn/roster/wechat?m=linkin
    参数：GET
        openid：微信给的
    返回页面 roster/wechat/linkin.tpl

2.绑定手机：xmu.novaxmu.cn/roster/api/linkin
    参数：GET
        telephone
        type:1学生 2老师
    返回数据：array('errno' => 0/1, 'errmsg' = 'ok'/'')
















