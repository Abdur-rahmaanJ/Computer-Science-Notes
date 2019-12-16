package service.auldfellas;

import service.broker.LocalBrokerService;
import service.core.AbstractQuotationService;
import service.core.ClientInfo;
import service.core.Quotation;
import service.core.QuotationService;
//Import ws libraries
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;
import javax.jws.soap.SOAPBinding.Style;
import javax.jws.soap.SOAPBinding.Use;
import javax.xml.ws.Endpoint;
import util.*;
import org.apache.juddi.api_v3.AccessPointType;
import org.apache.juddi.v3.client.config.UDDIClerk;
import org.apache.juddi.v3.client.config.UDDIClient;
import org.uddi.api_v3.AccessPoint;
import org.uddi.api_v3.BindingTemplate;
import org.uddi.api_v3.BindingTemplates;
import org.uddi.api_v3.BusinessEntity;
import org.uddi.api_v3.BusinessService;
import org.uddi.api_v3.Name;

/**
 * uddi:juddi.apache.org:a969e1c4-fdc3-461f-8c25-59536f56f094 busiensss key
 */

@WebService(serviceName = "QuotationService", targetNamespace = "http://core.service/", portName = "QuotationServicePort")
@SOAPBinding(style = Style.DOCUMENT, use = Use.LITERAL)
public class AFQService extends AbstractQuotationService implements QuotationService {
	public static void main(String[] args) {
		createAFQOnjUDDI();
	}

	public static void createAFQOnjUDDI() {
		UDDIClerk clerk = null;
		try {
			UDDIClient uddiClient = new UDDIClient("META-INF/uddi.xml");
			clerk = uddiClient.getClerk("default");
			if (clerk == null) {
				throw new Exception("the clerk wasn't found, check the config file!");
			}
			String BusinessKey = WebServicesHelper.createBusiness("AFQBusiness", clerk);
			BusinessService myService = WebServicesHelper.createWSDLService("QuotationService", BusinessKey, "http://localhost:9000/QuotationService/AFQService?wsdl");
			System.out.println("Business Key is" + "\n" + BusinessKey);
			BusinessService svc = clerk.register(myService);
			if (svc == null) {
				System.out.println("Save failed!");
				System.exit(1);
			}

			String myServKey = svc.getServiceKey();
			clerk.discardAuthToken();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static final String PREFIX = "AF";
	public static final String COMPANY = "Auld Fellas Ltd.";

	@Override
	public Quotation generateQuotation(ClientInfo info) {
		double price = generatePrice(600, 600);
		int discount = (info.gender == ClientInfo.MALE) ? 30 : 0;
		discount += (info.age > 60) ? (2 * (info.age - 60)) : 0;
		discount += getPointsDiscount(info);
		return new Quotation(COMPANY, generateReference(PREFIX), (price * (100 - discount)) / 100);
	}

	private int getPointsDiscount(ClientInfo info) {
		if (info.points < 3)
			return 20;
		if (info.points <= 6)
			return 0;
		return -50;
	}
}
