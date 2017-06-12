﻿CKFinder.lang['zh-cn'] =
{
	appTitle : 'CKFinder',
	common :
	{
		// Put the voice-only part of the label in the span.
		unavailable		: '%1<span class="cke_accessibility">, 不可用</span>',
		confirmCancel	: '部分内容尚未保存，确定关闭对话框么?',
		ok				: '确定',
		cancel			: '取消',
		confirmationTitle: '确认',
		messageTitle	: '提示',
		inputTitle		: '询问',
		undo			: '撤销',
		redo			: '重做',
		skip			: '跳过',
		skipAll			: '全部跳过',
		makeDecision	: '应采取何样措施?',
		rememberDecision: '下次不再询问'
	},
	// Language direction, 'ltr' or 'rtl'.
	dir : 'ltr',
	HelpLang : 'en',
	LangCode : 'zh-cn',

	// Date Format
	//		d    : Day
	//		dd   : Day (padding zero)
	//		m    : Month
	//		mm   : Month (padding zero)
	//		yy   : Year (two digits)
	//		yyyy : Year (four digits)
	//		h    : Hour (12 hour clock)
	//		hh   : Hour (12 hour clock, padding zero)
	//		H    : Hour (24 hour clock)
	//		HH   : Hour (24 hour clock, padding zero)
	//		M    : Minute
	//		MM   : Minute (padding zero)
	//		a    : Firt char of AM/PM
	//		aa   : AM/PM
	DateTime : 'yyyy年m月d日 h:MM aa',
	DateAmPm : ['AM', 'PM'],

	// Folders
	FoldersTitle	: '文件夹',
	FolderLoading	: '正在加载文件夹...',
	FolderNew		: '请输入新文件夹名称: ',
	FolderRename	: '请输入新文件夹名称: ',
	FolderDelete	: '您确定要删除 "%1" 文件夹吗?',
	FolderRenaming	: ' (正在重命名...)',
	FolderDeleting	: ' (正在删除...)',
	DestinationFolder	: '目标文件夹', 

	// Files
	FileRename		: '请输入新文件名: ',
	FileRenameExt	: '如果改变文件扩展名，可能会导致文件不可用。\r\n确定要更改吗？',
	FileRenaming	: '正在重命名...',
	FileDelete		: '您确定要删除 "%1" 文件吗?',
	FilesDelete		: '确定要删除 %1 文件?', 
	FilesLoading	: '加载中...',
	FilesEmpty		: '空文件夹',
	DestinationFile	: '目标文件', 
	SkippedFiles	: '跳过文件列表:', 

	// Basket
	BasketFolder		: '临时文件夹',
	BasketClear			: '清空临时文件夹',
	BasketRemove		: '从临时文件夹移除',
	BasketOpenFolder	: '打开临时文件夹',
	BasketTruncateConfirm : '确定要清空临时文件夹?',
	BasketRemoveConfirm	: '确定要从临时文件夹中移除 "%1"文件？',
	BasketRemoveConfirmMultiple	: '确定要从临时文件夹中删除 %1 个文件?', 
	BasketEmpty			: '临时文件夹为空,可拖放文件至其中',
	BasketCopyFilesHere	: '从临时文件夹复制至此',
	BasketMoveFilesHere	: '从临时文件夹移动至此',

	// Global messages
	OperationCompletedSuccess	: '操作成功', 
	OperationCompletedErrors		: '操作失败',
	FileError				: '%s: %e',

	// Move and Copy files
	MovedFilesNumber	: '成功移动文件：%s',
	CopiedFilesNumber	: '成功复制文件：%s',
	MoveFailedList		: '不能移动文件：%s',
	CopyFailedList		: '不能复制文件：%s',

	// Toolbar Buttons (some used elsewhere)
	Upload		: '上传',
	UploadTip	: '上传文件',
	Refresh		: '刷新',
	Settings	: '设置',
	Help		: '帮助',
	HelpTip		: '查看在线帮助',

	// Context Menus
	Select			: '选择',
	SelectThumbnail : '选中缩略图',
	View			: '查看',
	Download		: '下载',

	NewSubFolder	: '创建子文件夹',
	Rename			: '重命名',
	Delete			: '删除',
	DeleteFiles		: '删除文件', 

	CopyDragDrop	: '将文件复制至此',
	MoveDragDrop	: '将文件移动至此',

	// Dialogs
	RenameDlgTitle		: '重命名',
	NewNameDlgTitle		: '文件名',
	FileExistsDlgTitle	: '文件已存在',
	SysErrorDlgTitle : '系统错误',

	FileOverwrite	: '自动覆盖重名',
	FileAutorename	: '自动重命名重名',
	ManuallyRename	: '手动重命名重名',

	// Generic
	OkBtn		: '确定',
	CancelBtn	: '取消',
	CloseBtn	: '关闭',

	// Upload Panel
	UploadTitle			: '上传文件',
	UploadSelectLbl		: '选定要上传的文件',
	UploadProgressLbl	: '正在上传文件，请稍候...',
	UploadBtn			: '上传选定的文件',
	UploadBtnCancel		: '取消',

	UploadNoFileMsg		: '请先选择要上传的文件',
	UploadNoFolder		: '请先选择要上传的文件夹',
	UploadNoPerms		: '无文件上传权限',
	UploadUnknError		: '上传文件出错',
	UploadExtIncorrect	: '此文件夹禁止上传这种后缀名的文件',

	// Flash Uploads
	UploadLabel			: '上传文件',
	UploadTotalFiles	: '上传总计:',
	UploadTotalSize		: '上传总大小:',
	UploadSend			: '上传',
	UploadAddFiles		: '添加文件',
	UploadClearFiles	: '清空文件',
	UploadCancel		: '取消上传',
	UploadRemove		: '删除',
	UploadRemoveTip		: '已删除!f',
	UploadUploaded		: '已上传!n%',
	UploadProcessing	: '上传中...',

	// Settings Panel
	SetTitle		: '设置',
	SetView			: '查看:',
	SetViewThumb	: '缩略图',
	SetViewList		: '列表',
	SetDisplay		: '显示:',
	SetDisplayName	: '文件名',
	SetDisplayDate	: '日期',
	SetDisplaySize	: '大小',
	SetSort			: '排列顺序:',
	SetSortName		: '按文件名',
	SetSortDate		: '按日期',
	SetSortSize		: '按大小',
	SetSortExtension		: '按后缀名',

	// Status Bar
	FilesCountEmpty : '<空文件夹>',
	FilesCountOne	: '1 个文件',
	FilesCountMany	: '%1 个文件',

	// Size and Speed
	Kb				: '%1 KB',
	Mb				: '%1 MB',
	Gb				: '%1 GB',
	SizePerSecond	: '%1/s',

	// Connector Error Messages.
	ErrorUnknown	: '请求的操作未能完成 (错误 %1)',
	Errors :
	{
	 10 : '无效的指令',
	 11 : '文件类型不在许可范围之内',
	 12 : '文件类型无效',
	102 : '无效的文件名或文件夹名称',
	103 : '由于管理员限制，该请求不能完成',
	104 : '由于文件系统的限制，该请求不能完成',
	105 : '无效的后缀名',
	109 : '无效请求',
	110 : '未知错误',
	111 : '由于文件太小该请求不能完成',
	115 : '存在重名的文件或文件夹',
	116 : '文件夹不存在，请刷新后再试',
	117 : '文件不存在，请刷新列表后再试',
	118 : '目标位置与当前位置相同',
	201 : '文件出现重名，新上传的文件改名为 "%1"',
	202 : '无效的文件',
	203 : '无效的文件 文件尺寸太大',
	204 : '上传文件已损失',
	205 : '服务器中的上传临时文件夹无效',
	206 : '因安全问题上传中断，上传文件不能 HTML 类型数据',
	207 : '新上传的文件改名为 "%1"',
	300 : '移动文件失败',
	301 : '复制文件失败',
	500 : '因为安全问题文件不可浏览，请联系管理员并检查CKFinder配置文件',
	501 : '不支持缩略图方式'
	},

	// Other Error Messages.
	ErrorMsg :
	{
		FileEmpty		: '文件名不能为空',
		FileExists		: '文件 %s 已存在',
		FolderEmpty		: '文件夹名称不能为空',
		FolderExists	: '此文件夹名已经存在：%s',
		FolderNameExists: '已经存在相同文件夹名',

		FileInvChar		: '文件名不能包含以下字符: \n\\ / : * ? " < > |',
		FolderInvChar	: '文件夹名称不能包含以下字符: \n\\ / : * ? " < > |',

		PopupBlockView	: '未能在新窗口中打开文件，请修改浏览器配置解除对本站点的锁定',
		XmlError		: '从服务器读取XML数据出错',
		XmlEmpty		: '无法从服务器读取数据，因XML响应返回结果为空',
		XmlRawResponse	: '服务器返回原始结果: %s'
	},

	// Imageresize plugin
	Imageresize :
	{
		dialogTitle		: '改变尺寸 %s',
		sizeTooBig		: '无法大于原图尺寸 (%size)',
		resizeSuccess	: '图像尺寸已修改',
		thumbnailNew	: '创建缩略图',
		thumbnailSmall	: '小 (%s)',
		thumbnailMedium	: '中 (%s)',
		thumbnailLarge	: '大 (%s)',
		newSize			: '设置新尺寸',
		width			: '宽度',
		height			: '高度',
		invalidHeight	: '无效高度',
		invalidWidth	: '无效宽度',
		invalidName		: '文件名无效',
		newImage		: '创建图像',
		noExtensionChange : '无法改变文件后缀',
		imageSmall		: '原文件尺寸过小',
		contextMenuName	: '改变尺寸',
		lockRatio		: '锁定比例',
		resetSize		: '原始尺寸'
	},

	// Fileeditor plugin
	Fileeditor :
	{
		save			: '保存',
		fileOpenError	: '无法打开文件',
		fileSaveSuccess	: '成功保存文件',
		contextMenuName	: '编辑',
		loadingFile		: '加载文件中...'
	},

	Maximize :
	{
		maximize : '全屏',
		minimize : '最小化'
	},

	Gallery :
	{
		current : '第 {current} 个图像，共 {total} 个'
	},

	Zip :
	{
		extractHereLabel	: '解压到这里',
		extractToLabel		: '解压到...',
		downloadZipLabel	: '打包下载',
		compressZipLabel	: '压缩到zip',
		removeAndExtract	: '删除现有的和解压的',
		extractAndOverwrite	: '覆盖现有文件',
		extractSuccess		: '解压成功'
	}
};
