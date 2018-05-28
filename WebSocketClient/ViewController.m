//
//  ViewController.m
//  WebSocketClient
//
//  Created by tongmuxu on 2018/5/15.
//  Copyright © 2018年 tongmuxu. All rights reserved.
//

#import "ViewController.h"
#import "SocketRocketUtility.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[SocketRocketUtility instance] SRWebSocketOpenWithURLString:@"ws://ts5.jingtum.com:5020"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SRWebSocketDidOpen) name:kWebSocketDidOpenNote object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SRWebSocketDidReceiveMsg:) name:kWebSocketDidCloseNote object:nil];
    
    
    UIButton * sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    [sendBtn addTarget:self action:@selector(clickSendBtn:) forControlEvents:UIControlEventTouchUpInside];
    [sendBtn setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:sendBtn];
   
    
    
    
}


-(void)clickSendBtn:(UIButton*)sender
{
    
    
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:0];
    [dic setObject:@"131628" forKey:@"ledger_index"];
    [dic setObject:@"ledger_closed" forKey:@"command"];
    [dic setObject:[NSNumber numberWithBool:YES] forKey:@"transactions"];
  
    NSData * sendData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    NSLog(@"发送的Dic:%@===sendData:%@",dic,sendData);
    
    [[SocketRocketUtility instance] sendData:sendData];
  
    
}
- (void)SRWebSocketDidOpen {
    NSLog(@"开启成功");
    //在成功后需要做的操作。。。
    
    
  
    
    
}

- (void)SRWebSocketDidReceiveMsg:(NSNotification *)note {
    //收到服务端发送过来的消息
    NSString * message = note.object;
    NSLog(@"服务端发送过来的消息:%@",message);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
