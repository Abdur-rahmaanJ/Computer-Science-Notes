/*  LinkedListPracticeApplication class: Chapter 14, PA 2
    Anderson, Franceschi
*/

import java.net.URL;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.layout.BorderPane;
import javafx.scene.Scene;
import javafx.stage.Stage;

public class LinkedListPracticeApplication extends Application 
{  
  @Override
  public void start( Stage stage ) 
  {
    try 
    {    
      URL url = getClass( ).getResource( "fxml_linked_list_practice.fxml" );
      BorderPane root = FXMLLoader.load( url );
      Scene scene = new Scene( root, Dimensions.APP_WIDTH, Dimensions.APP_HEIGHT );
      stage.setTitle( "Sorted Linked List Practice" );
      stage.setScene( scene ); 
      stage.show( );      
    }
    catch ( Exception e )
    {
      System.out.println( e.getMessage( ) ); 
    }
  }
 
  public static void main( String [] args ) 
  {
    launch( args );
  }
}