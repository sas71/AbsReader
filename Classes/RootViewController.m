//
//  RootViewController.m
//  AbsReader
//
//  Created by Sven A. Schmidt on 23.01.11.
//  Copyright 2011 abstracture GmbH & Co. KG. All rights reserved.
//

#import "RootViewController.h"
#import "FeedViewController.h"
#import "SettingsViewController.h"


@implementation RootViewController

@synthesize feeds;
@synthesize feedControllers;


- (id)initWithStyle:(UITableViewStyle)style {
  self = [super initWithStyle:style];
  if (self) {
  }
  return self;
}


- (void)dealloc {
  [super dealloc];
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}


#pragma mark -
#pragma mark Workers


- (void)addFeed:(id)sender {
  SettingsViewController *vc = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
  [self.navigationController pushViewController:vc animated:YES];
  [vc release];
}


#pragma mark -
#pragma mark - View lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];

  self.title = @"AbsReader";

  // self.navigationItem.rightBarButtonItem = self.editButtonItem;
  self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addFeed:)] autorelease];

  self.feeds = [NSMutableArray array];
  self.feedControllers = [NSMutableArray array];
  {
    FeedCache *feed = [[[FeedCache alloc] init] autorelease];
    NSString *url = @"https://dev.abstracture.de/projects/abstracture/timeline?ticket=on&ticket_details=on&changeset=on&milestone=on&wiki=on&max=50&daysback=90&format=rss";
    feed.url = [NSURL URLWithString:url];
    feed.title = @"abs Timeline";
    FeedViewController *vc = [[FeedViewController alloc] initWithNibName:@"FeedViewController" bundle:nil];
    vc.feed = feed;
    vc.title = feed.title;
    feed.delegate = vc;
    [self.feeds addObject:feed];
    [self.feedControllers addObject:vc];
  }
  {
    FeedCache *feed = [[[FeedCache alloc] init] autorelease];
    NSString *url = @"https://dev.abstracture.de/projects/gf/timeline?milestone=on&ticket=on&ticket_details=on&wiki=on&max=50&authors=&daysback=90&format=rss";
    feed.url = [NSURL URLWithString:url];
    feed.title = @"GF Timeline";
    FeedViewController *vc = [[FeedViewController alloc] initWithNibName:@"FeedViewController" bundle:nil];
    vc.feed = feed;
    feed.delegate = vc;
    [self.feeds addObject:feed];
    [self.feedControllers addObject:vc];
  }
}


- (void)viewDidUnload {
  [super viewDidUnload];
}


- (void)viewWillAppear:(BOOL)animated{
  [super viewWillAppear:animated];
}


- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}


- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
}


- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}


#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.feeds count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
  }
  
  FeedCache *feed = [self.feeds objectAtIndex:indexPath.row];
  cell.textLabel.text = feed.title;
  
  return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  FeedViewController *vc = [self.feedControllers objectAtIndex:indexPath.row];
  [self.navigationController pushViewController:vc animated:YES];
}

@end
