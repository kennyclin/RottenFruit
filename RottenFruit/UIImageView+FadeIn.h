//
//  FadeInUIImageView.h
//  RottenFruit
//
//  Created by Kenny Lin on 6/17/15.
//  Copyright (c) 2015 ABU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (FadeIn)

- (void) fadeInImageWithURL:(NSURLRequest *)urlRequest;
- (void) fadeInImageWithURLRequest:(NSURLRequest *)urlRequest
              placeholderImage:(UIImage *)placeholderImage
              success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image))success
              failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failure;

@end
