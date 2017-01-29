# MuscleAssert [![Build Status](https://travis-ci.org/akuraru/MuscleAssert-Objective-C.svg?branch=master)](https://travis-ci.org/akuraru/MuscleAssert-Objective-C) [![codecov](https://codecov.io/gh/akuraru/MuscleAssert-Objective-C/branch/master/graph/badge.svg)](https://codecov.io/gh/akuraru/MuscleAssert-Objective-C)


A unit test framework for Objective-C using computation expressions.

## Proposal

What is `MuscleAssert`

* provide an assertion message that makes the difference more obvious.
* is not "where is it going?" But "What's different?"

### Related Link

* http://bleis-tift.hatenablog.com/entry/about-power-assert
* http://pocketberserker.hatenablog.com/entry/2016/06/02/143727
* https://github.com/persimmon-projects/Persimmon.MuscleAssert
* http://bleis-tift.hatenablog.com/entry/hello-muscle-assert

## Description

* 

## Installation

### CocoaPods

1. `pod 'MuscleAssert'`

## Usage

```
NSArray *left = @{
    @"user": @{
        @"name" : @"akuraru",
    }
};
NSArray *right = @{
    @"user": @{
        @"name" : @"",
    }
};
```

Result

```
path: .user.name.0
left: akuraru
right: 
```


## Contributing

pull-requests, issue reports and patches are always welcomed.

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## License

MIT
