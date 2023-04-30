package sns;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.Socket;
import java.net.URL;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.Random;
import java.util.Base64;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import Decoder.BASE64Decoder;
import Decoder.BASE64Encoder;

@WebServlet("/sns/SmsSend")
public class SmsSendServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String charsetType = "utf-8"; //EUC-KR 또는 UTF-8
	    request.setCharacterEncoding(charsetType);
	    response.setCharacterEncoding(charsetType);
	    String action;
	    PrintWriter out = response.getWriter();
		try {
			action = nullcheck(request.getParameter("action"), "");
		    if(action.equals("go")) {

		        String sms_url = "";

		        sms_url = "https://sslsms.cafe24.com/sms_sender.php"; // SMS 전송요청 URL
		        String setPhone = request.getParameter("rphone");
		        String setContent = request.getParameter("msg");
		        String user_id = base64Encode("thalsghks"); // SMS아이디
		        String secure = base64Encode("a7df2ef01970f20ed87a0051f81592ff");//인증키
		        String msg = base64Encode(nullcheck(request.getParameter("msg"), ""));
		        String rphone = base64Encode(nullcheck(request.getParameter("rphone"), ""));
		        String sphone1 = base64Encode(nullcheck(request.getParameter("sphone1"), ""));
		        String sphone2 = base64Encode(nullcheck(request.getParameter("sphone2"), ""));
		        String sphone3 = base64Encode(nullcheck(request.getParameter("sphone3"), ""));
		        String rdate = base64Encode(nullcheck(request.getParameter("rdate"), ""));
		        String rtime = base64Encode(nullcheck(request.getParameter("rtime"), ""));
		        String mode = base64Encode("1");
		        String subject = "";
		        if(nullcheck(request.getParameter("smsType"), "").equals("L")) {
		            subject = base64Encode(nullcheck(request.getParameter("subject"), ""));
		        }
		        String testflag = base64Encode(nullcheck(request.getParameter("testflag"), ""));
		        String destination = base64Encode(nullcheck(request.getParameter("destination"), ""));
		        String repeatFlag = base64Encode(nullcheck(request.getParameter("repeatFlag"), ""));
		        String repeatNum = base64Encode(nullcheck(request.getParameter("repeatNum"), ""));
		        String repeatTime = base64Encode(nullcheck(request.getParameter("repeatTime"), ""));
		        String returnurl = nullcheck(request.getParameter("returnurl"), "");
		        String nointeractive = nullcheck(request.getParameter("nointeractive"), "");
		        String smsType = base64Encode(nullcheck(request.getParameter("smsType"), ""));

		        String[] host_info = sms_url.split("/");
		        String host = host_info[2];
		        String path = "/" + host_info[3];
		        int port = 80;

		        // 데이터 맵핑 변수 정의
		        String arrKey[]
		            = new String[] {"user_id","secure","msg", "rphone","sphone1","sphone2","sphone3","rdate","rtime"
		                        ,"mode","testflag","destination","repeatFlag","repeatNum", "repeatTime", "smsType", "subject"};
		        String valKey[]= new String[arrKey.length] ;
		        valKey[0] = user_id;
		        valKey[1] = secure;
		        valKey[2] = msg;
		        valKey[3] = rphone;
		        valKey[4] = sphone1;
		        valKey[5] = sphone2;
		        valKey[6] = sphone3;
		        valKey[7] = rdate;
		        valKey[8] = rtime;
		        valKey[9] = mode;
		        valKey[10] = testflag;
		        valKey[11] = destination;
		        valKey[12] = repeatFlag;
		        valKey[13] = repeatNum;
		        valKey[14] = repeatTime;
		        valKey[15] = smsType;
		        valKey[16] = subject;

		        String boundary = "";
		        Random rnd = new Random();
		        String rndKey = Integer.toString(rnd.nextInt(32000));
		        MessageDigest md = MessageDigest.getInstance("MD5");
		        byte[] bytData = rndKey.getBytes();
		        md.update(bytData);
		        byte[] digest = md.digest();
		        for(int i =0;i<digest.length;i++)
		        {
		            boundary = boundary + Integer.toHexString(digest[i] & 0xFF);
		        }
		        boundary = "---------------------"+boundary.substring(0,11);

		        // 본문 생성
		        String data = "";
		        String index = "";
		        String value = "";
		        for (int i=0;i<arrKey.length; i++)
		        {
		            index =  arrKey[i];
		            value = valKey[i];
		            data +="--"+boundary+"\r\n";
		            data += "Content-Disposition: form-data; name=\""+index+"\"\r\n";
		            data += "\r\n"+value+"\r\n";
		            data +="--"+boundary+"\r\n";
		        }
		        if(request.getParameter("rphone").replaceAll("-","").length() < 8 ||
		        		request.getParameter("rphone").replaceAll("-", "").length() > 11 ||
		        		request.getParameter("rphone").charAt(0) !='0') {
			    	JSONObject jobj = new JSONObject();
			    	jobj.put("result", "올바른 휴대폰 번호를 입력하세요");
			    	out.print(jobj.toString());
			    	out.close();
		        } else {
			        InetAddress addr = InetAddress.getByName(host);
			        Socket socket = new Socket(host, port);
			        // 헤더 전송
			        BufferedWriter wr = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream(), charsetType));
			        wr.write("POST "+path+" HTTP/1.0\r\n");
			        wr.write("Content-Length: "+data.length()+"\r\n");
			        wr.write("Content-type: multipart/form-data, boundary="+boundary+"\r\n");
			        wr.write("\r\n");

			        // 데이터 전송
			        wr.write(data);
			        wr.flush();

			        // 결과값 얻기
			        BufferedReader rd = new BufferedReader(new InputStreamReader(socket.getInputStream(),charsetType));
			        String line;
			        String alert = "";
			        ArrayList tmpArr = new ArrayList();
			        while ((line = rd.readLine()) != null) {
			            tmpArr.add(line);
			        }
			        wr.close();
			        rd.close();

			        String tmpMsg = (String)tmpArr.get(tmpArr.size()-1);
			        String[] rMsg = tmpMsg.split(",");
			        String Result= rMsg[0]; //발송결과
			        String Count= ""; //잔여건수
			        if(rMsg.length>1) {Count= rMsg[1]; }

			                        //발송결과 알림
			        if(Result.equals("success")) {
			            alert = "성공적으로 발송하였습니다.";
			            alert += " 잔여건수는 "+ Count+"건 입니다.";
			        }
			        else if(Result.equals("reserved")) {
			            alert = "성공적으로 예약되었습니다";
			            alert += " 잔여건수는 "+ Count+"건 입니다.";
			        }
			        else if(Result.equals("3205")) {
			            alert = "잘못된 번호형식입니다.";
			        }
			        else {
			            alert = "[Error]"+Result;
			        }	    	
			        if(nointeractive.equals("1") && !(Result.equals("Test Success!")) && !(Result.equals("success")) && !(Result.equals("reserved")) ) {
			            out.println("<script>alert('" + alert + "')</script>");
			        }
			        else if(!(nointeractive.equals("1"))) { // 메일 전송 성공시
			        	//rphone, msg
			        	AdminMgr mgr = new AdminMgr();			        	
			        	mgr.setSMS(new SMSBean(setPhone, setContent));
			        	ArrayList<SMSBean> smsList = mgr.getSMS();
			    		
			    		JSONObject sendObject = new JSONObject();  
			    		JSONArray sendArray = new JSONArray();
			    		
			        	for(int i=0;i<smsList.size();i++) {
			        		JSONObject sendSMS = new JSONObject(); // sms 메시지 
			        		sendSMS.put("userPN", smsList.get(i).getUserPN());
			        		sendSMS.put("content", smsList.get(i).getContent());
			        		sendSMS.put("userRegTime", smsList.get(i).getUserRegTime());	
			        		sendArray.add(sendSMS);
			        	}
			        	sendObject.put("sms", sendArray);
			        	sendObject.put("result", alert);
			        				        	
			        	out.print(sendObject.toString());
			        	out.close();
			        }
		        }
		    }
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
    public static String nullcheck(String str,  String Defaultvalue ) throws Exception
    {
         String ReturnDefault = "" ;
         if (str == null)
         {
             ReturnDefault =  Defaultvalue ;
         }
         else if (str == "" )
        {
             ReturnDefault =  Defaultvalue ;
         }
         else
         {
                     ReturnDefault = str ;
         }
          return ReturnDefault ;
    }
    
    public static String base64Encode(String str)  throws java.io.IOException {
        BASE64Encoder encoder = new BASE64Encoder();
        byte[] strByte = str.getBytes();
        String result = encoder.encode(strByte);
        return result ;
    }
    
    public static String base64Decode(String str)  throws java.io.IOException {
        BASE64Decoder decoder = new BASE64Decoder();
        byte[] strByte = decoder.decodeBuffer(str);
        String result = new String(strByte);
        return result ;
    }
}
