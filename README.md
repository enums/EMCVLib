# EMCVLib

An OpenCV library for macOS. ONLY MACOS NOW!

# Usage

Needed macOS 10.10+ and OpenCV 2.4.x.

## Install OpenCV 2.4.13.2 for macOS

Install OpenCV with brew:

```bash
brew tap homebrew/science
brew install opencv
```

- Headers should be here: 

`/usr/local/include/opencv`

`/usr/local/include/opencv2`

- Librarys should be here: 

`/usr/local/Cellar/opencv/2.4.13.2/lib`

## Install the library

Download the repo. Then drag the library project to your project.

# Functions

What can this library does now?

- Display image and play video with real-time processing.
- Color convert. Channals split. Image smooth. Image blending.
- Find extreme values and locations. Calculate and compare histograms.
- Matching algorithm: Template Match, Back Projection.

# Screenshots

Some screenshots of the demo.

### Image Smooth and Histogram

![](https://github.com/trmbhs/EMCVLib/raw/master/Screenshots/smooth_and_histogram.png)

### Image Blending

![](https://github.com/trmbhs/EMCVLib/raw/master/Screenshots/blending.png)

### Max / Min value location of RGB

![](https://github.com/trmbhs/EMCVLib/raw/master/Screenshots/max_min_value_point_of_RGB.png)

### History Compare

![](https://github.com/trmbhs/EMCVLib/raw/master/Screenshots/histogram_compare.png)

### Template Match

![](https://github.com/trmbhs/EMCVLib/raw/master/Screenshots/template_match.png)

### Back Projection

![](https://github.com/trmbhs/EMCVLib/raw/master/Screenshots/back_projection.png)


# Tips

Use `@autoreleasePool` when doing loop can solve some memory problems.

# Documents

Introduce each Class or Function in this library. Or you can see the demo code in this repo.

- **[ObjC]**: Means this property or method can be used on Objective-C.
- **[ObjC++]**: Means this property or method can only be used on Objective-C++ which means it's a `.mm` source file.

## EMCVImage

A wrapped image class. The default color format should be BGR when image opened from file.

### Property

- **[ObjC++]**: `_mat`: A `cv::Mat` object. It's image data.
- **[ObjC++]**: `_hist`: A `cv::MatND` object. It's histogram data.
- **[ObjC]**: `channalCount`: How much channals in current image;

### Instance Method

- **[ObjC]**: `initWithPath`: Open a local image file with a `NSString` path.
- **[ObjC]**: `initWithCVImage`: Init a instance with a `EMCVImage` instance. Means to make a copy.
- **[ObjC]**: `initWithCVImage:cvtColor`: Init a instance with a `EMCVImage` instance and color format. like `CV_BGR2RGB` whitch is defined by OpenCV.
- **[ObjC]**: `initWithSplitedImage `: Init a instance with a `EMCVSpritedImage` instance. Means to merge multi channel image.
- **[ObjC++]**: `initWithMat`: Init a instance with a `cv::Mat`.
- **[ObjC++]**: `initWithMat:cvtColor`: Init a instance with a `cv::Mat` and color format like `CV_BGR2RGB` whitch is defined by OpenCV.
- **[ObjC++]**: `initWithNoCopyMat`: Init a instance with a `cv::Mat` and will not copy memory.
- **[ObjC]**: `makeACopy`: Make a copy. It will copy memory.
- **[ObjC]**: `cvtColor`: Converts image from one color space to another. the Param must be like `CV_BGR2RGB` whitch is defined by OpenCV. The same as `cv::cvtColor`.
- **[ObjC]**: `splitImage`: Split image's channels.
- **[ObjC]**: `toImage`: Converts image to a `NSImage` instance.
- **[ObjC]**: `calHistWithSize:range`: Calculate histogram using all channals with the same size and range.
- **[ObjC]**: `calHistWithDims:size:range`: Calculate histogram with the same size and range.
- **[ObjC]**: `calHistWithDims:sizes:ranges`: Calculate histogram with the sizes and ranges.
- **[ObjC]**: `normalizeHistWithValue`: Normalize histogram to some value.
- **[ObjC]**: `drawARectWithCenter:size:rgbColor:thickness`: Draw a rect with specified center, size and thickness.	
- **[ObjC]**: `drawARect:rgbColor:thickness`: Draw a rect with specified rect and thickness.	
- **[ObjC]**: `blurWithSize`: Use Normalized Box Filter to smooth a image.
- **[ObjC]**: `medianBlurWithSize`: Use Median Filter to smooth a image.
- **[ObjC]**: `bilateralFilterWithDelta:andSigmaColor:andSigmaSpace`: Use Bilateral Filter to smooth a image.
- **[ObjC]**: `gaussianBlurWithSize`: Do Gaussian Blur with a specified kernel size.

### Class Metod

empty

## EMCVSplitedImage

A wrapped multi channel image class.

### Property

- **[ObjC++]**: `_mats`: A `std::vector<cv::Mat>` object. It's single channal image data list.
- **[ObjC++]**: `_hists`: A `std::vector<cv::MatND>` object. It's single channal histogram data list.
- **[ObjC]**: `channalCount`: How much channals in current image;

### Instance Method

- **[ObjC]**: `initWithPath`: Open a local image file with a `NSString` path.
- **[ObjC]**: `initWithCVImage`: Init a instance with a `EMCVImage` instance. Means to make a copy and split it.
- **[ObjC++]**: `initWithMats`: Init a instance with a `std::vector<cv::Mat>`.
- **[ObjC++]**: `initWithNoCopyMats`: Init a instance with a `std::vector<cv::Mat>` and will not copy data.
- **[ObjC]**: `mergeImage`: Merge all channels to get a multi channel `EMCVImage` instance.
- **[ObjC]**: `getImageWithChannal`: Get one of these channels to gen a `EMCVImage` instance.
- **[ObjC]**: `calHistWithSize:range`: Calculate all channals' histogram with the same size and range.
- **[ObjC]**: `calHistWithSizes:ranges`: Calculate all channals' histogram wit sizes and ranges.
- **[ObjC]**: `calHistWithChannal:size:range`: Calculate specified channal's histogram wit size and range. 
- **[ObjC]**: `normalizeHistWithValue`: Normalize all channals' histogram to some value.
- **[ObjC]**: `normalizeHistWithChannal:value`: Normalize specified channal's histogram to some value.
- **[ObjC]**: `findMaxValue:outPoint:inChannal`: Find the max value and location in specified channal.
- **[ObjC]**: `findMinValue:outPoint:inChannal`: Find the min value and location in specified channal.


### Class Metod

empty

## EMCVVideo

A wrapped video class.

### Property

- **[ObjC++]**: `_capture`: A `cv::VideoCapture` object.

### Instance Method

- **[ObjC]**: `initWithPath`: Open a local video file with a `NSString` path.
- **[ObjC]**: `nextFrame`: Get next frame in the current video. Return a `EMCVImage` instance.
- **[ObjC]**: `nextFrameSplitedWithChannal`: Get next single channal frame in the current video. Return a `EMCVImage` instance.

### Class Method

empty

## EMCV

A wrapped functions whitch can do some computer vision calculate.

### Property

empty

### Instance Method

empty

### Class Method

- **[objC]**: `compareHistWithCVImage:andImage:withMethod`: Compare two `EMCVImage` instances' histogram. The method must be like `CV_COMP_CORREL` whitch is defined by OpenCV. The result is a `double` score.
- **[objC]**: `compareHistWithCVSplitedImage:andImage:withMethod:atChannal`: Compare two `EMCVSplitedImage` instances' histogram at the specified channal.
- **[ObjC]**: `matchTemplateWithImage:andTempl:withMethod`: Template Math. Find the location of the template image in the original image. The method must be like `CV_TM_SQDIFF_NORMED` whitch is defined by OpenCV. The result is a `EMCVImage` instance. It's a grey image. You can display it on a `NSImageView`.
- **[ObjC]**: `doBackProjectionWithImage:andTempl`: Back Projection. The result is a `EMCVImage` instance. It's a grey image.
- **[ObjC]**: `doBackProjectionWithImage:andTempl:withDims`: Do Back Projection with a specified dims.
- **[ObjC]**: `doBackProjectionWithImage:andTempl:atChannals:andDims:andRange`: More detailed Back Projection method.
- **[ObjC]**: `blendingImage:withImage:useAlpha1:andAlpha2:andGamma`: Blending two image with alpha. These two images must have the same size.

## NSImageView + EMCVLib

### Property

empty

### Instance Method

- **[ObjC]**: `drawCVImage`: Display a `EMCVImage`.
- **[ObjC]**: `drawAndFitSizeWithCVImage`: Display and fit size with a `EMCVImage` instance.
- **[ObjC++]**: `drawHistOnMat:withHist:size:color`: Draw the specified histogram on the mat with specified color.
- **[ObjC]**: `drawHistWithCVImage:size:rgbColor`: Draw `EMCVImage` instance's histogram method with specified color.
- **[ObjC]**: `drawRGBHistWithCVImage`: A wrraped method of drawing RGB `EMCVImage` instance's histogram.
- **[ObjC]**: `drawHistWithCVSplitedImage:sizes:rgbs`: Draw a `EMCVSplitedImage` instance's histogram with specified sizes and colors.
- **[ObjC]**: `drawHistWithCVSplitedImage:channal:sizes:rgbs`: Draw a `EMCVSplitedImage` instance's histogram with specified channal, sizes and color.
- **[ObjC]**: `setImageAndFitSizeWithImage`: Redraw and display a `NSImage` instance.

### Class Method

empty

# Contect

Blog: [http://enumsblog.com](http://enumsblog.com)

Email: [enum@enumsblog.com](enum@enumsblog.com)

### HAVE FUN! : )