# EMCVSplitedImage

A wrapped multi channel image class.

- **[ObjC]**: Means this property or method can be used on Objective-C.
- **[ObjC++]**: Means this property or method can only be used on Objective-C++.

# Property

- **[ObjC++]**: `_mats`: A `std::vector<cv::Mat>` object. It's single channal image data list.
- **[ObjC++]**: `_hists`: A `std::vector<cv::MatND>` object. It's single channal histogram data list.
- **[ObjC]**: `channalCount`: How much channals in current image;
- **[ObjC]**: `sizeWithChannal`: Get size of the image at specified channal.

# Instance Method

## Initialization

- **[ObjC++]**: `initWithMats`: Init a instance with a `std::vector<cv::Mat>`.
- **[ObjC++]**: `initWithNoCopyMats`: Init a instance with a `std::vector<cv::Mat>` and will not copy data.
- **[ObjC]**: `initWithPath`: Open a local image file with a `NSString` path.
- **[ObjC]**: `initWithCVImage`: Init a instance with a `EMCVImage` instance. Means to make a copy and split it.

## Others
- **[ObjC]**: `imageWithChannal`: Get one of these channels to gen a `EMCVImage` instance.
- **[ObjC]**: `threshold:atChannal`: Threshold.
- **[ObjC]**: `threshold:maxValue:type:atChannal`: Threshold. The type must be like `CV_THRESH_TOZERO` whitch is defined by OpenCV.
- **[ObjC]**: `mergeImage`: Merge all channels to get a multi channel `EMCVImage` instance.
- **[ObjC]**: `calHistWithSize:range`: Calculate all channals' histogram with the same size and range.
- **[ObjC]**: `calHistWithSizes:ranges`: Calculate all channals' histogram wit sizes and ranges.
- **[ObjC]**: `calHistWithChannal:size:range`: Calculate specified channal's histogram wit size and range. 
- **[ObjC]**: `normalizeHistWithValue`: Normalize all channals' histogram to some value.
- **[ObjC]**: `normalizeHistWithChannal:value`: Normalize specified channal's histogram to some value.
- **[ObjC]**: `findMaxValue:outPoint:inChannal`: Find the max value and location in specified channal.
- **[ObjC]**: `findMinValue:outPoint:inChannal`: Find the min value and location in specified channal.
- **[ObjC]**: `newCannyWithThresh1:andThresh2:atChannal`: Canny. Create a new `EMCVImage` instance and draw Canny image on it.
- **[ObjC]**: `cannyOnImage:withThresh1:andThresh2:atChannal`: Canny. Draw Canny image on a specified image.
- **[ObjC]**: `newDrawContoursWithMode:andMethod:atChannal`: Create a new `EMCVImage` instance and draw edge image on it. The mode must be like `CV_RETR_TREE` whitch is defined by OpenCV. The method must be like `CV_CHAIN_APPROX_SIMPLE` whitch is defined by OpenCV too.
- **[ObjC]**: `drawContoursOnImage:WithMode:withThresh1:andThresh2:atChannal`: Draw edge image on a specified image.

# Class Method

empty