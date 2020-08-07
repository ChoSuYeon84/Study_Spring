package info;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.w3c.dom.xpath.XPathExpression;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

public class dao {
	// 약 검색 메소드
	public String[] searchMedicine(String medicineName) throws IOException, ParserConfigurationException, SAXException {

		StringBuilder urlBuilder = new StringBuilder(
				"http://apis.data.go.kr/1471057/MdcinPrductPrmisnInfoService/getMdcinPrductItem"); /* URL */
		urlBuilder.append("?" + URLEncoder.encode("ServiceKey", "UTF-8")
				+ "=MkSdYE%2Buv%2FKUgV4R8rVZr59Xn0XNCfABz8mQYa9xFwt%2BCigtvqcl2JmkBmpycrnmTdX%2B%2B50a8UNgMqqrB5qvOg%3D%3D"); /*
																																 * Service
																																 * Key
																																 */
		urlBuilder.append("&" + URLEncoder.encode("ServiceKey", "UTF-8") + "=" + URLEncoder.encode(
				"MkSdYE%2Buv%2FKUgV4R8rVZr59Xn0XNCfABz8mQYa9xFwt%2BCigtvqcl2JmkBmpycrnmTdX%2B%2B50a8UNgMqqrB5qvOg%3D%3D",
				"UTF-8")); /* 공공데이터포털에서 받은 인증키 */
		urlBuilder.append("&" + URLEncoder.encode("item_name", "UTF-8") + "="
				+ URLEncoder.encode(medicineName, "UTF-8")); /* 품목명 */

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");
		System.out.println("Response code: " + conn.getResponseCode());
		BufferedReader rd;

		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}

		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);

		}
		rd.close();
		conn.disconnect();
		System.out.println(sb.toString());
		String xmlFile = sb.toString();
		// --------------------
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		factory.setIgnoringElementContentWhitespace(true);
		DocumentBuilder builder = factory.newDocumentBuilder();

		Document doc = builder.parse(urlBuilder.toString());

		NodeList list = doc.getElementsByTagName("item");
		
			String chart = null;
	        String material_name = null;
	        String storage_method = null;
	        String valid_term = null;
	        String ee_doc_data = null;
	        String ud_doc_data = null;
	        String nb_doc_data = null;
	        String ITEM_SEQ = null;

		for (Node node = list.item(0).getFirstChild(); node != null; node = node.getNextSibling()) {
			 if (node.getNodeName().equals("CHART")) {
	                chart = node.getTextContent();

	            } else if (node.getNodeName().equals("MATERIAL_NAME")) {
	                material_name = node.getTextContent();
	            } else if (node.getNodeName().equals("STORAGE_METHOD")) {
	                storage_method = node.getTextContent();
	                System.out.println("보관방법 : " + storage_method);
	            } else if (node.getNodeName().equals("VALID_TERM")) {
	                valid_term = node.getTextContent();
	                System.out.println("유효기간 : " + valid_term);
	            } else if (node.getNodeName().equals("EE_DOC_DATA")) {
	                ee_doc_data = node.getTextContent();
	                ee_doc_data.trim();
	                System.out.println("효능효과 : " + ee_doc_data);
	            } else if (node.getNodeName().equals("UD_DOC_DATA")) {
	                ud_doc_data = node.getTextContent();
	                ud_doc_data.trim();
	                System.out.println("용법용량 : " + ud_doc_data);
	            } else if (node.getNodeName().equals("NB_DOC_DATA")) {
	                nb_doc_data = node.getTextContent();
	                nb_doc_data.trim();
	                System.out.println("주의사항 : " + nb_doc_data);
	            } else if (node.getNodeName().equals("ITEM_SEQ")) {
	                ITEM_SEQ = node.getTextContent();
	                ITEM_SEQ.trim();
	            }
		}
		String[] array = new String[0];
		array = new String[] {chart,material_name,storage_method,valid_term,ee_doc_data, ud_doc_data, nb_doc_data};

		BufferedReader br = null;

		try {

			// xml 파싱하기
			InputSource is = new InputSource(new StringReader(xmlFile));
			builder = factory.newDocumentBuilder();
			doc = builder.parse(is);
			XPathFactory xpathFactory = XPathFactory.newInstance();
			XPath xpath = xpathFactory.newXPath();
			// XPathExpression expr = xpath.compile("/response/body/items/item");
			XPathExpression expr = (XPathExpression) xpath.compile("//items/item");
			NodeList nodeList = (NodeList) expr.evaluate(doc, (short) 0, XPathConstants.NODESET);
			NodeList child;
			Node node = null;
			for (int i = 0; i < nodeList.getLength(); i++) {
				child = nodeList.item(i).getChildNodes();
				// System.out.println("---------------------------------------차일드의
				// 개수는"+child.getLength());
				for (int j = 0; j < child.getLength(); j++) {
					node = child.item(j);

				}

			}

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return array;
	}
}
