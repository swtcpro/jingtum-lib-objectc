//
//  ViewController.h
//  OCLibSample
//
//  Created by tongmuxu on 2018/8/21.
//  Copyright © 2018年 tongmuxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Remote.h>
#import <Wallet.h>

@interface ViewController : UIViewController
{
    Remote *remote;
    UITextField *secretField;
}

- (void)SRWebSocketDidOpen;


@end

