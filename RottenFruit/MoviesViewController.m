//
//  MoviesViewController.m
//  RottenFruit
//
//  Created by Kenny Lin on 6/16/15.
//  Copyright (c) 2015 ABU. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "ViewController.h"
#import "Movie.h"
#import <UIImageView+AFNetworking.h>

@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *movies;

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.selectedMovie=[Movie alloc];
    [self refreshRemoteData];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
   
   // scrollView.insertSubview(refreshControl, atIndex: 0)
}

-(void) refreshRemoteData {
    NSString *apiKey=@"7ue5rxaj9xn4mhbmsuexug54";
    // NSstring *apiKey=@"aj3vdzzkb8h7r628q3w5akyz";  //kennylin's key
    NSString *apiURL=[NSString stringWithFormat: @"%@%@", @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?limit=20&apikey=", apiKey];
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString: apiURL]];
    [NSURLConnection sendAsynchronousRequest: request queue:[NSOperationQueue mainQueue] completionHandler: ^(NSURLResponse *response, NSData *data, NSError *connectionError){
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.movies=dict[@"movies"];
        [self.tableView reloadData];
    }];

}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movies.count;
}

-(void) onRefresh {
    [self refreshRemoteData];
    [self.refreshControl endRefreshing];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MyMovieCell" forIndexPath:indexPath];
    NSDictionary *movie=self.movies[indexPath.row];
    cell.titleLabel.text=movie[@"title"];
    cell.synopsisLabel.text=movie[@"synopsis"];
    NSString *posterURLStr= [movie valueForKeyPath:@"posters.thumbnail"];
    [cell.posterView setImageWithURL: [NSURL URLWithString:posterURLStr]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MovieCell *selectedCell=sender;
    NSIndexPath *indexPath=[self.tableView indexPathForCell: selectedCell];
    NSDictionary *movie=self.movies[indexPath.row];
    ViewController *destVC=[segue destinationViewController];
    [self.selectedMovie init:movie];
    destVC.myMovie=self.selectedMovie;
   
}



@end
