//
//  ViewController.h
//  WebSocketClient
//
//  Created by tongmuxu on 2018/5/15.
//  Copyright © 2018年 tongmuxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Remote.h"

@interface ViewController : UIViewController
{
    Remote *remote;
}

- (void)SRWebSocketDidOpen;

@end

