

# EMCVImage

A wrapped image class. The default color format should be BGR when image opened from file.

- **[ObjC]**: Means this property or method can be used on Objective-C.
- **[ObjC++]**: Means this property or method can only be used on Objective-C++.

Super: [[EMCVBasicImage]](https://github.com/trmbhs/EMCVLib/blob/master/Documents/EMCVBasicImage.md) 

See: [[EMCVSplitedImage]](https://github.com/trmbhs/EMCVLib/blob/master/Documents/EMCVSplitedImage.md) [[EMCVSingleImage]](https://github.com/trmbhs/EMCVLib/blob/master/Documents/EMCVSingleImage.md) 

# Property

empty.

# Instance Method

## Initialization

- **[ObjC]**: `initWithPath`: Open a local image file with a `NSString` path.
- **[ObjC]**: `initWithCVSingleImage`: Init a instance with a `initWithCVSingleImage` instance. Means to init a single channal image.
- **[ObjC]**: `initWithCVSplitedImage`: Init a instance with a `EMCVSpritedImage` instance.

## Others

- **[ObjC]**: `forEachPixelWithBlock`: Enumerate each pixel and run a block with pixel's memory pointer.
- **[ObjC]**: `forEachPixelAtX:andY:withBlock`: Run a block with the specified pixel's memory pointer.
- **[ObjC]**: `makeACopy`: Make a copy. It will copy memory.
- **[ObjC]**: `newCannyWithThresh1:andThresh2`: Canny. Create a new `EMCVImage` instance and draw Canny image on it.
- **[ObjC]**: `cannyOnImage:WithThresh1:andThresh2`: Canny. Draw Canny image on a specified image.
- **[ObjC]**: `splitImage`: Split image's channels.


# Class Method

empty

