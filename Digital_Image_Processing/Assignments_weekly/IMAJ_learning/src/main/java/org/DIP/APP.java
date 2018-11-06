package org.DIP;

import org.openimaj.image.DisplayUtilities;
import org.openimaj.image.MBFImage;
import org.openimaj.image.colour.ColourSpace;
import org.openimaj.image.colour.RGBColour;
import org.openimaj.image.processing.convolution.FGaussianConvolve;
import org.openimaj.image.typography.hershey.HersheyFont;

public class APP {
    public static void main( String[] args ) {
        //Create an image
        MBFImage image = new MBFImage(320,70, ColourSpace.RGB);

        //Fill the image with white
        image.fill(RGBColour.WHITE);
                        
        //Render some test into the image
        image.drawText("Hello World", 10, 60, HersheyFont.CURSIVE, 50, RGBColour.PINK);

        //Apply a Gaussian blur
        image.processInplace(new FGaussianConvolve(2f));
        
        //Display the image
        DisplayUtilities.display(image);
    }
}
