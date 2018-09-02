//
//  ViewController.m
//  OCLibSample
//
//  Created by tongmuxu on 2018/8/21.
//  Copyright © 2018年 tongmuxu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    Wallet *wallet1 = [Wallet generate];
//    NSLog(@"the wallet is %@", wallet1);
    
    Wallet *wallet2 = [Wallet fromSecret:@"ss4EUqv9CqWtitJpwvGdDapE5GL9k"];
    NSLog(@"the wallet2 is %@", wallet2);
    
    // 连接
    remote = [Remote instance];
    [remote connectWithURLString:@"ws://123.57.219.57:5020" local_sign:true];
    //    [[Remote instance] connectWithURLString:@"ws://139.129.194.175:5020" local:true];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SRWebSocketDidOpen) name:kWebSocketDidOpen object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SRWebSocketDidReceiveMsg:) name:kWebSocketdidReceiveMessage object:nil];
    
    CGFloat yvar = 40;
    CGFloat ysize = 33;
    CGFloat xvar = 10;
    CGRect winSize = [UIScreen mainScreen].bounds;
    
    UIButton *generateBtn = [[UIButton alloc] initWithFrame:CGRectMake(xvar, yvar, winSize.size.width*0.5, ysize)];
    [generateBtn setTitle:@"随机生成钱包" forState:UIControlStateNormal];
    [generateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [generateBtn addTarget:self action:@selector(generateWallet) forControlEvents:UIControlEventTouchUpInside];
    [generateBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [generateBtn.layer setBorderWidth:1.0];
    generateBtn.layer.cornerRadius = 5.0;
    [self.view addSubview:generateBtn];
    
    yvar += ysize + 5;
    UIButton *generateBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(xvar, yvar, winSize.size.width*0.3, ysize)];
    [generateBtn2 setTitle:@"密码生成钱包" forState:UIControlStateNormal];
    [generateBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [generateBtn2 addTarget:self action:@selector(generateWallet2) forControlEvents:UIControlEventTouchUpInside];
    [generateBtn2.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [generateBtn2.layer setBorderWidth:1.0];
    generateBtn2.layer.cornerRadius = 5.0;
    [self.view addSubview:generateBtn2];
    
    secretField = [[UITextField alloc] initWithFrame:CGRectMake(xvar+winSize.size.width*0.3+5, yvar, winSize.size.width*0.7-xvar-5, ysize)];
    secretField.placeholder = @"请输入密码";
    secretField.adjustsFontSizeToFitWidth = YES;
    secretField.text = @"ss4EUqv9CqWtitJpwvGdDapE5GL9k";
    [self.view addSubview:secretField];
    
    yvar += ysize + 5;
    UIButton *serverBtn = [[UIButton alloc] initWithFrame:CGRectMake(xvar, yvar, winSize.size.width*0.45, ysize)];
    [serverBtn setTitle:@"底层服务器信息" forState:UIControlStateNormal];
    [serverBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [serverBtn addTarget:self action:@selector(requestServerInfo) forControlEvents:UIControlEventTouchUpInside];
    [serverBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [serverBtn.layer setBorderWidth:1.0];
    serverBtn.layer.cornerRadius = 5.0;
    [self.view addSubview:serverBtn];
    UIButton *currLedgerBtn = [[UIButton alloc] initWithFrame:CGRectMake(winSize.size.width*0.55-xvar-5, yvar, winSize.size.width*0.45, ysize)];
    [currLedgerBtn setTitle:@"最新账本信息" forState:UIControlStateNormal];
    [currLedgerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [currLedgerBtn addTarget:self action:@selector(requestLedgerClosed) forControlEvents:UIControlEventTouchUpInside];
    [currLedgerBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [currLedgerBtn.layer setBorderWidth:1.0];
    currLedgerBtn.layer.cornerRadius = 5.0;
    [self.view addSubview:currLedgerBtn];
    
    yvar += ysize + 5;
    UIButton *oneLedgerBtn = [[UIButton alloc] initWithFrame:CGRectMake(xvar, yvar, winSize.size.width*0.45, ysize)];
    [oneLedgerBtn setTitle:@"某一账本信息" forState:UIControlStateNormal];
    [oneLedgerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [oneLedgerBtn addTarget:self action:@selector(requestLedger) forControlEvents:UIControlEventTouchUpInside];
    [oneLedgerBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [oneLedgerBtn.layer setBorderWidth:1.0];
    oneLedgerBtn.layer.cornerRadius = 5.0;
    [self.view addSubview:oneLedgerBtn];
    UIButton *txBtn = [[UIButton alloc] initWithFrame:CGRectMake(winSize.size.width*0.55-xvar-5, yvar, winSize.size.width*0.45, ysize)];
    [txBtn setTitle:@"某一交易信息" forState:UIControlStateNormal];
    [txBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [txBtn addTarget:self action:@selector(requestTx) forControlEvents:UIControlEventTouchUpInside];
    [txBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [txBtn.layer setBorderWidth:1.0];
    txBtn.layer.cornerRadius = 5.0;
    [self.view addSubview:txBtn];
    
    yvar += ysize + 5;
    UIButton *accountBtn = [[UIButton alloc] initWithFrame:CGRectMake(xvar, yvar, winSize.size.width*0.45, ysize)];
    [accountBtn setTitle:@"某一账号信息" forState:UIControlStateNormal];
    [accountBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [accountBtn addTarget:self action:@selector(requestAccountInfo) forControlEvents:UIControlEventTouchUpInside];
    [accountBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [accountBtn.layer setBorderWidth:1.0];
    accountBtn.layer.cornerRadius = 5.0;
    [self.view addSubview:accountBtn];
    
    UIButton *tumBtn = [[UIButton alloc] initWithFrame:CGRectMake(winSize.size.width*0.55-xvar-5, yvar, winSize.size.width*0.45, ysize)];
    [tumBtn setTitle:@"账号可操作货币" forState:UIControlStateNormal];
    [tumBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [tumBtn addTarget:self action:@selector(requestAccountTums) forControlEvents:UIControlEventTouchUpInside];
    [tumBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [tumBtn.layer setBorderWidth:1.0];
    tumBtn.layer.cornerRadius = 5.0;
    [self.view addSubview:tumBtn];
    
    yvar += ysize + 5;
    UIButton *relBtn = [[UIButton alloc] initWithFrame:CGRectMake(xvar, yvar, winSize.size.width*0.45, ysize)];
    [relBtn setTitle:@"账号关系信息" forState:UIControlStateNormal];
    [relBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [relBtn addTarget:self action:@selector(requestAccountRelations) forControlEvents:UIControlEventTouchUpInside];
    [relBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [relBtn.layer setBorderWidth:1.0];
    relBtn.layer.cornerRadius = 5.0;
    [self.view addSubview:relBtn];
    
    UIButton *offerBtn = [[UIButton alloc] initWithFrame:CGRectMake(winSize.size.width*0.55-xvar-5, yvar, winSize.size.width*0.45, ysize)];
    [offerBtn setTitle:@"账号挂单信息" forState:UIControlStateNormal];
    [offerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [offerBtn addTarget:self action:@selector(requestAccountOffers) forControlEvents:UIControlEventTouchUpInside];
    [offerBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [offerBtn.layer setBorderWidth:1.0];
    offerBtn.layer.cornerRadius = 5.0;
    [self.view addSubview:offerBtn];
    
    yvar += ysize + 5;
    UIButton *atxBtn = [[UIButton alloc] initWithFrame:CGRectMake(xvar, yvar, winSize.size.width*0.45, ysize)];
    [atxBtn setTitle:@"账号交易列表" forState:UIControlStateNormal];
    [atxBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [atxBtn addTarget:self action:@selector(requestAccountTx) forControlEvents:UIControlEventTouchUpInside];
    [atxBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [atxBtn.layer setBorderWidth:1.0];
    atxBtn.layer.cornerRadius = 5.0;
    [self.view addSubview:atxBtn];
    
    UIButton *orderBtn = [[UIButton alloc] initWithFrame:CGRectMake(winSize.size.width*0.55-xvar-5, yvar, winSize.size.width*0.45, ysize)];
    [orderBtn setTitle:@"市场挂单列表" forState:UIControlStateNormal];
    [orderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [orderBtn addTarget:self action:@selector(requestOrderBook) forControlEvents:UIControlEventTouchUpInside];
    [orderBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [orderBtn.layer setBorderWidth:1.0];
    orderBtn.layer.cornerRadius = 5.0;
    [self.view addSubview:orderBtn];
    
    yvar += ysize + 5;
    UIButton *paymentBtn = [[UIButton alloc] initWithFrame:CGRectMake(xvar, yvar, winSize.size.width*0.45, ysize)];
    [paymentBtn setTitle:@"支付" forState:UIControlStateNormal];
    [paymentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [paymentBtn addTarget:self action:@selector(buildPaymentTx) forControlEvents:UIControlEventTouchUpInside];
    [paymentBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [paymentBtn.layer setBorderWidth:1.0];
    paymentBtn.layer.cornerRadius = 5.0;
    [self.view addSubview:paymentBtn];
    
    UIButton *brelBtn = [[UIButton alloc] initWithFrame:CGRectMake(winSize.size.width*0.55-xvar-5, yvar, winSize.size.width*0.45, ysize)];
    [brelBtn setTitle:@"设置关系" forState:UIControlStateNormal];
    [brelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [brelBtn addTarget:self action:@selector(buildRelationTx) forControlEvents:UIControlEventTouchUpInside];
    [brelBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [brelBtn.layer setBorderWidth:1.0];
    brelBtn.layer.cornerRadius = 5.0;
    [self.view addSubview:brelBtn];
    
    yvar += ysize + 5;
    UIButton *asetBtn = [[UIButton alloc] initWithFrame:CGRectMake(xvar, yvar, winSize.size.width*0.45, ysize)];
    [asetBtn setTitle:@"设置账号属性" forState:UIControlStateNormal];
    [asetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [asetBtn addTarget:self action:@selector(buildAccountSetTx) forControlEvents:UIControlEventTouchUpInside];
    [asetBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [asetBtn.layer setBorderWidth:1.0];
    asetBtn.layer.cornerRadius = 5.0;
    [self.view addSubview:asetBtn];
    
    yvar += ysize + 5;
    UIButton *ocreateBtn = [[UIButton alloc] initWithFrame:CGRectMake(xvar, yvar, winSize.size.width*0.45, ysize)];
    [ocreateBtn setTitle:@"挂单" forState:UIControlStateNormal];
    [ocreateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [ocreateBtn addTarget:self action:@selector(buildOfferCreateTx) forControlEvents:UIControlEventTouchUpInside];
    [ocreateBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [ocreateBtn.layer setBorderWidth:1.0];
    ocreateBtn.layer.cornerRadius = 5.0;
    [self.view addSubview:ocreateBtn];
    
    UIButton *ocancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(winSize.size.width*0.55-xvar-5, yvar, winSize.size.width*0.45, ysize)];
    [ocancelBtn setTitle:@"取消挂单" forState:UIControlStateNormal];
    [ocancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [ocancelBtn addTarget:self action:@selector(buildOfferCancelTx) forControlEvents:UIControlEventTouchUpInside];
    [ocancelBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [ocancelBtn.layer setBorderWidth:1.0];
    ocancelBtn.layer.cornerRadius = 5.0;
    [self.view addSubview:ocancelBtn];
    
}

-(void)generateWallet
{
    NSDictionary *wallet = [Wallet generate];
    NSLog(@"the wallet is %@", wallet);
    
    NSString *msg = [NSString stringWithFormat:@"address:%@ \r\nsecret:%@", [wallet objectForKey:@"address"], [wallet objectForKey:@"secret"]];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"新建钱包为" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

-(void)generateWallet2
{
    NSString *text = secretField.text;
    if ([text length] <= 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请输入密码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    NSDictionary *wallet = [Wallet fromSecret:text];
    NSLog(@"the wallet is %@", wallet);
    NSString *msg = [NSString stringWithFormat:@"address:%@ \r\nsecret:%@", [wallet objectForKey:@"address"], [wallet objectForKey:@"secret"]];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"钱包为" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

-(void)requestServerInfo
{
    [remote requestServerInfo];
}

-(void)requestLedgerClosed
{
    [remote requestLedgerClosed];
}

-(void)requestLedger
{
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    NSNumber *ledger_index = [NSNumber numberWithInt:483718];
    NSNumber *transactions = [NSNumber numberWithBool:YES];
    
    [options setObject:ledger_index forKey:@"ledger_index"];
    [options setObject:transactions forKey:@"transactions"];
    
    [remote requestLedger:options];
}

-(void)requestTx
{
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    [options setObject:@"A4C52EF5A3075BF6169BA0AC716BF26A989B97BEDE53DC3BA1C252CF1338E0C7" forKey:@"hash"];
    [remote requestTx:options];
    
}

-(void)requestAccountInfo
{
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    [options setObject:@"jB7rxgh43ncbTX4WeMoeadiGMfmfqY2xLZ" forKey:@"account"];
    [remote requestAccountInfo:options];
    
}

-(void)requestAccountTums
{
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    [options setObject:@"jB7rxgh43ncbTX4WeMoeadiGMfmfqY2xLZ" forKey:@"account"];
    [remote requestAccountTums:options];
    
}

-(void)requestAccountRelations
{
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    [options setObject:@"jB7rxgh43ncbTX4WeMoeadiGMfmfqY2xLZ" forKey:@"account"];
    [options setObject:@"trust" forKey:@"type"];
    [remote requestAccountRelations:options];
    
}

-(void)requestAccountOffers
{
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    [options setObject:@"jB7rxgh43ncbTX4WeMoeadiGMfmfqY2xLZ" forKey:@"account"];
    [remote requestAccountOffers:options];
    
}

-(void)requestAccountTx
{
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    [options setObject:@"jB7rxgh43ncbTX4WeMoeadiGMfmfqY2xLZ" forKey:@"account"];
    [remote requestAccountTx:options];
    
}

-(void)requestOrderBook
{
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *gets = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *pays = [[NSMutableDictionary alloc] init];
    [gets setObject:@"SWT" forKey:@"currency"];
    [gets setObject:@"" forKey:@"issuer"];
    [pays setObject:@"CNY" forKey:@"currency"];
    [pays setObject:@"jBciDE8Q3uJjf111VeiUNM775AMKHEbBLS" forKey:@"issuer"];
    [options setObject:gets forKey:@"taker_gets"];
    [options setObject:pays forKey:@"taker_pays"];
    NSNumber *limit = [NSNumber numberWithInteger:2];
    [options setObject:limit forKey:@"limit"];
    [remote requestOrderBook:options];
}

-(void)buildPaymentTx
{
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    [options setObject:@"jB7rxgh43ncbTX4WeMoeadiGMfmfqY2xLZ" forKey:@"account"];
    [options setObject:@"jpKcDjvqT1BJZ6G674tvLhYdNPtwPDU6vD" forKey:@"to"];
    
    NSMutableDictionary *amount = [[NSMutableDictionary alloc] init];
    NSNumber *value = [NSNumber numberWithFloat:2];
    [amount setObject:value forKey:@"value"];
    [amount setObject:@"SWT" forKey:@"currency"];
    [amount setObject:@" " forKey:@"issuer"];
    
    [options setObject:amount forKey:@"amount"];
    
    Transaction *tx = [[Remote instance] buildPaymentTx:options];
    
    if (tx != nil) {
        [tx setSecret:@"sn37nYrQ6KPJvTFmaBYokS3FjXUWd"];
        [tx addMemo:@"给jDUjqoDZLhzx4DCf6pvSivjkjgtRESY62c支付0.5swt."];
        [tx addMemo:@"测试jerry"];
        [tx submit];
    }
}

-(void)buildRelationTx
{
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    [options setObject:@"jB7rxgh43ncbTX4WeMoeadiGMfmfqY2xLZ" forKey:@"account"];
    [options setObject:@"jDUjqoDZLhzx4DCf6pvSivjkjgtRESY62c" forKey:@"target"];
    
    NSMutableDictionary *limit = [[NSMutableDictionary alloc] init];
    [limit setObject:@"CCA" forKey:@"currency"];
    [limit setObject:@"0.112" forKey:@"value"];
    [limit setObject:@"js7M6x28mYDiZVJJtfJ84ydrv2PthY9W9u" forKey:@"issuer"];
    
    [options setObject:limit forKey:@"limit"];
    [options setObject:@"authorize" forKey:@"type"];
    
    Transaction *tx = [[Remote instance] buildRelationTx:options];
    
    if (tx != nil) {
        [tx setSecret:@"sn37nYrQ6KPJvTFmaBYokS3FjXUWd"];
        [tx submit];
    }
}

-(void)buildAccountSetTx
{
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    [options setObject:@"jB7rxgh43ncbTX4WeMoeadiGMfmfqY2xLZ" forKey:@"account"];
    [options setObject:@"property" forKey:@"type"];
    Transaction *tx = [[Remote instance] buildAccountSetTx:options];
    if (tx != nil) {
        // signerSet 会返回 nil
        [tx setSecret:@"sn37nYrQ6KPJvTFmaBYokS3FjXUWd"];
        [tx submit];
    }
}

-(void)buildOfferCreateTx
{
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    [options setObject:@"Sell" forKey:@"type"];
    [options setObject:@"jB7rxgh43ncbTX4WeMoeadiGMfmfqY2xLZ" forKey:@"account"];
    
    NSMutableDictionary *taker_gets = [[NSMutableDictionary alloc] init];
    [taker_gets setObject:@"CNY" forKey:@"currency"];
    [taker_gets setObject:@"0.01" forKey:@"value"];
    [taker_gets setObject:@"jBciDE8Q3uJjf111VeiUNM775AMKHEbBLS" forKey:@"issuer"];
    
    NSMutableDictionary *taker_pays = [[NSMutableDictionary alloc] init];
    [taker_pays setObject:@"SWT" forKey:@"currency"];
    [taker_pays setObject:@"1" forKey:@"value"];
    [taker_pays setObject:@"" forKey:@"issuer"];
    
    [options setObject:taker_gets forKey:@"taker_gets"];
    [options setObject:taker_pays forKey:@"taker_pays"];
    
    Transaction *tx = [[Remote instance] buildOfferCreateTx:options];
    
    if (tx != nil) {
        [tx setSecret:@"sn37nYrQ6KPJvTFmaBYokS3FjXUWd"];
        [tx submit];
    }
}

-(void)buildOfferCancelTx
{
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    NSNumber *sequence = [NSNumber numberWithInt:1936];
    [options setObject:sequence forKey:@"sequence"];
    [options setObject:@"jB7rxgh43ncbTX4WeMoeadiGMfmfqY2xLZ" forKey:@"account"];
    
    Transaction *tx = [[Remote instance] buildOfferCancelTx:options];
    
    if (tx != nil) {
        [tx setSecret:@"sn37nYrQ6KPJvTFmaBYokS3FjXUWd"];
        [tx submit];
    }
}

- (void)SRWebSocketDidOpen {
    NSLog(@"connect socket successfully");
    //在成功后需要做的操作。。。类似于 nodejs 里面的回调函数
    //    [remote requestServerInfo];
//    [remote requestLedgerClosed];
    
    //    [remote disconnect];
    
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
//
//        NSNumber *ledger_index = [NSNumber numberWithInt:483718];
//        NSNumber *transactions = [NSNumber numberWithBool:YES];
//
//        [options setObject:ledger_index forKey:@"ledger_index"];
//        [options setObject:transactions forKey:@"transactions"];
//
//        [remote requestLedger:options];
    
    //////////////////////////
    // 这边传入的是 交易hash 哦！！！！
//        [options setObject:@"A4C52EF5A3075BF6169BA0AC716BF26A989B97BEDE53DC3BA1C252CF1338E0C7" forKey:@"hash"];
//        [remote requestTx:options];
    
    //////////////////////////
//        [options setObject:@"jB7rxgh43ncbTX4WeMoeadiGMfmfqY2xLZ" forKey:@"account"];
//        [remote requestAccountInfo:options];
    
    //////////////////////////
//        [options setObject:@"jB7rxgh43ncbTX4WeMoeadiGMfmfqY2xLZ" forKey:@"account"];
//        [remote requestAccountTums:options];
    
    //////////////////////////
//        [options setObject:@"jB7rxgh43ncbTX4WeMoeadiGMfmfqY2xLZ" forKey:@"account"];
//        [options setObject:@"trust" forKey:@"type"];
//        [remote requestAccountRelations:options];
    
    //////////////////////////
//        [options setObject:@"jB7rxgh43ncbTX4WeMoeadiGMfmfqY2xLZ" forKey:@"account"];
//        [remote requestAccountOffers:options];
    
    //////////////////////////
//        [options setObject:@"jB7rxgh43ncbTX4WeMoeadiGMfmfqY2xLZ" forKey:@"account"];
//        [remote requestAccountTx:options];
    
    //////////////////////////
//        NSMutableDictionary *gets = [[NSMutableDictionary alloc] init];
//        NSMutableDictionary *pays = [[NSMutableDictionary alloc] init];
//        [gets setObject:@"SWT" forKey:@"currency"];
//        [gets setObject:@"" forKey:@"issuer"];
//        [pays setObject:@"CNY" forKey:@"currency"];
//        [pays setObject:@"jBciDE8Q3uJjf111VeiUNM775AMKHEbBLS" forKey:@"issuer"];
//        [options setObject:gets forKey:@"gets"];
//        [options setObject:pays forKey:@"pays"];
//        NSNumber *limit = [NSNumber numberWithInteger:2];
//        [options setObject:limit forKey:@"limit"];
//        [remote requestOrderBook:options];
    
    /////////////////////
//        [options setObject:@"jB7rxgh43ncbTX4WeMoeadiGMfmfqY2xLZ" forKey:@"account"];
//        [options setObject:@"jpKcDjvqT1BJZ6G674tvLhYdNPtwPDU6vD" forKey:@"to"];
//    //    [options setObject:@"jpKcDjvqT1BJZ6G674tvLhYdNPtwPDU6vD" forKey:@"account"];
//    //    [options setObject:@"jB7rxgh43ncbTX4WeMoeadiGMfmfqY2xLZ" forKey:@"to"];
//
//        NSMutableDictionary *amount = [[NSMutableDictionary alloc] init];
//        NSNumber *value = [NSNumber numberWithFloat:2];
//        [amount setObject:value forKey:@"value"];
//        [amount setObject:@"SWT" forKey:@"currency"];
//        [amount setObject:@" " forKey:@"issuer"];
//
//        [options setObject:amount forKey:@"amount"];
//
//    //    [dic setObject:@"sn37nYrQ6KPJvTFmaBYokS3FjXUWd" forKey:@"secret"];
//    //    [dic setObject:@"给jDUjqoDZLhzx4DCf6pvSivjkjgtRESY62c支付0.5swt." forKey:@"memo"];
//
//        Transaction *tx = [[Remote instance] buildPaymentTx:options];
//
//        [tx setSecret:@"sn37nYrQ6KPJvTFmaBYokS3FjXUWd"];
//    //    [tx setSecret:@"ssPstTqs7hTWXzDFj88Um9fZDeNUK"];
//        [tx addMemo:@"给jDUjqoDZLhzx4DCf6pvSivjkjgtRESY62c支付0.5swt."];
//        [tx submit];
    
    /////////////////////
//        [options setObject:@"jB7rxgh43ncbTX4WeMoeadiGMfmfqY2xLZ" forKey:@"account"];
//        [options setObject:@"jDUjqoDZLhzx4DCf6pvSivjkjgtRESY62c" forKey:@"target"];
//
//        NSMutableDictionary *limit = [[NSMutableDictionary alloc] init];
//        [limit setObject:@"CCA" forKey:@"currency"];
//        [limit setObject:@"0.112" forKey:@"value"];
//        [limit setObject:@"js7M6x28mYDiZVJJtfJ84ydrv2PthY9W9u" forKey:@"issuer"];
//
//        [options setObject:limit forKey:@"limit"];
//        [options setObject:@"authorize" forKey:@"type"];
//
//        Transaction *tx = [[Remote instance] buildRelationTx:options];
//
//        [tx setSecret:@"sn37nYrQ6KPJvTFmaBYokS3FjXUWd"];
//        [tx submit];
    
    /////////////////////
//        [options setObject:@"jB7rxgh43ncbTX4WeMoeadiGMfmfqY2xLZ" forKey:@"account"];
//        [options setObject:@"property" forKey:@"type"];
//        Transaction *tx = [[Remote instance] buildAccountSetTx:options];
//        if (tx != nil) {
//            // signerSet 会返回 nil
//            [tx setSecret:@"sn37nYrQ6KPJvTFmaBYokS3FjXUWd"];
//            [tx submit];
//        }
    
    ///////////////////////
//        [options setObject:@"Sell" forKey:@"type"];
//        [options setObject:@"jB7rxgh43ncbTX4WeMoeadiGMfmfqY2xLZ" forKey:@"account"];
//
//        NSMutableDictionary *taker_gets = [[NSMutableDictionary alloc] init];
//        [taker_gets setObject:@"CNY" forKey:@"currency"];
//        [taker_gets setObject:@"0.01" forKey:@"value"];
//        [taker_gets setObject:@"jBciDE8Q3uJjf111VeiUNM775AMKHEbBLS" forKey:@"issuer"];
//
//        NSMutableDictionary *taker_pays = [[NSMutableDictionary alloc] init];
//        [taker_pays setObject:@"SWT" forKey:@"currency"];
//        [taker_pays setObject:@"1" forKey:@"value"];
//        [taker_pays setObject:@"" forKey:@"issuer"];
//
//        [options setObject:taker_gets forKey:@"taker_gets"];
//        [options setObject:taker_pays forKey:@"taker_pays"];
//
//        Transaction *tx = [[Remote instance] buildOfferCreateTx:options];
//
//        [tx setSecret:@"sn37nYrQ6KPJvTFmaBYokS3FjXUWd"];
//        [tx submit];
    
    /////////////////////
//        NSNumber *sequence = [NSNumber numberWithInt:1936];
//        [options setObject:sequence forKey:@"sequence"];
//        [options setObject:@"jB7rxgh43ncbTX4WeMoeadiGMfmfqY2xLZ" forKey:@"account"];
//
//        Transaction *tx = [[Remote instance] buildOfferCancelTx:options];
//
//        [tx setSecret:@"sn37nYrQ6KPJvTFmaBYokS3FjXUWd"];
//        [tx submit];
}

- (void)SRWebSocketDidReceiveMsg:(NSNotification *)note {
    //收到服务端发送过来的消息
    NSString * message = note.object;
    NSLog(@"the response from server is: %@", message);
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"响应报文" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
