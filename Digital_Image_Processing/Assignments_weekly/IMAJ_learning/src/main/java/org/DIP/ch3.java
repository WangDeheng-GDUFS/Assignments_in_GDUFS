package org.DIP;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Arrays;
import java.util.List;

import org.openimaj.image.DisplayUtilities;
import org.openimaj.image.ImageUtilities;
import org.openimaj.image.MBFImage;
import org.openimaj.image.colour.ColourSpace;
import org.openimaj.image.connectedcomponent.GreyscaleConnectedComponentLabeler;
import org.openimaj.image.pixel.ConnectedComponent;
import org.openimaj.image.processor.PixelProcessor;
import org.openimaj.image.segmentation.FelzenszwalbHuttenlocherSegmenter;
import org.openimaj.image.segmentation.SegmentationUtilities;
import org.openimaj.image.typography.hershey.HersheyFont;
import org.openimaj.ml.clustering.FloatCentroidsResult;
import org.openimaj.ml.clustering.assignment.HardAssigner;
import org.openimaj.ml.clustering.kmeans.FloatKMeans;

public class ch3
{
    public static void main( String[] args ) throws MalformedURLException, IOException
    {
        MBFImage input = ImageUtilities.readMBF(new URL("http://pic20.photophoto.cn/20110902/0034034471873095_b.jpg"));
        MBFImage input_2 = input.clone();
        input = ColourSpace.convert(input, ColourSpace.CIE_Lab);
        FloatKMeans cluster = FloatKMeans.createExact(2);
        float[][] imageData = input.getPixelVectorNative(new float[input.getWidth() * input.getHeight()][3]);
        FloatCentroidsResult result = cluster.cluster(imageData);
        final float[][] centroids = result.centroids;
        for (float[] fs : centroids) {
            System.out.println(Arrays.toString(fs));
        }
        final HardAssigner<float[], ?, ?> assigner = result.defaultHardAssigner();
        
        // Chapter 3.1
        // for(int y=0; y<input.getHeight(); y++)
        // {
        //     for(int x=0; x<input.getWidth(); x++)
        //     {
        //         float[] pixel = input.getPixelNative(x, y);
        //         int centroid = assigner.assign(pixel);
        //         input.setPixelNative(x, y, centroids[centroid]);
        //     }
        // }
        input.processInplace(new PixelProcessor<Float[]>()
        {
            public Float[] processPixel(Float[] pixel)
            {
                int i;
                float[] p = new float[pixel.length];
                for(i = 0; i < pixel.length; i ++)
                {
                    p[i] = pixel[i].floatValue();
                }
                int c = assigner.assign(p);   
                p = centroids[c];
                for(i = 0; i < pixel.length; i ++)
                {
                    pixel[i] = p[i];
                }
                return pixel;
            }
        });
        
        input = ColourSpace.convert(input, ColourSpace.RGB);
        DisplayUtilities.display(input);
        GreyscaleConnectedComponentLabeler labeler = new GreyscaleConnectedComponentLabeler();
        List<ConnectedComponent> components = labeler.findComponents(input.flatten());
        int i = 0;
        for (ConnectedComponent comp : components)
        {
            if (comp.calculateArea() < 50) 
                continue;
            input.drawText("Point:" + (i++), comp.calculateCentroidPixel(), HersheyFont.TIMES_MEDIUM, 20);
        }
        DisplayUtilities.display(input);
      
        // Chapter 3.2
        FelzenszwalbHuttenlocherSegmenter<MBFImage> s = new FelzenszwalbHuttenlocherSegmenter<MBFImage>();
        List<ConnectedComponent> coms = s.segment(input_2);
        SegmentationUtilities.renderSegments(input_2, coms);
        DisplayUtilities.display(input_2);
    }
}
