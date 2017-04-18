# EMCVFilterOperation

A wrapped image operation by using block.

See: [[EMCVFilter]](https://github.com/trmbhs/EMCVLib/blob/master/Documents/EMCVFilter.md)

- **[ObjC]**: Means this property or method can be used on Objective-C.
- **[ObjC++]**: Means this property or method can only be used on Objective-C++.

# Property

- **[ObjC]**: `tag`: A integer property.
- **[ObjC]**: `op`: A `void(^op)(EMCVBasicImage *)` block to do real work.

# Instance Method

## Initialization

- **[ObjC]**: `init`: Init a empty operation.
- **[ObjC]**: `initWithBlock`: Init a instance with a block.
- **[ObjC]**: `initWithBlock:andTag`: Init a instance with a block and a tag.

## Others

- **[ObjC]**: `setOperation`: Set operation.
- **[ObjC]**: `doOperationWithImage`: Do real work with a specified image.


# Class Method

empty

