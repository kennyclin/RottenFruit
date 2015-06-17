//
//  ViewController.m
//  RottenFruit
//
//  Created by Kenny Lin on 6/16/15.
//  Copyright (c) 2015 ABU. All rights reserved.
//

#import "ViewController.h"
//#import <UIImageView+AFNetworking.h>
#import "MBProgressHUD.h"
#import "UIImageView+FadeIn.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    self.titleLabel.text=self.myMovie.title;
    self.synopsisLabel.text=self.myMovie.synopsis;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [self.posterView fadeInImageWithURLRequest:[NSURLRequest requestWithURL: self.myMovie.detailedPoster] placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     self.posterView.image=image;
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                });
            } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                NSLog(@"Network failure!");
                [self showAlert];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }];
    });
    

}

-(void) showAlert{
    self.alertImage.hidden=FALSE;
    self.alertLabel.hidden=FALSE;
}

//Helper to workaround Rotten Tomatoes only giving low res images.
-(NSString *) convertPosterUrlStringToHighRes:(NSString *) urlString {
    NSRange range=[urlString rangeOfString:@".*cloudfront.net/" options:NSRegularExpressionSearch];
    NSString *returnValue=urlString;
    if (range.length>0){
        returnValue=[urlString stringByReplacingCharactersInRange:range withString:@"https://content6.flixster.com/"];
    }
    return returnValue;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
