//
//  AWSViewController.m
//  iOSAWS
//
//  Created by jiao qing on 11/8/16.
//  Copyright © 2016 jiao qing. All rights reserved.
//

#import "AWSViewController.h"
#import <AWSCore/AWSCore.h>

@interface AWSViewController ()

@end

@implementation AWSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AWSCognitoCredentialsProvider *credentialsProvider = [[AWSCognitoCredentialsProvider alloc] initWithRegionType:AWSRegionAPNortheast1 identityPoolId:@"ap-northeast-1_scINcU7Cw"];
    
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionAPNortheast1
                                                                         credentialsProvider:credentialsProvider];
    
    AWSServiceManager.defaultServiceManager.defaultServiceConfiguration = configuration;
}



@end
