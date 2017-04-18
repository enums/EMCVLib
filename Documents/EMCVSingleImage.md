# EMCVSingleImage

A wrapped single channel image class.

- **[ObjC]**: Means this property or method can be used on Objective-C.
- **[ObjC++]**: Means this property or method can only be used on Objective-C++.

Super: [[EMCVBasicImage]](https://github.com/trmbhs/EMCVLib/blob/master/Documents/EMCVBasicImage.md) 

See: [[EMCVImage]](https://github.com/trmbhs/EMCVLib/blob/master/Documents/EMCVImage.md) [[EMCVSplitedImage]](https://github.com/trmbhs/EMCVLib/blob/master/Documents/EMCVSplitedImage.md)

# Property

empty.

# Instance Method

## Initialization

- **[ObjC]**: `initWithBasicImage`: Init a instance with a `EMCVBasicImage`. It'll copy memory.
- **[ObjC]**: `initWithBasicImageWithNoCopy`: Init a instance with a `EMCVBasicImage`. It'll not copy memory.


## Others
- **[ObjC]**: `threshold`: Threshold.
- **[ObjC]**: `threshold:maxValue:type`: Threshold. The type must be like `CV_THRESH_TOZERO` whitch is defined by OpenCV.
- **[ObjC]**: `findMaxValue:outPoint`: Find the max value and location.
- **[ObjC]**: `findMinValue:outPoint`: Find the min value and location.
- **[ObjC]**: `newCannyWithThresh1:andThresh2`: Canny. Create a new `EMCVSingleImage` instance and draw Canny image on it.
- **[ObjC]**: `cannyOnImage:withThresh1:andThresh2`: Canny. Draw Canny image on a specified image.
- **[ObjC]**: `newDrawContoursWithMode:andMethod`: Create a new `EMCVSingleImage` instance and draw edge image on it. The mode must be like `CV_RETR_TREE` whitch is defined by OpenCV. The method must be like `CV_CHAIN_APPROX_SIMPLE` whitch is defined by OpenCV too.
- **[ObjC]**: `drawContoursOnImage:WithMode:withThresh1:andThresh2`: Draw edge image on a specified image.
- **[ObjC]**: `newCornerHarrisWithBlockSize:andKSize:andK`: Create a new `EMCVSingleImage` instance and do Corner Harris on it.
- **[ObjC]**: `cornerHarrisOnImage:withBlockSize:andKSize:andK`: do Corner Harris on a specified image.
- **[ObjC]**: `convertScaleAbs`: The same as `convertScaleAbs` of OpenCV.
- **[ObjC++]**: `goodFeaturesToTrackInCppWithMaxCorners:andQLevel:andMinDistance`: Surf Feature Detector. Return a `vector<Point2f>`.
- **[ObjC]**: `goodFeaturesToTrackWithMaxCorners:andQLevel:andMinDistance`: Surf Feature Detector. Return a `NSArray` of `NSValue` whitch is wraped `NSPoint`.

# Class Method

empty