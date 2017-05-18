# EMCVVideoWriter

A wrapped video writer class.

- **[ObjC]**: Means this property or method can be used on Objective-C.
- **[ObjC++]**: Means this property or method can only be used on Objective-C++.

# Property

- **[ObjC++]**: `_writer`: A `cv::VideoWriter` object.
- **[ObjC]**: `size`: Size of the output video.
- **[ObjC]**: `frameRate`: FPS of the output video.

# Instance Method

## Initialization

- **[ObjC]**: `initWithPath:frameRate:size:outputFormat`: Set output video with path and other params.

## Others

- **[ObjC]**: `writeFrame`: Write a frame data to the file. Output file will be closed when object released.

# Class Method

empty