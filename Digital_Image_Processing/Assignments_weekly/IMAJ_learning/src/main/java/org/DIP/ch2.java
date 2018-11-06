package org.DIP;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;

import javax.swing.JFrame;

import org.openimaj.image.DisplayUtilities;
import org.openimaj.image.ImageUtilities;
import org.openimaj.image.MBFImage;
import org.openimaj.image.colour.RGBColour;
import org.openimaj.image.processing.edges.CannyEdgeDetector;
import org.openimaj.image.typography.hershey.HersheyFont;
import org.openimaj.math.geometry.shape.Ellipse;

public class ch2
{
    public static void main( String[] args ) throws MalformedURLException, IOException
    {
        JFrame f1 = DisplayUtilities.makeDisplayFrame("Display", 800, 600);
        f1.setVisible(true);
        
        MBFImage image = ImageUtilities.readMBF(new URL("http://pic20.photophoto.cn/20110902/0034034471873095_b.jpg"));
        System.out.println(image.colourSpace);
        // DisplayUtilities.display(image);
        // DisplayUtilities.display(image.getBand(0), "Red Channel");
        DisplayUtilities.display(image, f1);
        f1.setTitle("Red Channel");
        DisplayUtilities.display(image.getBand(0), f1);
        f1.setTitle("Display");

        MBFImage clone = image.clone();
        for (int y=0; y<image.getHeight(); y++)
        {
            for(int x=0; x<image.getWidth(); x++)
            {
                clone.getBand(1).pixels[y][x] = 0;
                clone.getBand(2).pixels[y][x] = 0;
            }
        }
        // DisplayUtilities.display(clone);
        DisplayUtilities.display(clone, f1);

        clone.getBand(1).fill(0f);
        clone.getBand(2).fill(0f);
        image.processInplace(new CannyEdgeDetector());
        // DisplayUtilities.display(image);
        DisplayUtilities.display(image, f1);

        image.drawShapeFilled(new Ellipse(700f, 450f, 20f, 10f, 0f), RGBColour.WHITE);
        image.drawShapeFilled(new Ellipse(650f, 425f, 25f, 12f, 0f), RGBColour.WHITE);
        image.drawShapeFilled(new Ellipse(600f, 380f, 30f, 15f, 0f), RGBColour.WHITE);
        image.drawShapeFilled(new Ellipse(500f, 300f, 100f, 70f, 0f), RGBColour.WHITE);
        
        // Nice border
        image.drawShape(new Ellipse(700f, 450f, 23f, 13f, 0f), RGBColour.PINK);
        image.drawShape(new Ellipse(650f, 425f, 28f, 15f, 0f), RGBColour.PINK);
        image.drawShape(new Ellipse(600f, 380f, 33f, 18f, 0f), RGBColour.PINK);
        image.drawShape(new Ellipse(500f, 300f, 103f, 73f, 0f), RGBColour.PINK);
        
        image.drawText("OpenIMAJ is", 425, 300, HersheyFont.ASTROLOGY, 20, RGBColour.BLACK);
        image.drawText("Awesome", 425, 330, HersheyFont.ASTROLOGY, 20, RGBColour.BLACK);
        // DisplayUtilities.display(image);
        DisplayUtilities.display(image, f1);
    }
}
