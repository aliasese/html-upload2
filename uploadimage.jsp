<%@ page contentType="text/html;charset=gb2312" language="java"
	import="java.io.*,java.awt.Image,java.awt.image.*,com.sun.image.codec.jpeg.*,java.sql.*,com.jspsmart.upload.*,java.util.*"%>
<%
	SmartUpload mySmartUpload = new SmartUpload();
	double file_size_max = 900000000;
	String fileName2 = "", ext = "", testvar = "";
	String url = "upload/"; //Ӧ��֤�ڸ�Ŀ¼���д�Ŀ¼�Ĵ��ڣ�Ҳ����˵��Ҫ�Լ�������Ӧ���ļ��У�
	//��ʼ��
	mySmartUpload.initialize(pageContext);
	//ֻ�������ش����ļ�
	try {
		mySmartUpload.setAllowedFilesList("jpg,gif,rar,zip,psd,png,PNG");//�˴����ļ���ʽ���Ը�����Ҫ�Լ��޸�
		//�����ļ� 
		mySmartUpload.upload();
	} catch (Exception e) {
%>
<SCRIPT language=javascript>
	alert("ֻ�����ϴ�.jpg��.gif����ͼƬ�ļ�");
	window.location = 'upload.htm';
</script>
<%
	}
	try {
		com.jspsmart.upload.File myFile = mySmartUpload.getFiles()
				.getFile(0);
		System.out.println("size:"+myFile.getFileName());
		if (myFile.isMissing()) {
%>
<SCRIPT language=javascript>
	alert("����ѡ��Ҫ�ϴ����ļ�");
	window.location = 'upload.htm';
</script>
<%
	} else {
			//String myFileName=myFile.getFileName(); //ȡ�����ص��ļ����ļ���
			ext = myFile.getFileExt(); //ȡ�ú�׺��
			int file_size = myFile.getSize(); //ȡ���ļ��Ĵ�С
			System.out.println("size:"+file_size);
			String saveurl = "";
			if (file_size < file_size_max) {
				//�����ļ�����ȡ�õ�ǰ�ϴ�ʱ��ĺ�����ֵ
				Calendar calendar = Calendar.getInstance();
				String filename = String.valueOf(calendar
						.getTimeInMillis());
				saveurl = application.getRealPath("/") + "/"+url;
				System.out.println("z:"+application.getRealPath("/"));
				saveurl += filename + "." + ext; //����·��
				System.out.println("1:"+saveurl);
				myFile.saveAs(saveurl, SmartUpload.SAVE_PHYSICAL);
				out.print(saveurl);

				String ret = "parent.HtmlEdit.focus();";
				ret += "var range = parent.HtmlEdit.document.selection.createRange();";
				ret += "range.pasteHTML('<img src=\""
						+ request.getContextPath() + "/upload/"
						+ filename + "." + ext + "\">');";
				ret += "alert('�ϴ��ɹ���');";
				ret += "window.location='upload.htm';";
				out.print("<script language=javascript>" + ret
						+ "</script>");

			}
		}
	} catch (Exception e) {
		out.print(e.toString());
	}
%>