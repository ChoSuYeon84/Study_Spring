package info;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class InfoDAO {

	// 약 검색 메소드
	public String[] search(String medicineName) {
		String[] array = null;
		try {
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
			// String xmlFile = sb.toString();
			// --------------------
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			factory.setIgnoringElementContentWhitespace(true);
			DocumentBuilder builder = factory.newDocumentBuilder();

			Document doc = builder.parse(urlBuilder.toString());

			NodeList list = doc.getElementsByTagName("item");
			array = new String[list.getLength()]; 
			int cnt = 0;
			int nodeCnt = 0;
			String item_name;
			Node node;
			// =====
			for (int i = 0; i < list.getLength(); i++) {

				// 리스트 크기만큼 반복함
				for (int k = 0; k < list.getLength(); k++) {
					// 한 리스트 안에 들어있는 자식 노드들의 갯수만큼 반복 함
					for (int j = 0; j < list.item(k).getChildNodes().getLength(); j++) {
						// 리시트(k)번째의 자식 노드들의 이름이 item_name이면 if문 진입
						if (list.item(k).getChildNodes().item(j).getNodeName().equals("ITEM_NAME")) {
							item_name = list.item(k).getChildNodes().item(j).getTextContent();
							array[k] = item_name;
						}
					}
				}
			}
			System.out.println("배열1에 든값:"+array[1]);
			System.out.println("배열1에 든값:"+array[2]);
			System.out.println("배열1에 든값:"+array[3]);
			return array;

		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("배열2에 든값:"+array.toString());
		return null;
	}
}
