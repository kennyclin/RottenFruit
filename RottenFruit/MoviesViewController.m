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
//#import "UIImageView+FadeIn.h"

@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *movies;
@property (strong, nonatomic) NSMutableArray *filteredMovies;
@property BOOL filtered;

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.itemSearch.delegate=self;
    self.selectedMovie=[Movie alloc];
    [self refreshRemoteData];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    self.filtered=FALSE;
   
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
        self.filteredMovies=[NSMutableArray arrayWithCapacity:self.movies.count];
    }];

}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.filtered){
        return self.filteredMovies.count;
    } else {
        return self.movies.count;
    }
}

-(void) onRefresh {
    [self refreshRemoteData];
    [self.refreshControl endRefreshing];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *movie;
    if (self.filtered){
        movie=self.filteredMovies[indexPath.row];
    } else {
        movie=self.movies[indexPath.row];
    }
    MovieCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MyMovieCell" forIndexPath:indexPath];
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

-(void) filterListForSearchText:(NSString *) searchText {
    // Update the filtered array based on the search text
    // Remove all objects from the filtered search array
    [self.filteredMovies removeAllObjects];
    for (NSDictionary *movie in self.movies){
        NSRange rangeTitle=[movie[@"title"] rangeOfString:searchText options: NSCaseInsensitiveSearch];
       // NSRange rangeSynopsis=[movie[@"synopsis"] rangeOfString:searchText options: NSCaseInsensitiveSearch];
        if (rangeTitle.length>0){ //|| rangeSynopsis.length>0){
            [self.filteredMovies addObject:movie];
        }
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
   // NSLog(searchBar.text);
    [searchBar resignFirstResponder];
    [self filterListForSearchText:searchBar.text];
    self.filtered=TRUE;
    [self.tableView reloadData];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    if (self.filtered){
        self.filtered=FALSE;
        [self.tableView reloadData];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    self.filtered=FALSE;
    [self.tableView reloadData];
    [searchBar resignFirstResponder];
}



-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterListForSearchText:searchString];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MovieCell *selectedCell=sender;
    NSIndexPath *indexPath=[self.tableView indexPathForCell: selectedCell];
    NSDictionary *movie=self.filtered?self.filteredMovies[indexPath.row]:self.movies[indexPath.row];
    ViewController *destVC=[segue destinationViewController];
    [self.selectedMovie init:movie];
    destVC.myMovie=self.selectedMovie;
   
}



@end
