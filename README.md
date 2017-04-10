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

# Document

Introduce each Class oo Founction in this library. Or you can see the demo code in this repo.

- **[ObjC]**: Means this property or method can be used on Objective-C.
- **[ObjC++]**: Means this property or method can only be used on Objective-C++ which means it's must a `.mm` source file.

## EMCVImage

A wrapped image class. Contains image data and some ancillary data.

### Property

- **[ObjC++]**: `_mat`: A `cv::Mat` object. It's image data.

### Instance Method

- **[ObjC]**: `initWithPath`: Open a local image file with a `NSString` path.
- **[ObjC]**: `initWithCVImage`: Init a instance with a `EMCVImage` instance. Means to make a copy.
- **[ObjC++]**: `initWithMat`: Init a instance with a `cv::Mat`.
- **[ObjC++]**: `initWithMat:cvtColor`: Init a instance with a `cv::Mat` and color formate like `CV_BGR2RGB` whitch is defined by OpenCV.
- **[ObjC++]**: `initWithNoCopyMat`: Init a instance with a `cv::Mat` and will not copy data.
- **[ObjC]**: `cvtColor`: Converts image from one color space to another. the Param must be like `CV_BGR2RGB` whitch is defined by OpenCV. The same as `cv::cvtColor`.
- **[ObjC]**: `toImage`: Converts image to a `NSImage` instance.

### Class Metod

empty

## EMCVVideo

A wrapped video class.

### Property

- **[ObjC++]**: `_capture`: A `cv::VideoCapture` object.

### Instance Method

- **[ObjC]**: `initWithPath`: Open a local video file with a `NSString` path.
- **[ObjC]**: `nextFrame`: Get next frame in the current video. Return a `EMCVImage` instance.

### Class Method

empty


## NSImageView + EMCVLib

### Property

empty

### Instance Method

- **[ObjC]**: `drawCVImage`: Display a `EMCVImage`.
- **[ObjC]**: `drawAndFitSizeWithCVImage`: Display and fit size with a `EMCVImage` instance.
- **[ObjC]**: `setImageAndFitSizeWithImage`: Redraw and display a `NSImage` instance.

### Class Method

empty

# Contect

Blog: [http://enumsblog.com](http://enumsblog.com)

Email: [enum@enumsblog.com](enum@enumsblog.com)

### HAVE FUN! : )