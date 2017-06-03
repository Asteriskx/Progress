import javax.swing.*;
import java.awt.BorderLayout;
import java.awt.event.*;

JProgress frame;

public void setup()
{
  frame = new JProgress();
}

public void draw()
{
  frame.setDefaultCloseOperation( JFrame.EXIT_ON_CLOSE );
  frame.setBounds( 10, 10, 300, 200 );
  frame.setTitle("Progress Test");
  frame.setVisible( true );
}

public class JProgress extends JFrame implements ActionListener
{
  private Timer 			timer;
  private JButton 		startButton;
  private JButton 		stopButton;
  private JProgressBar 	bar;
  private JLabel 		 	label;
  private int 			count;

  private JProgress()
  {
    count = 0;
    label = new JLabel( "Waiting..." );

    JPanel labelPanel = new JPanel();
    labelPanel.add( label );

    startButton = new JButton( "Start" );
    startButton.addActionListener( this );
    startButton.setActionCommand( "start" );

    stopButton = new JButton( "Stop" );
    stopButton.addActionListener( this );
    stopButton.setActionCommand( "stop" );
    stopButton.setEnabled( false );

    JPanel buttonPanel = new JPanel();
    buttonPanel.add(startButton);
    buttonPanel.add(stopButton);

    bar = new JProgressBar(0, 200);
    bar.setStringPainted(true);
    bar.setString("");
    bar.setValue(0);

    JPanel barPanel = new JPanel();
    barPanel.add(bar);

    timer = new Timer(100, this);
    timer.setActionCommand("timer");

    getContentPane().add(labelPanel, BorderLayout.PAGE_START);
    getContentPane().add(buttonPanel, BorderLayout.PAGE_END  );
    getContentPane().add(barPanel, BorderLayout.CENTER    );
  }

  public void actionPerformed( ActionEvent e )
  {
    String cmd = e.getActionCommand();
    switch( cmd )
    {
    default:
      break;

    case "start":
      startButton.setEnabled(false);
      stopButton.setEnabled(true);
      timer.start();
      break;

    case "stop":
      startButton.setEnabled(true);
      stopButton.setEnabled(false);
      timer.stop();
      break;

    case "timer":
      break;
    }

    if ( count >= 200 ) 
    {
      startButton.setEnabled(true);
      stopButton.setEnabled(false);
      timer.stop();
      bar.setValue(count);
      count = 0;
    } else {
      count++;
      bar.setValue(count);
    }

    int per = ( int )( bar.getPercentComplete() * 100 );
    bar.setString( per + "% 完了" );
  }
}