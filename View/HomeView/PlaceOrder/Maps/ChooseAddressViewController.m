//
//  ChooseAddressViewController.m
//  JupViec
//
//  Created by Khanhlt on 12/12/19.
//  Copyright © 2019 Olala. All rights reserved.
//

#import "ChooseAddressViewController.h"

@interface ChooseAddressViewController ()

@end

@implementation ChooseAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    shouldShowSearchResult = NO;
    _filteredFullAddressArr = [[NSMutableArray alloc]init];
    _filteredPrimaryAddressArr = [[NSMutableArray alloc]init];
    _placesClient = [GMSPlacesClient sharedClient];
    _addressSearchBar.delegate = self;
}

- (void)getFileredAddressWith:(NSString*)searchAddress
{
    GMSAutocompleteSessionToken* token = [[GMSAutocompleteSessionToken alloc]init];
    GMSAutocompleteFilter* filter = [[GMSAutocompleteFilter alloc]init];
    filter.type = kGMSPlacesAutocompleteTypeFilterNoFilter;
    [_placesClient findAutocompletePredictionsFromQuery:searchAddress bounds:nil boundsMode:kGMSAutocompleteBoundsModeBias filter:filter sessionToken:token callback:^(NSArray<GMSAutocompletePrediction *> * _Nullable results, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"An error occurred %@-%@", searchAddress, [error localizedDescription]);
            return;
        }
        if (results != nil) {
            if ([self->_filteredFullAddressArr count] > 0) {
                [self->_filteredFullAddressArr removeAllObjects];
            }
            if ([self->_filteredPrimaryAddressArr count] > 0) {
                [self->_filteredPrimaryAddressArr removeAllObjects];
            }
            
            for (GMSAutocompletePrediction *result in results) {
                [self->_filteredFullAddressArr addObject:[result.attributedFullText string]];
                [self->_filteredPrimaryAddressArr addObject:[result.attributedPrimaryText string]];
            }
            [self->_addressTableView reloadData];
        }
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_filteredFullAddressArr count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    if (shouldShowSearchResult) {
         cell.textLabel.text = [_filteredPrimaryAddressArr objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [_filteredFullAddressArr objectAtIndex:indexPath.row];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Kết quả tìm kiếm";
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchText length] >= 3) {
        shouldShowSearchResult = YES;
        [self getFileredAddressWith:searchText];
    }
}

@end
