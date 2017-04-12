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
- Edge Detection. Find extreme values and locations. Calculate and compare histograms.
- Matching algorithm: Template Match, Back Projection.

# Screenshots

Some screenshots of the demo.

### Image Smooth

![](https://github.com/trmbhs/EMCVLib/raw/master/Screenshots/smooth.png)

### Image Blending

![](https://github.com/trmbhs/EMCVLib/raw/master/Screenshots/blending.png)

### Threshold

![](https://github.com/trmbhs/EMCVLib/raw/master/Screenshots/threshold.png)

### Canny and Edge Detection

![](https://github.com/trmbhs/EMCVLib/raw/master/Screenshots/canny_and_contours.png)

### Max / Min value location of RGB

![](https://github.com/trmbhs/EMCVLib/raw/master/Screenshots/max_min_value_point_of_RGB.png)

### History Compare

![](https://github.com/trmbhs/EMCVLib/raw/master/Screenshots/histogram_compare.png)

### Template Match

![](https://github.com/trmbhs/EMCVLib/raw/master/Screenshots/template_match.png)

![](https://github.com/trmbhs/EMCVLib/raw/master/Screenshots/template_match_2.png)

### Back Projection

![](https://github.com/trmbhs/EMCVLib/raw/master/Screenshots/back_projection.png)


# Tips

Use `@autoreleasePool` when doing loop can solve some memory problems.

# Documents

API docs and bugs here.

- [[Bug]](https://github.com/trmbhs/EMCVLib/blob/master/Documents/bugs.md) Known bugs.

- [[API]](https://github.com/trmbhs/EMCVLib/blob/master/Documents/EMCVFactory.md) `EMCVFactory`: A wrapped functions whitch can do some computer vision calculations.
- [[API]](https://github.com/trmbhs/EMCVLib/blob/master/Documents/EMCVImage.md) `EMCVImage`: A wrapped image class.
- [[API]](https://github.com/trmbhs/EMCVLib/blob/master/Documents/EMCVSplitedImage.md) `EMCVSplitedImage`: A wrapped multi channel image class.
- [[API]](https://github.com/trmbhs/EMCVLib/blob/master/Documents/EMCVVideo.md) `EMCVVideo`: A wrapped video class.
- [[API]](https://github.com/trmbhs/EMCVLib/blob/master/Documents/NSImageView+EMCVLib.md) `NSImageView + EMCVLib`: A category of NSImageView.


# Contect

Blog: [http://enumsblog.com](http://enumsblog.com)

Email: [enum@enumsblog.com](enum@enumsblog.com)

### HAVE FUN! : )