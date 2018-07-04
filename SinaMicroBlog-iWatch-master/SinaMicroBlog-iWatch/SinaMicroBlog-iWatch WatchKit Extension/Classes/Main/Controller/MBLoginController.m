//
//  MBLoginController.m
//  SinaMicroBlog-iWatch
//
//  Created by XingPengfei on 1/14/16.
//  Copyright © 2016 Pengfei Xing. All rights reserved.
//

#import "MBLoginController.h"
#import "MBWKAccountTool.h"
#import <WatchConnectivity/WatchConnectivity.h>

#import "MBAccount.h"
#import "MBWKAccountTool.h"

@interface MBLoginController () <WCSessionDelegate>

@property (nonatomic, strong) WCSession* session;
@property (nonatomic, strong) NSTimer *autoTimer;
@property (nonatomic, strong) MBAccount *account;

@end

@implementation MBLoginController

- (MBAccount *)account{
    if (nil == _account) {
        _account = [[MBAccount alloc] init];
    }
    return _account;
}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    NSLog(@"login controller controller id is: %@", [self valueForKey:@"_viewControllerID"]);
    _session = [WCSession defaultSession];
    _session.delegate = self;
    [_session activateSession];
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    self.autoTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(checkAccount) userInfo:nil repeats:YES];
}

- (void)checkAccount{
    NSLog(@"check Account");
    
//    NSDictionary *requestAccount = @{@"Request" : @"Request"};
    [self RequestForAccount];
    
    if ([MBWKAccountTool account]) {
        [self.autoTimer invalidate];
        self.autoTimer = nil;
        [WKInterfaceController reloadRootControllersWithNames:@[@"InterfaceController"] contexts:nil];
    }
}


- (void)RequestForAccount{
    NSLog(@"request");
    NSDictionary *dic = @{@"Request" : @"Request"};
    [self.session sendMessage:dic replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        
    } errorHandler:^(NSError * _Nonnull error) {
        NSLog(@"error is: %@", error);
    }];
}





//- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *,id> *)message replyHandler:(void (^)(NSDictionary<NSString *,id> * _Nonnull))replyHandler{
//    NSLog(@"apple watch receive");
//    
//    
//}



- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *,id> *)message replyHandler:(void (^)(NSDictionary<NSString *,id> * _Nonnull))replyHandler{
    
    NSLog(@"apple watch receive account : %@", _account);
    _account = [MBAccount accountWithDict:message];
    
    [MBWKAccountTool saveAccount:self.account];
    
}



- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
    
}

@end



