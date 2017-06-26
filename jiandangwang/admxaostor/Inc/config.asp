<%
'单页
Const SubBanner=0       	  '栏目 banner       1为显示，0为不显示

'文章分类
Const SubBannerN=0      	  '分类 banner   1为显示，0为不显示
Const SubReadmeN=0       	  '分类 简述      1为显示，0为不显示
Const SubContentN=0       	  '分类 简介      1为显示，0为不显示
Const SubChildN=0       	  '分类 子类      1为显示，0为不显示
'文章列表
Const SubEliteN=0       	  '详细 推荐      1为显示，0为不显示
Const SubKwdN=0       		  '详细 关键词    1为显示，0为不显示
Const SubCanshuN=0       	  '详细 简述      1为显示，0为不显示
Const SubPicN=0       		  '详细 上传      1为显示，0为不显示
Const SubTitleN="文章"

'产品分类
Const SubBannerP=0       	  '分类 banner   1为显示，0为不显示
Const SubReadmeP=0       	  '分类 简述      1为显示，0为不显示
Const SubContentP=0       	  '分类 简介      1为显示，0为不显示
Const SubChildP=0       	  '分类 子类      1为显示，0为不显示
'产品列表
Const SubEliteP=1       	  '详细 推荐      1为显示，0为不显示
Const SubKwdP=0       		  '详细 关键词    1为显示，0为不显示
Const SubCanshuP=0       	  '详细 简述      1为显示，0为不显示
Const SubPicP=1     		  '详细 上传      1为显示，0为不显示
Const SubPicBatchP=0		  '详细 批量上传   1为显示，0为不显示
Const SubTitleP="产品"

'应用分类
Const SubBannerA=0       	  '分类 banner   1为显示，0为不显示
Const SubReadmeA=0       	  '分类 简述      1为显示，0为不显示
Const SubContentA=0       	  '分类 简介      1为显示，0为不显示
Const SubChildA=1       	  '分类 子类      1为显示，0为不显示
'应用列表
Const SubEliteA=1       	  '详细 推荐      1为显示，0为不显示
Const SubKwdA=0       		  '详细 关键词    1为显示，0为不显示
Const SubCanshuA=0       	  '详细 简述      1为显示，0为不显示
Const SubPicA=1       		  '详细 上传      1为显示，0为不显示
Const SubPicBatchA=0		  '详细 批量上传   1为显示，0为不显示
Const SubTitleA="案例"

'下载列表
Const SubKwdD=0       		  '详细 关键词    1为显示，0为不显示
Const SubContentD=1       	  '详细 简述      1为显示，0为不显示

'客户留言
Const SubBook=0       	  	  '欢迎页 1为显示，0为不显示
Const SubReBook=0       	  '回复 1为回复，0为不回复

'友情链接
Const SubLinkType=1       	  	  '链接类型 1为图片，0为文字


'系统
Const SessionTimeout=60   	          'Session会话的保持时间
Const EnableUploadFile="Yes"          '是否开放文件上传
Const MaxFileSize="20mb"              '上传文件单个大小限制
Const AllMaxFileSize="200mb"          '上传文件总大小限制
Const SaveUpFilesPath="/UploadFiles"  '上传文件的目录
Const UpFileType="*.gif;*.jpg;*.jpeg;*.bmp;*.png;*.doc;*.docx;*.rar;*.zip;*.pdf;*.ppt;*.pptx;*.xls;*.xlsx;"        '允许上传的文件类型
Const UpFileTypeBatch="*.gif;*.jpg;*.jpeg;*.bmp;*.png;"        '允许批量上传的文件类型
Const UpFileLimit=10										   '允许批量上传的文件数量
Const DelUpFiles="Yes"                '删除信息时同时删除所上传的文件

'-----------------------------------------------------------------------
'-- 设置图片组件属性
Const Draw_NewSize=650        				'等比缩放图大小 500像素
%>