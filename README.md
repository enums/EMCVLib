# EMCVLib

An OpenCV framework for iOS and macOS.

# Usage

Needed iOS 8.0+.

Needed macOS 10.10+ and OpenCV 2.4.x.

## iOS: Install OpenCV for iOS

Install OpenCV by using Cocoapods.

```bash
cd EMCVLib
pod install
```

## macOS: Install OpenCV for macOS

<del>Install OpenCV with brew:</del>

We cannot use brew to install OpenCV due to this issue: [[OpenCV #7833]](https://github.com/opencv/opencv/issues/7833)

It'll crash when releasing camera in Cocoa application.

So we need to compile it by ourselves.

- Download OpenCV: [[trmbhs/opencv]](https://github.com/trmbhs/opencv)
- Download extra modules: [[trmbhs/opencv_contrib]](https://github.com/trmbhs/opencv_contrib)
- Config with cmake-gui. See [here](https://github.com/trmbhs/opencv_contrib/blob/master/README.md).
- Make and install.

Headers should be here: 

`/usr/local/include/opencv`

`/usr/local/include/opencv2`

Librarys should be here: 

`/usr/local/lib`

## Install the framework

Download the repo. Then drag the framework project to your project.

# Functions

What can this framework does now?

- Display image and play real-time processing video with customized filter.
- Color convert. Channals split. Image flip, smooth, blending.
- Edge Detection. Find extreme values and locations. Calculate and compare histograms.
- Corener Harris. Shi-Tomasi. Optical Flow.
- Matching algorithm: Template Match. Back Projection. SURF Match.

# Screenshots

Some screenshots of the demo.

### iOS Image Sample

![](https://github.com/trmbhs/EMCVLib/raw/master/Screenshots/ios_image_sample.png)

### Image Smooth

![](https://github.com/trmbhs/EMCVLib/raw/master/Screenshots/smooth.png)

### Image Blending

![](https://github.com/trmbhs/EMCVLib/raw/master/Screenshots/blending.png)

### Threshold

![](https://github.com/trmbhs/EMCVLib/raw/master/Screenshots/threshold.png)

### Canny and Edge Detection

![](https://github.com/trmbhs/EMCVLib/raw/master/Screenshots/canny_and_contours.png)

### Corner Harris

![](https://github.com/trmbhs/EMCVLib/raw/master/Screenshots/corner_harris.png)

### Optical Flow

![](https://github.com/trmbhs/EMCVLib/raw/master/Screenshots/OpticalFlowPyrLK.gif)

### Template Match

![](https://github.com/trmbhs/EMCVLib/raw/master/Screenshots/template_match.png)

![](https://github.com/trmbhs/EMCVLib/raw/master/Screenshots/template_match_2.png)

### SURF Match

![](https://github.com/trmbhs/EMCVLib/raw/master/Screenshots/surf.png)


### Back Projection

![](https://github.com/trmbhs/EMCVLib/raw/master/Screenshots/back_projection.png)

### History Compare

![](https://github.com/trmbhs/EMCVLib/raw/master/Screenshots/histogram_compare.png)


# Tips

Use `@autoreleasePool` when doing loop can solve some memory problems.

# Documents

API docs and bugs here.

- [[Bug]](https://github.com/trmbhs/EMCVLib/blob/master/Documents/bugs.md) Bugs.

- [[API]](https://github.com/trmbhs/EMCVLib/blob/master/Documents/EMCVFactory.md) `EMCVFactory`: A wrapped functions whitch can do some computer vision calculations.
- [[API]](https://github.com/trmbhs/EMCVLib/blob/master/Documents/EMCVBasicImage.md) `EMCVBasicImage`: A wrapped basic image class.
- [[API]](https://github.com/trmbhs/EMCVLib/blob/master/Documents/EMCVImage.md) `EMCVImage`: A wrapped image class.
- [[API]](https://github.com/trmbhs/EMCVLib/blob/master/Documents/EMCVSplitedImage.md) `EMCVSplitedImage`: A wrapped multi channel image class.
- [[API]](https://github.com/trmbhs/EMCVLib/blob/master/Documents/EMCVSingleImage.md) `EMCVSingleImage`: A wrapped single channel image class.
- [[API]](https://github.com/trmbhs/EMCVLib/blob/master/Documents/EMCVFilter.md) `EMCVFilter`: A wrapped image filter.
- [[API]](https://github.com/trmbhs/EMCVLib/blob/master/Documents/EMCVFilterOperation.md) `EMCVFilterOperation`: A wrapped image operation by using block.
- [[API]](https://github.com/trmbhs/EMCVLib/blob/master/Documents/EMCVVideoCapture.md) `EMCVVideoCapture`: A wrapped video player class.
- [[API]](https://github.com/trmbhs/EMCVLib/blob/master/Documents/EMCVVideoWriter.md) `EMCVVideoWriter`: A wrapped video writer class.
- [[API]](https://github.com/trmbhs/EMCVLib/blob/master/Documents/NSImageView+EMCVLib.md) `NSImageView + EMCVLib`: A category of NSImageView.
- [[API]](https://github.com/trmbhs/EMCVLib/blob/master/Documents/UIImageView+EMCVLib.md) `UIImageView + EMCVLib`: A category of UIImageView.


# Contect

Blog: [http://enumsblog.com](http://enumsblog.com)

Email: [enum@enumsblog.com](enum@enumsblog.com)

### HAVE FUN! : )