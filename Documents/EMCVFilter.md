# EMCVFilter

A wrapped image filter. 

It can do continuous image processing.

See: [[EMCVFilterOperation]](https://github.com/trmbhs/EMCVLib/blob/master/Documents/EMCVFilterOperation.md)

- **[ObjC]**: Means this property or method can be used on Objective-C.
- **[ObjC++]**: Means this property or method can only be used on Objective-C++.

# Property

empty.

# Instance Method

## Initialization

- **[ObjC]**: `init`: Init a instance empty filter;
- **[ObjC]**: `initWithArray`: Init a instance with a `EMCVFilterOperation` array.
- **[ObjC]**: `pushOperation`: Push a `EMCVFilterOperation` instance.
- **[ObjC]**: `pushOperationBlock`: Push a block instead a `EMCVFilterOperation` instance.
- **[ObjC]**: `pushOperationBlock:andTag`: Push a block instead a `EMCVFilterOperation` instance and set a tag for it.
- **[ObjC]**: `popOperation`: Pop a operation.
- **[ObjC]**: `runFilterWithCVImage`: Run filter with a specified `EMCVImage` instance.
- **[ObjC]**: `popAll`: Pop all operation.

## Others

empty.

# Class Method

empty.
