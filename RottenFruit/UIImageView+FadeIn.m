//
//  FadeInUIImageView.m
//  RottenFruit
//
//  Created by Kenny Lin on 6/17/15.
//  Copyright (c) 2015 ABU. All rights reserved.
//

#import "UIImageView+FadeIn.h"
#import "UIImageView+AFNetworking.h"

@implementation UIImageView (FadeIn)

- (void) fadeInImageWithURLRequest:(NSURLRequest *)urlRequest
                  placeholderImage:(UIImage *)placeholderImage
                           success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image))success
                           failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failure{
    __unsafe_unretained typeof(self) weakSelf = self;
    [self setImageWithURLRequest:urlRequest placeholderImage:placeholderImage success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        weakSelf.alpha=0.0;
        [UIView animateWithDuration: 1.0
                         animations:^{
                             // Cross-fade the images
                             weakSelf.alpha = 1.0;
                         }
                         completion:^(BOOL finished) {
                             // Finally remove the old imageView and replace with the new
                             
                         }];
        
        success(request, response, image);
        
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        failure(request, response, error);
    }];
}

- (void) fadeInImageWithURL:(NSURLRequest *)urlRequest {
    __unsafe_unretained typeof(self) weakSelf = self;
    [self setImageWithURLRequest:urlRequest placeholderImage:nil
                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                             weakSelf.alpha=0.0;
                             [UIView animateWithDuration: 0.1
                                              animations:^{
                                                  // Cross-fade the images
                                                  weakSelf.alpha = 1.0;
                                              }
                                              completion:^(BOOL finished) {
                                                  // Finally remove the old imageView and replace with the new
                                                  
                                              }];
                         } failure:
     ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
     }];
}

@end
