# EMCVFactory

A wrapped functions whitch can do some computer vision calculations.

- **[ObjC]**: Means this property or method can be used on Objective-C.
- **[ObjC++]**: Means this property or method can only be used on Objective-C++.

# Property

empty

# Instance Method

## Initialization

empty

## Others

empty

# Class Method

- **[ObjC]**: `compareHistWithCVImage:andImage:withMethod`: Compare two `EMCVImage` instances' histogram. The method must be like `CV_COMP_CORREL` whitch is defined by OpenCV. The result is a `double` score.
- **[ObjC]**: `compareHistWithCVSplitedImage:andImage:withMethod:atChannal`: Compare two `EMCVSplitedImage` instances' histogram at the specified channal.
- **[ObjC]**: `matchTemplateWithImage:andTempl:withMethod`: Template Math. Find the location of the template image in the original image. The method must be like `CV_TM_SQDIFF_NORMED` whitch is defined by OpenCV. The result is a `EMCVImage` instance. It's a grey image. You can display it on a `NSImageView`.
- **[ObjC]**: `doBackProjectionWithImage:andTempl`: Back Projection. The result is a `EMCVImage` instance. It's a grey image.
- **[ObjC]**: `doBackProjectionWithImage:andTempl:withDims`: Do Back Projection with a specified dims.
- **[ObjC]**: `doBackProjectionWithImage:andTempl:atChannals:andDims:andRange`: More detailed Back Projection method.
- **[ObjC]**: `blendingImage:withImage:useAlpha1:andAlpha2:andGamma`: Blending two image with alpha. These two images must have the same size.
- **[ObjC]**: `copyImage:toImage`: Copy a image memory to another image.
