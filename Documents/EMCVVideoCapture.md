# EMCVVideoCapture

A wrapped video player class.

- **[ObjC]**: Means this property or method can be used on Objective-C.
- **[ObjC++]**: Means this property or method can only be used on Objective-C++.

# Property

- **[ObjC++]**: `_capture`: A `cv::VideoCapture` object.
- **[ObjC]**: `size`: Size of the video.
- **[ObjC]**: `frameRate`: FPS of the video.
- **[ObjC]**: `frameCount`: Frame count of the video.

# Instance Method

## Initialization

- **[ObjC]**: `initWithPath`: Open a local video file with a `NSString` path.
- **[ObjC]**: `initWithDevice`: Open a camera with index. If there is only one camera, set it to 0.

## Others

- **[ObjC]**: `nextFrame`: Get next frame in the current video. Return a `EMCVImage` instance.

# Class Method

empty