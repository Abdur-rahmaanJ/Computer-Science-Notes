/*  StackArrayPracticeController class
    Anderson, Franceschi
*/

import java.util.Random;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.geometry.Insets;
import javafx.scene.*;
import javafx.scene.canvas.Canvas;
import javafx.scene.canvas.GraphicsContext;
import javafx.scene.control.*;
import javafx.scene.layout.*;
import javafx.scene.paint.*;
import javafx.animation.AnimationTimer;

public class StackArrayPracticeController 
{
 private StackArray stack;
 private StackArrayDrawing drawing;
  
 private int key;
  
 @FXML private BorderPane bp;
 @FXML private HBox hBox1;
  
 @FXML private Label message;
 @FXML private TextField scoreInput;
 @FXML private Button push;
 @FXML private Button pop;
 private int activity; // 0=push; 1=pop

 private Pane pane;
 private Canvas canvas; 
 private GraphicsContext gc;
 
 private int score;
 private String result = "";

 public void initialize( )
 {   
   stack = new StackArray( );
   drawing = new StackArrayDrawing( );
    
   Insets insets = new Insets( Dimensions.APP_PADDING, Dimensions.APP_PADDING, 
                               Dimensions.APP_PADDING, Dimensions.APP_PADDING );
   bp.setPadding( insets );
   hBox1.setPadding( insets );
    
   pane = new Pane( );
   bp.setCenter( pane );
   canvas = new Canvas( Dimensions.APP_WIDTH - 2 * Dimensions.APP_PADDING, 
                        Dimensions.APP_HEIGHT - 2 * Dimensions.APP_PADDING );
   pane.getChildren( ).add( canvas );
   gc = canvas.getGraphicsContext2D( ); 
   drawing.draw( gc );
 }

 public void animate( int score, String result )
 {
   this.score = score;
   this.result = result;
 }

 @FXML protected void pop( ActionEvent event ) 
 {
   drawing.setOperation( false );
   drawing.setStarted( true );
   try
   {
     StackArray prePopStack = stack.copy( );
     int value = 0;
     value = stack.pop( );
     int correctValue = 0;
     correctValue = drawing.simulatePop( prePopStack );
    
     boolean result = stack.equals( prePopStack );
     System.out.println( "value = " + value + "; and correctValue = " + correctValue );
     System.out.println( "result = " + result );
     if ( result && value == correctValue) // success
        drawing.setMessage( "POP was CORRECT" );
     else if ( result && value != correctValue) // success
        drawing.setMessage( "POP was CORRECT\nReturned value was INCORRECT" );
     else
        drawing.setMessage( "POP was INCORRECT" );
      
     drawing.pop( ); 
     
   }
   catch ( DataStructureException dse )
   {
     drawing.setPopSuccess( false );
     drawing.setMessage( "Cannot pop" );

   }
   drawing.draw( gc );
   disableButtons( false );
 }
 
 @FXML protected void push( ActionEvent event ) 
 {
   disableButtons( true );
   // check if input value is valid 
   boolean goodInput = false;
   try
   {
       String answer = scoreInput.getText( );
       if ( answer != null )
       {
         key = Integer.parseInt( answer );
         goodInput = true;
       }
   }
   catch ( Exception e )
   {
       disableButtons( false );
   }
   
   if ( goodInput )
   {
      StackArray prePushStack = stack.copy( );
      boolean pushResult = stack.push( key ); 
      boolean pushResultSimulate = drawing.simulatePush( prePushStack, key );
      boolean result = stack.equals( prePushStack );
      if ( result && pushResult == pushResultSimulate ) // success
        drawing.setMessage( "PUSH was CORRECT" );
      else if ( result && pushResult != pushResultSimulate ) // success
        drawing.setMessage( "PUSH was CORRECT; returned value INCORRECT" );
      else
        drawing.setMessage( "PUSH was INCORRECT" );
      if ( pushResult == pushResultSimulate && pushResult == false )
        drawing.setMessage( "Cannot push - CORRECT" );
       
      drawing.push( key );
      drawing.draw( gc );  
      disableButtons( false );    
   }
 }

 public void disableButtons( boolean state )
 {
   push.setDisable( state );
   pop.setDisable( state );
 }
  
}