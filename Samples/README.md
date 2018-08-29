# jingtum-lib-objective-c Sample code
This sample code shows how to install jingtum-lib-objective-c lib, then we can simply call the interfaces in Remote class to do things with jingtum network.

## Install
After download this sourcecode, we should run 
```ruby
pod install
```
to download the nessessary libraries

### Attention 
After run 
```ruby
pod install
```
we get all the needed libraries, then we should modify the file: Pods/CoreBitcoin/CoreBitcoin/BTCBase58.m
from

```ruby
static const char* BTCBase58Alphabet = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz";
```
to

```ruby
static const char* BTCBase58Alphabet = "jpshnaf39wBUDNEGHJKLM4PQRST7VWXYZ2bcdeCg65rkm8oFqi1tuvAxyz";
```

<br>

* Gets the account balances.
* Gets the account transactions history list.
* Gets and refreshes the orderbooks in system.
