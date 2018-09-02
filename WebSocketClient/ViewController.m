//
//  ViewController.m
//  WebSocketClient
//
//  Created by tongmuxu on 2018/5/15.
//  Copyright © 2018年 tongmuxu. All rights reserved.
//

#import "ViewController.h"
#import "SocketRocketUtility.h"
#import "NSData+Hash.h"
#import "NSString+Base58.h"
#import "Wallet.h"
#import "Transaction.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSDictionary *wallet1 = [Wallet generate];
//    NSLog(@"the wallet is %@", wallet1);
//
//    NSDictionary *wallet2 = [Wallet fromSecret:@"sszWqvtbDzzMQEVWqGDSA5DbMYDBN"];
//    NSLog(@"the wallet2 is %@", wallet2);
//    BOOL ret = [Wallet  isValidSecret:@"sszWqvtbDzzMQEVWqGDSA5DbMYDBN"];
//    if (ret) {
//        NSLog(@"the secret is valid");
//    } else {
//        NSLog(@"the secret is invalid");
//    }
    
//    BOOL ret = [[Remote instance] isValidAddress:@"jahbmVT3T9yf5D4Ykw8x6nRUtUfAAMzBRV"];
//    if (ret) {
//        NSLog(@"the address is valid");
//    } else {
//        NSLog(@"the address is invalid");
//    }
    
    // 连接
    remote = [Remote instance];
    [remote connectWithURLString:@"ws://123.57.219.57:5020" local_sign:true];
//    [[Remote instance] connectWithURLString:@"ws://139.129.194.175:5020" local:true];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SRWebSocketDidOpen) name:kWebSocketDidOpen object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SRWebSocketDidReceiveMsg:) name:kWebSocketdidReceiveMessage object:nil];
}

- (void)SRWebSocketDidOpen {
    NSLog(@"connect socket successfully");
    //在成功后需要做的操作。。。类似于 nodejs 里面的回调函数
//    [remote requestServerInfo];
//    [remote requestLedgerClosed];
    
//    [remote disconnect];
    
//    [remote requestLedgerClosed];
    
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    
//    NSNumber *ledger_index = [NSNumber numberWithInt:48371811111];
//    NSNumber *transactions = [NSNumber numberWithBool:YES];
//
////    [options setObject:ledger_index forKey:@"ledger_index"];
////    [options setObject:transactions forKey:@"transactions"];
//    // 
//    [options setObject:@"DB48A226AFFFDF02A782757DE55680905556EE4DBCFE3ACDA06D3B69481DF2xxx" forKey:@"ledger_hash"];
//    [options setObject:transactions forKey:@"transactions"];
//
//    [remote requestLedger:options];
    
    //////////////////////////
    // 这边传入的是 交易hash 哦！！！！
//    [options setObject:@"A732F92CB55814CB2C6191A0C8BBA3F6F76847C6F962A9166FA47A43A810BCD1" forKey:@"hash"];
//    [remote requestTx:options];
    
    //////////////////////////
//    [options setObject:@"jB7rxgh43ncbTX4WeMoeadiGMfmfqY2xLZ" forKey:@"account"];
//    [remote requestAccountInfo:options];
    
    //////////////////////////
//    [options setObject:@"jB7rxgh43ncbTX4WeMoeadiGMfmfqY2xLZ" forKey:@"account"];
//    [remote requestAccountTums:options];
    
    //////////////////////////
//    [options setObject:@"jB7rxgh43ncbTX4WeMoeadiGMfmfqY2xLZ" forKey:@"account"];
//    [options setObject:@"freeze" forKey:@"type"];
////    [options setObject:@"trust" forKey:@"type"];
//    [remote requestAccountRelations:options];
    
    //////////////////////////
//    [options setObject:@"jB7rxgh43ncbTX4WeMoeadiGMfmfqY2xLZ" forKey:@"account"];
//    [remote requestAccountOffers:options];
    
    //////////////////////////
//    [options setObject:@"jB7rxgh43ncbTX4WeMoeadiGMfmfqY2xLZ" forKey:@"account"];
//    [options setObject:@"1" forKey:@"limit"];
//    [remote requestAccountTx:options];
    
    //////////////////////////
//    NSMutableDictionary *gets = [[NSMutableDictionary alloc] init];
//    NSMutableDictionary *pays = [[NSMutableDictionary alloc] init];
//    [gets setObject:@"SWT" forKey:@"currency"];
//    [gets setObject:@"" forKey:@"issuer"];
//    [pays setObject:@"CNY" forKey:@"currency"];
//    [pays setObject:@"jBciDE8Q3uJjf111VeiUNM775AMKHEbBLS" forKey:@"issuer"];
//    [options setObject:gets forKey:@"taker_gets"];
//    [options setObject:pays forKey:@"taker_pays"];
//    NSNumber *limit = [NSNumber numberWithInteger:2];
//    [options setObject:limit forKey:@"limit"];
//    [remote requestOrderBook:options];

    /////////////////////
    [options setObject:@"jB7rxgh43ncbTX4WeMoeadiGMfmfqY2xLZ" forKey:@"account"];
    [options setObject:@"jpKcDjvqT1BJZ6G674tvLhYdNPtwPDU6vD" forKey:@"to"];

    NSMutableDictionary *amount = [[NSMutableDictionary alloc] init];
    NSNumber *value = [NSNumber numberWithFloat:2];
    [amount setObject:value forKey:@"value"];
    [amount setObject:@"SWT" forKey:@"currency"];
    [amount setObject:@" " forKey:@"issuer"];

    [options setObject:amount forKey:@"amount"];

    Transaction *tx = [[Remote instance] buildPaymentTx:options];

    [tx setSecret:@"sn37nYrQ6KPJvTFmaBYokS3FjXUWd"];
    [tx addMemo:@"给jDUjqoDZLhzx4DCf6pvSivjkjgtRESY62c支付0.5swt."];
    [tx addMemo:@"测试jerry"];
    [tx submit];
    
    /////////////////////
//    [options setObject:@"jB7rxgh43ncbTX4WeMoeadiGMfmfqY2xLZ" forKey:@"account"];
//    [options setObject:@"jDUjqoDZLhzx4DCf6pvSivjkjgtRESY62c" forKey:@"target"];
//
//    NSMutableDictionary *limit = [[NSMutableDictionary alloc] init];
//    [limit setObject:@"CCA" forKey:@"currency"];
//    [limit setObject:@"0.112" forKey:@"value"];
//    [limit setObject:@"js7M6x28mYDiZVJJtfJ84ydrv2PthY9W9u" forKey:@"issuer"];
//
//    [options setObject:limit forKey:@"limit"];
//    [options setObject:@"authorize" forKey:@"type"];
//
//    Transaction *tx = [[Remote instance] buildRelationTx:options];
//
//    [tx setSecret:@"sn37nYrQ6KPJvTFmaBYokS3FjXUWd"];
//    [tx submit];

    /////////////////////
//    [options setObject:@"jB7rxgh43ncbTX4WeMoeadiGMfmfqY2xLZ" forKey:@"account"];
//    [options setObject:@"property" forKey:@"type"];
//    Transaction *tx = [[Remote instance] buildAccountSetTx:options];
//    if (tx != nil) {
//        // signerSet 会返回 nil
//        [tx setSecret:@"sn37nYrQ6KPJvTFmaBYokS3FjXUWd"];
//        [tx submit];
//    }
    
    ///////////////////////
//    [options setObject:@"Sell" forKey:@"type"];
//    [options setObject:@"jB7rxgh43ncbTX4WeMoeadiGMfmfqY2xLZ" forKey:@"account"];
//
//    NSMutableDictionary *taker_gets = [[NSMutableDictionary alloc] init];
//    [taker_gets setObject:@"CNY" forKey:@"currency"];
//    [taker_gets setObject:@"0.01" forKey:@"value"];
//    [taker_gets setObject:@"jBciDE8Q3uJjf111VeiUNM775AMKHEbBLS" forKey:@"issuer"];
//
//    NSMutableDictionary *taker_pays = [[NSMutableDictionary alloc] init];
//    [taker_pays setObject:@"SWT" forKey:@"currency"];
//    [taker_pays setObject:@"1" forKey:@"value"];
//    [taker_pays setObject:@"" forKey:@"issuer"];
//
//    [options setObject:taker_gets forKey:@"taker_gets"];
//    [options setObject:taker_pays forKey:@"taker_pays"];
//
//    Transaction *tx = [[Remote instance] buildOfferCreateTx:options];
//
//    [tx setSecret:@"sn37nYrQ6KPJvTFmaBYokS3FjXUWd"];
//    [tx submit];
    
    /////////////////////
//    NSNumber *sequence = [NSNumber numberWithInt:1936];
//    [options setObject:sequence forKey:@"sequence"];
//    [options setObject:@"jB7rxgh43ncbTX4WeMoeadiGMfmfqY2xLZ" forKey:@"account"];
//
//    Transaction *tx = [[Remote instance] buildOfferCancelTx:options];
//
//    [tx setSecret:@"sn37nYrQ6KPJvTFmaBYokS3FjXUWd"];
//    [tx submit];
}

//string base58_encode(Integer num, string vers)
//{
//    string alphabet[58] = {"1","2","3","4","5","6","7","8","9","A","B","C","D","E","F",
//        "G","H","J","K","L","M","N","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c",
//        "d","e","f","g","h","i","j","k","m","n","o","p","q","r","s","t","u","v","w","x","y","z"};
//    int base_count = 58; string encoded; Integer div; Integer mod;
//    while (num >= base_count)
//    {
//        div = num / base_count;   mod = (num - (base_count * div));
//        encoded = alphabet[ mod.ConvertToLong() ] + encoded;   num = div;
//    }
//    encoded = vers + alphabet[ num.ConvertToLong() ] + encoded;
//    return encoded;
//}

- (void)SRWebSocketDidReceiveMsg:(NSNotification *)note {
    //收到服务端发送过来的消息
    NSString * message = note.object;
    NSLog(@"the response from server is: %@", message);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
