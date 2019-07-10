
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "ELCAssetSelectionDelegate.h"
#import "ELCAssetPickerFilterDelegate.h"

@interface ELCAlbumPickerController : UITableViewController <ELCAssetSelectionDelegate>

@property (nonatomic, weak) id<ELCAssetSelectionDelegate> parent;
@property (nonatomic, strong) NSMutableArray *assetGroups;
@property (nonatomic, strong) NSArray *mediaTypes;

// optional, can be used to filter the assets displayed
@property (nonatomic, weak) id<ELCAssetPickerFilterDelegate> assetPickerFilterDelegate;

@end

