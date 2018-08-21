# jingtum-lib-objective-c
The jingtum-lib-objective-c library to be used for interacting with jingtum blockchain network. 
This is the objective-c version.

## Source code  
* src/jingtum-lib - The source codes of jingtum lib.
* src/ViewController.m - The tests for jingtum lib.
* Samples - The samples to use the jingtum lib.
* docs - The documentation for the jingtum lib.

## Supporting Environment
* MacOS 

## Development Environment
* MacOS
* Xcode

## References:
The following libraries are referenced.
* SocketRocket (https://github.com/facebook/SocketRocket)
* CoreBitcoin (https://github.com/oleganza/CoreBitcoin)

## Install
After download this sourcecode, we should run 
```ruby
pod install
```
to download the nessessary libraries


Also jingtum-lib-objectc is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "jingtum-lib-objectc"
```

## Summary
The jingtum-lib-objective-c library is based on the ws protocol to connect with jingtum system. 
The Remote class provides public APIs to create two kinds of objects: Request object by GET
method, and Transaction object by POST method. And then can submit data to server through 
Submit() method.

## How to use
1) Create a new instance of Remote class.  
```
    Remote *remote = [Remote instance];
```

2) Connect to server.  
```
    [remote connectWithURLString:@"ws://123.57.219.57:5020" local_sign:true];
```

3) Close the connection
```
    remote.Disconnect();
```

