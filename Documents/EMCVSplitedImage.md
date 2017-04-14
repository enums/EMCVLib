# EMCVSplitedImage

A wrapped multi channel image class.

- **[ObjC]**: Means this property or method can be used on Objective-C.
- **[ObjC++]**: Means this property or method can only be used on Objective-C++.

# Property

- **[ObjC++]**: `_mats`: A `std::vector<cv::Mat>` object. It's single channal image data list.
- **[ObjC++]**: `_hists`: A `std::vector<cv::MatND>` object. It's single channal histogram data list.
- **[ObjC]**: `channalCount`: How much channals in current image;

# Instance Method

## Initialization

- **[ObjC++]**: `initWithMats`: Init a instance with a `std::vector<cv::Mat>`.
- **[ObjC++]**: `initWithNoCopyMats`: Init a instance with a `std::vector<cv::Mat>` and will not copy data.
- **[ObjC]**: `initWithPath`: Open a local image file with a `NSString` path.
- **[ObjC]**: `initWithCVImage`: Init a instance with a `EMCVImage` instance. Means to make a copy and split it.


## Others
- **[ObjC]**: `imageAtChannal`: Get one of these channels to gen a `EMCVImage` instance.
- **[ObjC]**: `imageCopyAtChannal`: Copy one of these channels to gen a `EMCVImage` instance.
- **[ObjC]**: `mergeImage`: Merge all channels to get a multi channel `EMCVImage` instance.
- **[ObjC]**: `sizeAtChannal`: Get size of the image at specified channal.


# Class Method

empty