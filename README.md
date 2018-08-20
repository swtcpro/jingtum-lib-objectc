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

jingtum-lib-objectc is available through [CocoaPods](http://cocoapods.org). To install
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

## Remote class
Main handler for backend system. It creates a handle with jingtum, makes request to jingtum, 
subscribes event to jingtum, and gets info from jingtum.

## Request&lt;T&gt; class
Request server and account info without secret. Request is used to get server, account, orderbook 
and path info. Request is not secret required, and will be public to every one. All requests are 
asynchronized and should provide a callback. Each callback provides the json message, exception, 
and result object.

## Transaction&lt;T&gt; class
Post request to server with account secret. Transaction is used to make transaction and collect 
transaction parameter. Each transaction is secret required, and transaction can be signed local 
or remote. Now remote sign and local sign are supported. All transactions are asynchronized and 
should provide a callback. Each callback provides the json message, exception, and result object.

## Events  
You can listen events of the server.  
* Listening all transactions occur in the system. (Remote.Transactions event)
* Listening all last closed ledger event. (Remote.LedgerClosed event)
* Listening all server status change event. (Remote.ServerStatusChanged event)
* Listening all events for specific account. (Remote.CreateAccountStub method)
* Listening all events for specific orderbook pair. (Remote.CreateOrderBookStub method)

