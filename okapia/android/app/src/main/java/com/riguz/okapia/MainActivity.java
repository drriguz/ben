package com.riguz.okapia;

import androidx.annotation.NonNull;

import com.riguz.encryptions.FlutterCallExecutor;
import com.riguz.okapia.opencv.OpenCVBinding;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.riguz.okapia/opencv";

    private static final FlutterCallExecutor executor = new FlutterCallExecutor();

    static {
        executor.register(OpenCVBinding.class);
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(executor);
    }
}
