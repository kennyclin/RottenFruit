//
//  Movie.h
//  RottenFruit
//
//  Created by Kenny Lin on 6/17/15.
//  Copyright (c) 2015 ABU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *synopsis;
@property (strong, nonatomic) NSURL *thumbnailPoster;
@property (strong, nonatomic) NSURL *detailedPoster;

-(void) init:(NSDictionary *) movieDict;
@end
