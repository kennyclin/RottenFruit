//
//  MovieCell.h
//  RottenFruit
//
//  Created by Kenny Lin on 6/16/15.
//  Copyright (c) 2015 ABU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@end
