# EMCVSingleImage

A wrapped single channel image class.

- **[ObjC]**: Means this property or method can be used on Objective-C.
- **[ObjC++]**: Means this property or method can only be used on Objective-C++.


# Property

- **[ObjC++]**: `_mat`: A `cv::Mat` object. It's image data.
- **[ObjC++]**: `_hist`: A `cv::MatND` object. It's histogram data.
- **[ObjC]**: `imageSize`: Get size of the image.

# Instance Method

## Initialization

- **[ObjC++]**: `initWithMats`: Init a instance with a `std::vector<cv::Mat>`.
- **[ObjC++]**: `initWithNoCopyMats`: Init a instance with a `std::vector<cv::Mat>` and will not copy data.
- **[ObjC]**: `initWithSize:andType:andValue`: Init a empty `EMCVSingleImage` instance with type and color. Type must be like `CV_8UC1` whitch is defined by OpenCV. Value is a 0~255 integer.

## Others
- **[ObjC]**: `forEachPixelWithBlock`: Enumerate each pixel and run a block with pixel's memory pointer.
- **[ObjC]**: `forEachPixelAtX:andY:withBlock`: Run a block with the specified pixel's memory pointer.
- **[ObjC]**: `threshold`: Threshold.
- **[ObjC]**: `threshold:maxValue:type`: Threshold. The type must be like `CV_THRESH_TOZERO` whitch is defined by OpenCV.
- **[ObjC]**: `flipWithXAxis`: Flip with X axis.
- **[ObjC]**: `flipWithYAxis`: Flip with Y axis.
- **[ObjC]**: `setBrightness`: Set brightness.
- **[ObjC]**: `pyrUpWithRatio`: PyrUp with a ratio.
- **[ObjC]**: `pyrDownWithRatio`: PyrDown with a ratio.
- **[ObjC]**: `calHistWithSize`: Calculate histogram with the same size and default range.
- **[ObjC]**: `calHistWithSize:range`: Calculate histogram with size and range.
- **[ObjC]**: `calHistWithChannal:size:range`: Calculate specified channal's histogram with size and range. 
- **[ObjC]**: `normalizeImageWithValue`: Normalize image to a value.
- **[ObjC]**: `normalizeHistWithValue`: Normalize histogram to a value.
- **[ObjC]**: `findMaxValue:outPoint`: Find the max value and location.
- **[ObjC]**: `findMinValue:outPoint`: Find the min value and location.
- **[ObjC]**: `newCannyWithThresh1:andThresh2`: Canny. Create a new `EMCVSingleImage` instance and draw Canny image on it.
- **[ObjC]**: `cannyOnImage:withThresh1:andThresh2`: Canny. Draw Canny image on a specified image.
- **[ObjC]**: `newDrawContoursWithMode:andMethod`: Create a new `EMCVSingleImage` instance and draw edge image on it. The mode must be like `CV_RETR_TREE` whitch is defined by OpenCV. The method must be like `CV_CHAIN_APPROX_SIMPLE` whitch is defined by OpenCV too.
- **[ObjC]**: `drawContoursOnImage:WithMode:withThresh1:andThresh2`: Draw edge image on a specified image.
- **[ObjC]**: `newCornerHarrisWithBlockSize:andKSize:andK`: Create a new `EMCVSingleImage` instance and do Corner Harris on it.
- **[ObjC]**: `cornerHarrisOnImage:withBlockSize:andKSize:andK`: do Corner Harris on a specified image.

# Class Method

empty