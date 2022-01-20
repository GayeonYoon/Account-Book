<%@page import="java.awt.Graphics2D"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%
	String path = application.getRealPath("picture");
	String fname = null;
	File f = new File(path);
	if (!f.exists()) {
		f.mkdirs();
	}
	MultipartRequest multi = new MultipartRequest(request, path, 10 * 1024 * 1024, "UTF-8");
	//fname ":업로드된 이미지 파일이름
	fname = multi.getFilesystemName("picture");
	System.out.println(path + fname);
	BufferedImage bi = ImageIO.read(new File(path + "\\" + fname));
	int width = bi.getWidth() / 3;
	int height = bi.getHeight() / 3;
	BufferedImage thumb = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
	Graphics2D g = thumb.createGraphics();
	g.drawImage(bi, 0, 0, width, height, null);
	f = new File(path + "sm_" + fname);
	ImageIO.write(thumb, "jpg", f);
%>
<script>
	img = opener.document.getElementById("pic");
	img.src = "<%=request.getContextPath()%>/picture/<%=fname%>";
	opener.document.regFrm.picture.value="<%=fname%>"; /**/
	self.close();
</script>