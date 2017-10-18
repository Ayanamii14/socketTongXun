# socketTongXun

不用任何框架，使用基于```c```的```socket```来实现


## 需求分析
> 编辑：yunxiang 版本：v0.1

### 编写ios和pc间的socket通信程序
- 在pc上建立一个学生信息文件student.txt(格式自定)，写一个socket服务程序，负责存取学生文件。
- ios写一个socket客户程序，负责查询pc机上的学生文件并和用户交互。
- 用户通过ios客户端实现增删改查学生文件的记录。
  
### iOS端需求
1. 基本的数据库表的显示，增加一个登陆框，用户名和密码或者加上pc的ip和端口号，用户数据表暂定为“user”
2. 按字段查询pc数据库，例如：查询学号“123456”的同学的相关信息，或者查询姓名为“yunxiang”的相关信息
3. 修改pc数据库的某一内容，比如说修改学号为“123456”的学生的姓名为“yuhao”，修改完后自动更新数据库显示
4. 按字段删除pc数据内的耨一数据，比如说删除学号为“123456”的学生信息，删除完后自动更新数据库显示
5. 增加pc数据库记录，比如说增加“098765 zhuwang boy 23 ”增加记录后自动更新数据库的显示
6. 退出当前登陆，以游客模式查看数据库，只具备查询功能
