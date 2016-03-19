//
//  PWPhotoGalleryCollectionViewController.m
//  PWPhotoGallery
//
//  Created by Patrick Wiseman on 3/19/16.
//  Copyright © 2016 Patrick Wiseman. All rights reserved.
//

#import "PWPhotoGalleryCollectionViewController.h"
#import "PWPhotoGalleryCell.h"

@interface PWPhotoGalleryCollectionViewController ()

//Paging Setup
@property (assign) int currentPage;
@property (assign) int newPage;
@property (strong, nonatomic) NSIndexPath *currentIndexPath;
//Cell Properties
@property (strong, nonatomic) PWPhotoGalleryCell *cell;

@end

@implementation PWPhotoGalleryCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

#pragma mark - View Controller Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photoArray = [[NSMutableArray alloc] init];
    [self setupExampleData];
    self.currentIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    [self setupCollectionView];
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - Setup View

-(void)setupCollectionView
{
    //Various properties set directly on the collectionView.
    self.collectionView.backgroundColor = [UIColor blackColor];
    [self.collectionView setShowsHorizontalScrollIndicator:NO];
    [self.collectionView setPagingEnabled:NO];
    [self.collectionView registerClass:[PWPhotoGalleryCell class]
            forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
}

-(void)setupExampleData
{
    UIImage *image = [UIImage imageNamed:@"IMG_2008"];
    UIImage *image2 = [UIImage imageNamed:@"IMG_1805"];
    [self.photoArray addObject:image];
    [self.photoArray addObject:image2];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.photoArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UIImage *image = [self.photoArray objectAtIndex:indexPath.row];
    PWPhotoGalleryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.imageView.clipsToBounds = YES;
    cell.imageView.image = image;
    
    return cell;
}

//Set the size of the items within the collectionView.
-(CGSize)collectionView:(UICollectionView *)collectionView
                 layout:(UICollectionViewLayout *)collectionViewLayout
 sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.collectionView.frame.size;
}

#pragma mark - Scroll View Delegate Methods

//Method called when the scroll view begins dragging
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    float pageWidth = self.collectionView.frame.size.width + 15;
    self.currentPage = floor((self.collectionView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
}

//Method called when programmatic scrolling ends
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //Unhide the X buttons and info buttons
    [self.collectionView setUserInteractionEnabled:YES];
    //Unhide edit and report buttons
    int currentIndex = self.newPage;
    if(self.currentIndexPath != [NSIndexPath indexPathForItem:currentIndex inSection:0]){
        self.currentIndexPath = [NSIndexPath indexPathForItem:currentIndex inSection:0];
        self.selString = self.currentIndexPath;
    }
}

//Method called when user scrolling ends
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.collectionView setUserInteractionEnabled:YES];
    //Next and Prev button hiding
    //int offsetValue = self.collectionView.contentOffset.x + self.view.frame.size.width;
    //int frameWidth = self.view.frame.size.width;
    int currentIndex = self.newPage;
    NSArray *tempArray = @[self.currentIndexPath];
    if(self.currentIndexPath != [NSIndexPath indexPathForItem:currentIndex inSection:0]){
        self.currentIndexPath = [NSIndexPath indexPathForItem:currentIndex inSection:0];
        self.selString = self.currentIndexPath;
    } else {
        [self.collectionView reloadItemsAtIndexPaths:tempArray];
    }
    self.currentIndexPath = [NSIndexPath indexPathForItem:currentIndex inSection:0];
    self.selString = self.currentIndexPath;
}

//Method called when the scroll view ends dragging by the user
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGFloat pageWidth = self.collectionView.frame.size.width + 15;
    
    int currentPage = self.currentPage;
    self.newPage = currentPage;
    
    if(velocity.x == 0) {
        self.newPage = floor((targetContentOffset ->x - pageWidth / 2) / pageWidth) + 1;
    } else {
        if(velocity.x > 0){
            self.newPage = currentPage + 1;
        } else {
            self.newPage = currentPage - 1;
        }
        if(self.newPage < 0){
            self.newPage = 0;
        }
        if(self.newPage > self.collectionView.contentSize.width / pageWidth){
            self.newPage = ceil(self.collectionView.contentSize.width / pageWidth) - 1.0;
        }
    }
    
    *targetContentOffset = CGPointMake(self.newPage * pageWidth, targetContentOffset ->y);
    
}

@end
