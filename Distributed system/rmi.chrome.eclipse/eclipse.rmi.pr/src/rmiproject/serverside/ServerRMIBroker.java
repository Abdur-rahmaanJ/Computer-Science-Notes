

package rmiproject.serverside;

import java.net.UnknownHostException;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.rmi.server.UnicastRemoteObject;
import rmiproject.RMIBrokerServices;
import rmiproject.clientside.ClientQuotationRMI;
import rmiproject.serverside.datamapper.ClientInfo;
import rmiproject.serverside.datamapper.Quotation;
//import java.text.NumberFormat;
//import java.util.LinkedList;
//import rmiproject.RMIProject;
//import java.net.InetAddress;
//import rmiproject.registry.ServiceRegistry;
//import rmiproject.RMIQuotationServices;
//import java.util.List;

public class ServerRMIBroker
    extends UnicastRemoteObject implements RMIBrokerServices {

  public ServerRMIBroker() throws RemoteException {
    super();
    ClientQuotationRMI.startClientQs();
  }

  // Some data ... could also be a Database Service
  public static final ClientInfo[] clients = {
      new ClientInfo("Niki Collier", ClientInfo.FEMALE, 43, 0, 5, "PQR254/1"),
      new ClientInfo("Old Geeza", ClientInfo.MALE, 65, 0, 2, "ABC123/4"),
      new ClientInfo("Hannah Montana", ClientInfo.FEMALE, 16, 10, 0, "HMA304/9"),
      new ClientInfo("Rem Collier", ClientInfo.MALE, 44, 5, 3, "COL123/3"),
      new ClientInfo("Jim Quinn", ClientInfo.MALE, 55, 4, 7, "QUN987/4"),
      new ClientInfo("Donald Duck", ClientInfo.MALE, 35, 5, 2, "XYZ567/9")};

  public static void displayProfile(ClientInfo info) {
    System.out.println("|=================================================================================================================|");
    System.out.println("|                                     |                                     |                                     |");
    System.out.println("| Name: " + String.format("%1$-29s", info.name) + " | Gender: " + String.format("%1$-27s", (info.gender == ClientInfo.MALE ? "Male" : "Female")) + " | Age: " + String.format("%1$-30s", info.age) + " |");
    System.out.println("| License Number: " + String.format("%1$-19s", info.licenseNumber) + " | No Claims: " + String.format("%1$-24s", info.noClaims + " years") + " | Penalty Points: " + String.format("%1$-19s", info.points) + " |");
    System.out.println("|                                     |                                     |                                     |");
    System.out.println("|=================================================================================================================|");
  }

  public static void main(String args[])
      throws RemoteException, UnknownHostException {
    try {
      Registry reg = LocateRegistry.createRegistry(7778);
      reg.rebind("mybrokerserver", new ServerRMIBroker());
      System.out.println("I am up as a broker server...");
    } catch (RemoteException e) {
      System.out.println("Exception e" + e.getMessage());
      System.err.println("Got an error: " + e);
    }
  }

  @Override
  public String getName() throws RemoteException {
    throw new UnsupportedOperationException("Not supported yet.");
  }
  @Override
  public void send(String msg) throws RemoteException {
    throw new UnsupportedOperationException("Not supported yet.");
  }
  @Override
  public void setClient(RMIBrokerServices c) throws RemoteException {
    throw new UnsupportedOperationException("Not supported yet.");
  }
  @Override
  public RMIBrokerServices getClient() throws RemoteException {
    throw new UnsupportedOperationException("Not supported yet.");
  }

  
  @Override
  public ClientInfo[] getClientList() throws RemoteException {
    for (ClientInfo info : clients) {
      displayProfile(info);
      System.out.println("***[ Quotations ]***");
      for (Quotation quotation :
           ClientQuotationRMI.getQs().getQuotations(info)) {
        System.out.println("***[ " + info.name + " ]***");
        ClientQuotationRMI.getQs().displayQuotation(quotation);
        System.out.println("***");
      }
      System.out.println("\n");
    }
    return clients;
  }
  @Override
  public String getOnline(String question) throws RemoteException {
    return "yes";
  }
}
