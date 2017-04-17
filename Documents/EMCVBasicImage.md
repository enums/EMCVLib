

# EMCVBasicImage

A wrapped basic image class. 

- **[ObjC]**: Means this property or method can be used on Objective-C.
- **[ObjC++]**: Means this property or method can only be used on Objective-C++.


See: [[EMCVImage]](https://github.com/trmbhs/EMCVLib/blob/master/Documents/EMCVImage.md) [[EMCVSingleImage]](https://github.com/trmbhs/EMCVLib/blob/master/Documents/EMCVSingleImage.md) 

# Property

- **[ObjC++]**: `_mat`: A `cv::Mat` object. It's image data.
- **[ObjC++]**: `_hist`: A `cv::MatND` object. It's histogram data.
- **[ObjC]**: `channalCount`: How much channals in current image;
- **[ObjC]**: `imageSize`: Get size of the image.

# Instance Method

## Initialization

- **[ObjC++]**: `initWithMat`: Init a instance with a `cv::Mat`.
- **[ObjC++]**: `initWithNoCopyMat`: Init a instance with a `cv::Mat` and will not copy memory.
- **[ObjC++]**: `initWithMat:cvtColor`: Init a instance with a `cv::Mat` and color format like `CV_BGR2RGB` whitch is defined by OpenCV.
- **[ObjC]**: `initWithSize:andType:andColor`: Init a empty `EMCVBasicImage` instance with type and color. Type must be like `CV_8UC3` whitch is defined by OpenCV. Color is a RGB value array.

## Others

- **[ObjC]**: `forEachPixelWithBlock`: Enumerate each pixel and run a block with pixel's memory pointer.
- **[ObjC]**: `forEachPixelAtX:andY:withBlock`: Run a block with the specified pixel's memory pointer.
- **[ObjC]**: `cvtColor`: Converts image from one color space to another. the Param must be like `CV_BGR2RGB` whitch is defined by OpenCV. The same as `cv::cvtColor`.
- **[ObjC]**: `makeACopy`: Make a copy. It will copy memory.
- **[ObjC]**: `splitImage`: Split image's channels.
- **[ObjC]**: `flipWithXAxis`: Flip with X axis.
- **[ObjC]**: `flipWithYAxis`: Flip with Y axis.
- **[ObjC]**: `setBrightness`: Set brightness with ± value.
- **[ObjC]**: `pyrUpWithRatio`: PyrUp with a ratio.
- **[ObjC]**: `pyrDownWithRatio`: PyrDown with a ratio.
- **[ObjC]**: `calHistWithSize:range`: Calculate histogram using all channals with the same size and range.
- **[ObjC]**: `calHistWithSizes:ranges`: Calculate histogram with the sizes and ranges.
- **[ObjC]**: `normalizeImageWithValue`: Normalize image to a value.
- **[ObjC]**: `normalizeHistWithValue`: Normalize histogram to a value.
- **[ObjC]**: `drawALineWithPoint:andPoint:andColor:andThickness`:Draw a line with specified points, color and thickness. 
- **[ObjC]**: `drawARectWithCenter:size:rgbColor:thickness`: Draw a rect with specified center, size and thickness.
- **[ObjC]**: `drawARect:rgbColor:thickness`: Draw a rect with specified rect and thickness.
- **[ObjC]**: `drawACircleWithCenter:andRadius:andColor:andThickness`: Draw a circle with specified center, radius, color and thickness.
- **[ObjC]**: `blurWithSize`: Use Normalized Box Filter to smooth a image.
- **[ObjC]**: `medianBlurWithSize`: Use Median Filter to smooth a image.
- **[ObjC]**: `bilateralFilterWithDelta:andSigmaColor:andSigmaSpace`: Use Bilateral Filter to smooth a image.
- **[ObjC]**: `gaussianBlurWithSize`: Do Gaussian Blur with a specified kernel size.
- **[ObjC]**: `toImage`: Converts image to a `NSImage` instance.

# Class Method

empty

