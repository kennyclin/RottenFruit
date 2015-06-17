//
//  MoviesViewController.h
//  RottenFruit
//
//  Created by Kenny Lin on 6/16/15.
//  Copyright (c) 2015 ABU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MoviesViewController : UIViewController

@property (strong, nonatomic) Movie *selectedMovie;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end
