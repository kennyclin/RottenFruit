//
//  Movie.m
//  RottenFruit
//
//  Created by Kenny Lin on 6/17/15.
//  Copyright (c) 2015 ABU. All rights reserved.
//

#import "Movie.h"

@implementation Movie

-(void) init:(NSDictionary *) movieDict {
    self.title=movieDict[@"title"];
    self.synopsis=movieDict[@"synopsis"];
    NSString *posterURLStr=[self convertPosterUrlStringToHighRes:[movieDict valueForKeyPath:@"posters.thumbnail"]];
    self.thumbnailPoster=[NSURL URLWithString: posterURLStr];
    posterURLStr=[self convertPosterUrlStringToHighRes:[movieDict valueForKeyPath:@"posters.detailed"]];
    self.detailedPoster=[NSURL URLWithString:posterURLStr];
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

@end
