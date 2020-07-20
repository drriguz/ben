package com.riguz.okapia.opencv;

import android.util.Log;

import com.riguz.encryptions.Invokable;
import com.riguz.encryptions.Param;
import com.riguz.encryptions.invoker.InvokeException;

import org.opencv.android.OpenCVLoader;
import org.opencv.core.Mat;
import org.opencv.core.MatOfByte;
import org.opencv.core.Size;
import org.opencv.imgcodecs.Imgcodecs;

import static org.opencv.imgcodecs.Imgcodecs.imread;
import static org.opencv.imgproc.Imgproc.INTER_AREA;
import static org.opencv.imgproc.Imgproc.resize;

public class OpenCVBinding {
    static {
        /*
            https://docs.opencv.org/2.4/doc/tutorials/introduction/android_binary_package/dev_with_OCV_on_Android.html
         */
        if (!OpenCVLoader.initDebug()) {
            /*
                OpenCV error: Cannot load info library for OpenCV
                https://github.com/opencv/opencv/issues/15567
             */
            Log.w("OKAPIA_CV", "Unable to load openCV");
        }
    }

    @Invokable("createThumb")
    public byte[] encrypt(@Param("originalImage") String originalImage,
                          @Param("width") int width,
                          @Param("height") int height)
            throws InvokeException {
        Mat src = imread(originalImage);
        Mat thumb = new Mat();
        Size scaleSize = new Size(width, height);
        resize(src, thumb, scaleSize, 0, 0, INTER_AREA);

        MatOfByte mob = new MatOfByte();
        Imgcodecs.imencode(".jpg", thumb, mob);
        return mob.toArray();
    }
}
