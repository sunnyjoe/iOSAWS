//
//  AWSViewController.m
//  iOSAWS
//
//  Created by jiao qing on 11/8/16.
//  Copyright © 2016 jiao qing. All rights reserved.
//

#import "AWSViewController.h"
#import <AWSCore/AWSCore.h>
#import <AWSS3/AWSS3.h>

@interface AWSViewController ()

@end

@implementation AWSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AWSCognitoCredentialsProvider *credentialsProvider = [[AWSCognitoCredentialsProvider alloc]
                                                          initWithRegionType:AWSRegionAPNortheast1
                                                          identityPoolId:@"ap-northeast-1:41fbe60a-1270-4a84-b630-696f5af28430"];
    
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionAPNortheast1 credentialsProvider:credentialsProvider];
    
    [AWSServiceManager defaultServiceManager].defaultServiceConfiguration = configuration;
    
    
  
    // create a local image that we can use to upload to s3
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"flower.jpg"];
    NSData *imageData = UIImagePNGRepresentation([UIImage imageNamed:@"flower.jpg"]);
    [imageData writeToFile:path atomically:YES];
    NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
    
    
    AWSS3TransferManagerUploadRequest *uploadRequest = [AWSS3TransferManagerUploadRequest new];
    uploadRequest.bucket = @"tokyobucketstart";
    uploadRequest.key = @"test.txt";
    uploadRequest.contentType = @"image/jpg";
    uploadRequest.body = url;
 //   uploadRequest.contentLength = [NSNumber numberWithInteger:[imgData length]];
    

    AWSS3TransferManager *transferManager = [AWSS3TransferManager defaultS3TransferManager];
    
    [[transferManager upload:uploadRequest] continueWithExecutor:[AWSExecutor mainThreadExecutor]
                                                       withBlock:^id(AWSTask *task) {
                                                           if (task.error != nil) {
                                                               NSLog(@"Error %s %@", uploadRequest.key, task.error);
                                                           }
                                                           else { NSLog(@"Upload completed"); }
                                                           return nil;
                                                       }];
    
}



@end
